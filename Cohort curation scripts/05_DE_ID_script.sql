/*
Filename:
05_DE_ID_script.sql

Purpose:
This script creates a copy of the Cohort and removes identifying characteristics
to prepare the data for sharing with the VIRUS registry.


Description:
Run this file to generate a deidentified copy of your target data. Insert your data
into the OMOP tables, and de-identify person_id, and date fields using date.shift.
If a person is 90 years of age or older, assign a random age between 90-99 years.

Dependencies:
01_CURE_ID_Cohort.sql
02_CURE_ID_All_Tables.sql
03_CURE_ID_replace_rare_conditions_with_parents.sql
04_DE_ID_CDM_Table_ddl.sql
*/


/******* VARIABLES *******/
--SOURCE_SCHEMA: Results
--TARGET_SCHEMA: [Results]
DECLARE @START_DATE DATE = CAST('2016-01-01' AS DATE)
DECLARE @END_DATE DATE = CAST('2029-12-31' AS DATE)


/******* GENERATE MAP TABLES *******/

--Tables are dropped and created in a separate script.
--Please run that script first.

USE YOUR_DATABASE;


/******* GENERATE MAP TABLES *******/
INSERT INTO [Results].[source_id_person]
SELECT
    person_id AS sourceKey,
    ROW_NUMBER() OVER (ORDER BY p.gender_concept_id, person_id DESC) AS id,
    (FLOOR(RAND(CONVERT(VARBINARY, NEWID())) * 367)) - 183 AS date_shift,
    CAST((DATEPART(YEAR, GETDATE()) - 90 - (FLOOR(RAND(CONVERT(VARBINARY, NEWID())) * 10))) AS INT) AS over_89_birth_year --If a person is > 89, then assign them a random age between 90 - 99
FROM [Results].[CURE_ID_Person] AS p;

INSERT INTO [Results].[source_id_visit]
SELECT
    visit_occurrence_id AS sourceKey,
    ROW_NUMBER() OVER (ORDER BY p.visit_occurrence_id) AS new_id
FROM [Results].[CURE_ID_Visit_Occurrence] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id --Ask Ben about this self join?
WHERE v.new_id IS NULL AND (
    DATEADD(DAY, s.date_shift, visit_start_date) >= @START_DATE
    AND DATEADD(DAY, s.date_shift, visit_end_date) <= @END_DATE
)
ORDER BY p.person_id, p.visit_start_date;

/******* PERSON *******/
INSERT INTO [Results].[deident_CURE_ID_Person]
SELECT
    s.id AS person_id,
    gender_concept_id,
    CASE
        WHEN DATEDIFF(DAY, p.birth_datetime, GETDATE()) / 365.25 > 89 THEN s.over_89_birth_year
        ELSE DATEPART(YEAR, DATEADD(DAY, s.date_shift, p.birth_datetime))
    END AS year_of_birth,
    DATEPART(MONTH, DATEADD(DAY, s.date_shift, p.birth_datetime)) AS month_of_birth,
    1 AS day_of_birth,
    DATEFROMPARTS(
        CASE WHEN DATEDIFF(DAY, p.birth_datetime, GETDATE()) / 365.25 > 89 THEN s.over_89_birth_year ELSE DATEPART(YEAR, DATEADD(DAY, s.date_shift, p.birth_datetime)) END,
        DATEPART(MONTH, DATEADD(DAY, s.date_shift, p.birth_datetime)),
        1
    ) AS birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    1 AS location_id,
    1 AS provider_id,
    1 AS care_site_id,
    0 AS person_source_value,
    0 AS gender_source_value,
    0 AS gender_source_concept_id,
    0 AS race_source_value,
    0 AS race_source_concept_id,
    0 AS ethnicity_source_value,
    0 AS ethnicity_source_concept_id
FROM [Results].[CURE_ID_Person] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id;

/******* VISIT *******/
INSERT INTO [Results].[deident_CURE_ID_Visit_Occurrence]
SELECT
    v.new_id AS visit_occurrence_id,
    s.id AS person_id,
    visit_concept_id,
    DATEADD(DAY, s.date_shift, visit_start_date) AS visit_start_date,
    DATEADD(DAY, s.date_shift, visit_start_datetime) AS visit_start_datetime,
    DATEADD(DAY, s.date_shift, visit_end_date) AS visit_end_date,
    DATEADD(DAY, s.date_shift, visit_end_datetime) AS visit_end_datetime,
    visit_type_concept_id,
    1 AS provider_id,
    1 AS care_site_id,
    NULL AS visit_source_value,
    visit_source_concept_id,
    admitted_from_concept_id,
    NULL AS admitted_from_source_value,
    discharged_to_concept_id,
    NULL AS discharged_to_source_value,
    preceding_visit_occurrence_id
FROM [Results].[CURE_ID_Visit_Occurrence] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (DATEADD(DAY, s.date_shift, visit_start_date) >= @START_DATE AND DATEADD(DAY, s.date_shift, visit_end_date) <= @END_DATE);

/******* CONDITION OCCURENCE *******/
INSERT INTO [Results].[deident_CURE_ID_Condition_Occurrence]
SELECT
    condition_occurrence_id,
    s.id AS person_id,
    condition_concept_id,
    DATEADD(DAY, s.date_shift, condition_start_date) AS condition_start_date,
    DATEADD(DAY, s.date_shift, condition_start_datetime) AS condition_start_datetime,
    DATEADD(DAY, s.date_shift, condition_end_date) AS condition_end_date,
    DATEADD(DAY, s.date_shift, condition_end_datetime) AS condition_end_datetime,
    condition_type_concept_id,
    stop_reason,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    condition_source_value,
    condition_source_concept_id,
    condition_status_source_value,
    condition_status_concept_id
FROM [Results].[CURE_ID_Condition_Occurrence_Rare_Removed] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, condition_start_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, COALESCE(condition_end_date, condition_start_date)) > @START_DATE
);

/******* PROCEDURE OCCURENCE *******/
INSERT INTO [Results].[deident_CURE_ID_Procedure_Occurrence]
SELECT
    procedure_occurrence_id,
    s.id AS person_id,
    procedure_concept_id,
    DATEADD(DAY, s.date_shift, procedure_date) AS procedure_date,
    DATEADD(DAY, s.date_shift, procedure_date) AS procedure_datetime,
    procedure_type_concept_id,
    modifier_concept_id,
    quantity,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    procedure_source_value,
    procedure_source_concept_id,
    modifier_source_value
FROM [Results].[CURE_ID_Procedure_Occurrence] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, procedure_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, procedure_date) > @START_DATE
);


/******* DRUG EXPOSURE *******/
INSERT INTO [Results].[deident_CURE_ID_Drug_Exposure]
SELECT
    drug_exposure_id,
    s.id AS person_id,
    drug_concept_id,
    DATEADD(DAY, s.date_shift, drug_exposure_start_date) AS drug_exposure_start_date,
    DATEADD(DAY, s.date_shift, drug_exposure_start_date) AS drug_exposure_start_datetime,
    DATEADD(DAY, s.date_shift, drug_exposure_end_date) AS drug_exposure_end_date,
    DATEADD(DAY, s.date_shift, drug_exposure_end_date) AS drug_exposure_end_datetime,
    DATEADD(DAY, s.date_shift, verbatim_end_date) AS verbatim_end_date,
    drug_type_concept_id,
    stop_reason,
    refills,
    quantity,
    days_supply,
    sig,
    route_concept_id,
    lot_number,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    drug_source_value,
    drug_source_concept_id,
    route_source_value,
    dose_unit_source_value
FROM [Results].[CURE_ID_Drug_Exposure] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, drug_exposure_start_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, drug_exposure_end_date) > @START_DATE
);

/******* OBSERVATION *******/
INSERT INTO [Results].[deident_CURE_ID_Observation]
SELECT
    observation_id,
    s.id AS person_id,
    observation_concept_id,
    DATEADD(DAY, s.date_shift, observation_date) AS observation_date,
    DATEADD(DAY, s.date_shift, observation_date) AS observation_datetime,
    observation_type_concept_id,
    value_as_number,
    value_as_string,
    value_as_concept_id,
    qualifier_concept_id,
    unit_concept_id,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    observation_source_value,
    observation_source_concept_id,
    unit_source_value,
    qualifier_source_value
FROM [Results].[CURE_ID_Observation] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, observation_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, observation_date) > @START_DATE
);

/******* DEATH *******/
INSERT INTO [Results].[deident_CURE_ID_Death]
SELECT
    s.id AS person_id,
    DATEADD(DAY, s.date_shift, death_date) AS death_date,
    DATEADD(DAY, s.date_shift, death_date) AS death_datetime,
    death_type_concept_id,
    cause_concept_id,
    cause_source_value,
    cause_source_concept_id
FROM [Results].[CURE_ID_Death] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id;

/******* DEVICE EXPOSURE *******/
INSERT INTO [Results].[deident_CURE_ID_Device_Exposure]
SELECT
    device_exposure_id,
    s.id AS person_id,
    device_concept_id,
    DATEADD(DAY, s.date_shift, device_exposure_start_date) AS device_exposure_start_date,
    DATEADD(DAY, s.date_shift, device_exposure_start_date) AS device_exposure_start_datetime,
    DATEADD(DAY, s.date_shift, device_exposure_end_date) AS device_exposure_end_date,
    DATEADD(DAY, s.date_shift, device_exposure_end_date) AS device_exposure_end_datetime,
    device_type_concept_id,
    unique_device_id,
    quantity,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    device_source_value,
    device_source_concept_id
FROM [Results].[CURE_ID_Device_Exposure] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, device_exposure_start_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, COALESCE(device_exposure_end_date, device_exposure_start_date)) > @START_DATE
);


/******* MEASUREMENT *******/
INSERT INTO [Results].[deident_CURE_ID_Measurement]
SELECT
    measurement_id,
    s.id AS person_id,
    measurement_concept_id,
    DATEADD(DAY, s.date_shift, measurement_date) AS measurement_date,
    DATEADD(DAY, s.date_shift, measurement_date) AS measurement_datetime,
    measurement_time,
    measurement_type_concept_id,
    operator_concept_id,
    value_as_number,
    value_as_concept_id,
    unit_concept_id,
    range_low,
    range_high,
    1 AS provider_id,
    v.new_id AS visit_occurrence_id,
    visit_detail_id,
    measurement_source_value,
    measurement_source_concept_id,
    unit_source_value,
    value_source_value
FROM [Results].[CURE_ID_Measurement] AS p
INNER JOIN [Results].[source_id_person] AS s ON s.sourceKey = p.person_id
LEFT JOIN [Results].[source_id_visit] AS v ON v.sourceKey = p.visit_occurrence_id
WHERE (
    DATEADD(DAY, s.date_shift, measurement_date) < @END_DATE
    AND DATEADD(DAY, s.date_shift, measurement_date) > @START_DATE
);

