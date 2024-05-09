/*
Filename:
02_CURE_ID_All_Tables.sql

Purpose:
This script takes your OMOP dataset and generates a copy of key tables that have
been filtered down to only include people and records related to the CURE ID registry.

Description:
Creates CURE_ID tables from the generated CURE_ID cohort.

Dependencies:
01_CURE_ID_Cohort.sql
*/

USE YOUR_DATABASE;

--Drop existing tables
DROP TABLE IF EXISTS [Results].[CURE_ID_Person];
DROP TABLE IF EXISTS [Results].[CURE_ID_Measurement];
DROP TABLE IF EXISTS [Results].[CURE_ID_Drug_Exposure];
DROP TABLE IF EXISTS [Results].[CURE_ID_Death];
DROP TABLE IF EXISTS [Results].[CURE_ID_Observation];
DROP TABLE IF EXISTS [Results].[CURE_ID_Procedure_Occurrence];
DROP TABLE IF EXISTS [Results].[CURE_ID_Condition_Occurrence];
DROP TABLE IF EXISTS [Results].[CURE_ID_Visit_Occurrence];
DROP TABLE IF EXISTS [Results].[CURE_ID_Device_Exposure];

--Load person table
SELECT
    pe.person_id,
    pe.gender_concept_id,
    pe.year_of_birth,
    pe.month_of_birth,
    pe.day_of_birth,
    pe.birth_datetime,
    pe.race_concept_id,
    pe.ethnicity_concept_id,
    pe.location_id,
    pe.provider_id,
    pe.care_site_id,
    NULL AS person_source_value,
    NULL AS gender_source_value,
    pe.gender_source_concept_id,
    NULL AS race_source_value,
    pe.race_source_concept_id,
    NULL AS ethnicity_source_value,
    pe.ethnicity_source_concept_id
INTO [Results].[CURE_ID_Person]
FROM person AS pe
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON pe.person_id = coh.person_id

--Load measurements table
SELECT DISTINCT
    m.measurement_id,
    m.person_id,
    m.measurement_concept_id,
    m.measurement_date,
    m.measurement_datetime,
    m.measurement_time,
    m.measurement_type_concept_id,
    m.operator_concept_id,
    m.value_as_number,
    m.value_as_concept_id,
    m.unit_concept_id,
    m.range_low,
    m.range_high,
    m.provider_id,
    m.visit_occurrence_id,
    m.visit_detail_id,
    NULL AS measurement_source_value,
    m.measurement_source_concept_id,
    NULL AS unit_source_value,
    m.unit_source_concept_id,
    NULL AS value_source_value,
    m.measurement_event_id,
    m.meas_event_field_concept_id
INTO [Results].[CURE_ID_Measurement]
FROM measurement AS m
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        m.person_id = coh.person_id
        AND m.measurement_date BETWEEN DATEADD(DAY, -1, coh.visit_start_date) AND DATEADD(DAY, 1, coh.visit_end_date)
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = m.measurement_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Measurement'
    AND ([Results].[cure_id_concepts]include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)

--Load drug_exposure table
SELECT
    d.drug_exposure_id,
    d.person_id,
    d.drug_concept_id,
    d.drug_exposure_start_date,
    d.drug_exposure_start_datetime,
    d.drug_exposure_end_date,
    d.drug_exposure_end_datetime,
    d.verbatim_end_date,
    d.drug_type_concept_id,
    d.stop_reason,
    d.refills,
    d.quantity,
    d.days_supply,
    d.sig,
    d.route_concept_id,
    d.lot_number,
    d.provider_id,
    d.visit_occurrence_id,
    d.visit_detail_id,
    NULL AS drug_source_value,
    d.drug_source_concept_id,
    NULL AS route_source_value,
    NULL AS dose_unit_source_value
INTO [Results].[CURE_ID_Drug_exposure]
FROM drug_exposure AS d
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        d.person_id = coh.person_id
        AND d.drug_exposure_start_date BETWEEN DATEADD(DAY, -1, coh.visit_start_date) AND DATEADD(DAY, 1, coh.visit_end_date)
INNER JOIN concept AS con
    ON con.concept_id = d.drug_concept_id
ORDER BY
    coh.person_id,
    d.drug_exposure_start_datetime

--Load Death table
SELECT
    death.person_id,
    death.death_date,
    death.death_datetime,
    death.death_type_concept_id,
    death.cause_concept_id,
    NULL AS cause_source_value,
    death.cause_source_concept_id
INTO [Results].[CURE_ID_Death]
FROM death
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON death.person_id = coh.person_id

--Load Observation data
SELECT DISTINCT
    o.observation_id,
    o.person_id,
    o.observation_concept_id,
    o.observation_date,
    o.observation_datetime,
    o.observation_type_concept_id,
    o.value_as_number,
    o.value_as_string,
    o.value_as_concept_id,
    o.qualifier_concept_id,
    o.unit_concept_id,
    o.provider_id,
    o.visit_occurrence_id,
    o.visit_detail_id,
    NULL AS observation_source_value,
    o.observation_source_concept_id,
    NULL AS unit_source_value,
    NULL AS qualifier_source_value,
    NULL AS value_source_value,
    o.observation_event_id,
    o.obs_event_field_concept_id
INTO [Results].[CURE_ID_Observation]
FROM observation AS o
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        o.person_id = coh.person_id
        AND o.observation_date BETWEEN DATEADD(YEAR, -1, coh.visit_start_date) AND DATEADD(YEAR, 1, coh.visit_end_date)
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = o.observation_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Observation'
    AND ([Results].[cure_id_concepts].include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)

--Load Procedure Occurrence Table
SELECT
    p.procedure_occurrence_id,
    p.person_id,
    p.procedure_concept_id,
    p.procedure_date,
    p.procedure_datetime,
    p.procedure_end_date,
    p.procedure_end_datetime,
    p.procedure_type_concept_id,
    p.modifier_concept_id,
    p.quantity,
    p.provider_id,
    p.visit_occurrence_id,
    p.visit_detail_id,
    NULL AS procedure_source_value,
    p.procedure_source_concept_id,
    NULL AS modifier_source_value
INTO [Results].[CURE_ID_Procedure_Occurrence]
FROM procedure_occurrence AS p
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        p.person_id = coh.person_id
        AND p.procedure_date BETWEEN DATEADD(DAY, -1, coh.visit_start_date) AND DATEADD(DAY, 1, coh.visit_end_date)
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = p.procedure_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Procedure'
    AND ([Results].[cure_id_concepts].include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)

--Load Condition Occurrence table
SELECT
    c.condition_occurrence_id,
    c.person_id,
    c.condition_concept_id,
    c.condition_start_date,
    c.condition_start_datetime,
    c.condition_end_date,
    c.condition_end_datetime,
    c.condition_type_concept_id,
    c.condition_status_concept_id,
    c.stop_reason,
    c.provider_id,
    c.visit_occurrence_id,
    c.visit_detail_id,
    NULL AS condition_source_value,
    c.condition_source_concept_id,
    NULL AS condition_status_source_value
INTO [Results].[CURE_ID_Condition_Occurrence]
FROM condition_occurrence AS c
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        c.person_id = coh.person_id
        AND (
            c.condition_start_date < coh.visit_end_date
            OR c.condition_end_date > coh.visit_start_date
            OR c.condition_end_date IS NULL
        )
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = c.condition_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Condition'
    AND ([Results].[cure_id_concepts].include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)

--Load Visit Occurrence table
SELECT DISTINCT
    v.visit_occurrence_id,
    v.person_id,
    v.visit_concept_id,
    v.visit_start_date,
    v.visit_start_datetime,
    v.visit_end_date,
    v.visit_end_datetime,
    v.visit_type_concept_id,
    v.provider_id,
    v.care_site_id,
    NULL AS visit_source_value,
    v.visit_source_concept_id,
    v.admitted_from_concept_id,
    NULL AS admitted_from_source_value,
    v.discharged_to_concept_id,
    NULL AS discharged_to_source_value,
    v.preceding_visit_occurrence_id
INTO [Results].[CURE_ID_Visit_Occurrence]
FROM visit_occurrence AS v
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        v.person_id = coh.person_id
        AND v.visit_occurrence_id = coh.visit_occurrence_id
WHERE v.visit_start_date >= '2020-03-01'

--Load Device Exposure table
SELECT
    dev.device_exposure_id,
    dev.person_id,
    dev.device_concept_id,
    dev.device_exposure_start_date,
    dev.device_exposure_start_datetime,
    dev.device_exposure_end_date,
    dev.device_exposure_end_datetime,
    dev.device_type_concept_id,
    dev.unique_device_id,
    dev.production_id,
    dev.quantity,
    dev.provider_id,
    dev.visit_occurrence_id,
    dev.visit_detail_id,
    NULL AS device_source_value,
    dev.device_source_concept_id,
    dev.unit_concept_id,
    NULL AS unit_source_value,
    dev.unit_source_concept_id
INTO [Results].[CURE_ID_Device_Exposure]
FROM device_exposure AS dev
INNER JOIN [Results].[CURE_ID_Cohort] AS coh
    ON
        dev.person_id = coh.person_id
        AND dev.device_exposure_start_date BETWEEN DATEADD(DAY, -1, coh.visit_start_date) AND DATEADD(DAY, 1, coh.visit_end_date)
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = dev.device_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Device'
    AND ([Results].[cure_id_concepts].include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)
