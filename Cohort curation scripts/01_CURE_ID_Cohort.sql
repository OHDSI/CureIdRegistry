/*
Filename:
01_CURE_ID_Cohort.sql

Purpose:
This script creates a cohort of patients for the CURE ID registry.
The patient list is saved in the cohort table, along with other useful data elements.

Description:
This SQL script creates a cohort of COVID-positive hospitalized patients
based on specific criteria. The script performs several steps to identify and filter
the patients before finally creating the cohort table. The script sets the context to
use a specific database, but the actual name of the database is meant to be provided
by the user.

Dependencies:
None
*/

USE YOUR_DATABASE;

--Drop all tables
DROP TABLE IF EXISTS [Results].[CURE_ID_Cohort]; --Change schema as appropriate
DROP TABLE IF EXISTS #covid_lab_pos;
DROP TABLE IF EXISTS #first_pos;
DROP TABLE IF EXISTS #inpat_intermed;
DROP TABLE IF EXISTS #inpat;
DROP TABLE IF EXISTS #inpat_closest_vis;
DROP TABLE IF EXISTS #inpat_first_vis;
DROP TABLE IF EXISTS #los;
DROP TABLE IF EXISTS #closest_vis;
DROP TABLE IF EXISTS #first_vis;
DROP TABLE IF EXISTS #los_max;
DROP TABLE IF EXISTS #Vis_Occ;


--Create cohort table (again specify schema as appropriate)
CREATE TABLE [Results].[CURE_ID_Cohort] (
    [person_id] [int] NOT NULL,
    [visit_occurrence_id] [int] NOT NULL,
    [visit_start_date] [date] NOT NULL,
    [visit_end_date] [date] NOT NULL,
    [First_Pos_Date] [date] NULL,
    [Days_From_First_Pos] [int] NULL,
    [Abs_Days_From_First_Pos] [int] NULL,
    [Before_Or_After] [int] NOT NULL,
    [birth_datetime] [datetime2](7) NULL,
    [death_datetime] [datetime2](7) NULL
) ON [PRIMARY];


--First identify patients (inpatient and outpatient) with covid positive lab results
SELECT DISTINCT
    person_id,
    measurement_date
INTO #covid_lab_pos
FROM dbo.MEASUREMENT
WHERE measurement_concept_id IN (
    SELECT concept_id
    FROM dbo.CONCEPT
    -- here we look for the concepts that represent the LOINC codes for SARS-COV-2 nucleic acid test
    WHERE
        concept_id IN (
            '706169', '706156', '706154', '706170', '706157', '706155', '706173', '706175', '706163',
            '706167', '706168', '706158', '706161', '706160', '723478', '723476', '723464', '723465',
            '723466', '723467', '723468', '723469', '723470', '723471', '723463', '586528', '586529',
            '586524', '586525', '586526', '715272', '586517', '586520', '586519', '715262', '715261',
            '715260', '757677', '757678', '36661377', '36661378', '36661370', '36661371', '36031238',
            '36031213', '36031506', '36032061', '36031944', '36032174', '36031652', '36031453', '36032258' , '4263457'
        )
    UNION
    SELECT c.concept_id
    FROM dbo.CONCEPT AS c
    INNER JOIN dbo.CONCEPT_ANCESTOR AS ca ON c.concept_id = ca.descendant_concept_id
    -- Most of the LOINC codes do not have descendants but there is one OMOP Extension code (765055) in use that has descendants which we want to pull
    -- This statement pulls the descendants of that specific code
    AND ca.ancestor_concept_id IN (756055)
    AND c.invalid_reason IS NULL
)
-- Here we add a date restriction: after January 1, 2020
AND measurement_date >= DATEFROMPARTS(2020, 01, 01)
AND (
    -- The value_as_concept field is where we store standardized qualitative results
    -- The concept ids here represent LOINC or SNOMED codes for standard ways to code a lab that is positive
    value_as_concept_id IN (
        4126681, -- Detected
        45877985, -- Detected
        45884084, -- Positive
        9191, --- Positive
        4181412, -- Present
        45879438, -- Present
        45881802 -- Reactive
    )
    -- To be exhaustive, we also look for Positive strings in the value_source_value field
    OR value_source_value IN ('Positive', 'Present', 'Detected', 'Reactive')
);

--Show counts of unique covid-positive labs (not unique patients)
SELECT COUNT(*) AS "covid_positive_lab_count" FROM #covid_lab_pos;

--First positive test per patient
SELECT
    person_id,
    MIN(measurement_date) AS "First_Pos_Date"
INTO #first_pos
FROM #covid_lab_pos
GROUP BY person_id;

--Show count of unique patients so far
SELECT COUNT(DISTINCT person_id) AS "covid_positive_lab_person_count" FROM #first_pos;

--Covid-positive patients with inpatient encounters (intermediate table for debugging)
SELECT
    v.person_id,
    v.visit_occurrence_id,
    visit_start_date,
    visit_end_date,
    p.First_Pos_Date,
    DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date) AS "Days_From_First_Pos",
    ABS(DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date)) AS "Abs_Days_From_First_Pos"
INTO #inpat_intermed
FROM visit_occurrence AS v
INNER JOIN #first_pos AS p ON v.person_id = p.person_id
WHERE visit_concept_id IN (9201, 262); --Inpatient visit/ED and inpt visit

--Intermediate count of Covid-positive patients with inpatient encounters
SELECT COUNT(DISTINCT person_id) AS "covid_pos_inpatients_count" FROM #inpat_intermed;

--Count of patients after temporal constraints applied
SELECT COUNT(DISTINCT person_id) AS "covid_pos_inpatients_date_filtered_count"
FROM #inpat_intermed
WHERE
    visit_start_date >= '2020-01-01'
    AND (
        DATEDIFF(DAY, First_Pos_Date, visit_start_date) > -7
        AND DATEDIFF(DAY, First_Pos_Date, visit_start_date) < 21
    )

--Apply all incl/excl criteria to identify all patients hospitalized with symptomatic covid-19 up to 21 days after a positive SARS-CoV-2 test or up to 7 days prior to a positive SARS-CoV-2 test
SELECT
    v.person_id,
    v.visit_occurrence_id,
    visit_start_date,
    visit_end_date,
    p.First_Pos_Date,
    DATEDIFF(MINUTE, v.visit_start_datetime, v.visit_end_datetime) AS "Length_Of_Stay",
    DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date) AS "Days_From_First_Pos",
    ABS(DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date)) AS "Abs_Days_From_First_Pos",
    CASE
        WHEN DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date) < 0 THEN -1
        ELSE 1
    END AS Before_Or_After
INTO #inpat
FROM visit_occurrence AS v
INNER JOIN #first_pos AS p ON v.person_id = p.person_id
WHERE
    visit_concept_id IN (9201, 262) --Inpatient visit/ED and inpt visit
    AND v.visit_start_date >= '2020-01-01'
    AND (
        DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date) > -7
        AND DATEDIFF(DAY, p.First_Pos_Date, v.visit_start_date) < 21
    );

--Count of patients and encounters that meet the criteria
SELECT
    COUNT(DISTINCT person_id) AS "covid_pos_inpatients",
    COUNT(DISTINCT visit_occurrence_id) AS "covid_pos_inpatient_visits"
FROM #inpat;

--Finds closest encounter to first positive SARS-COV-2 test (for patients hospitalized more than once)
SELECT
    person_id,
    MIN(Abs_Days_From_First_Pos) AS "Closest_Vis"
INTO #inpat_closest_vis
FROM #inpat
GROUP BY person_id;

--Account for edge cases where patients have two hospitalizations same number of absolute days from SARS-COV-2 test
--Ex: Patient hospitalized separately 3 days before and 3 days after SARS-COV-2 test
SELECT
    i.person_id,
    MAX(Before_Or_After) AS "Flag"
INTO #inpat_first_vis
FROM #inpat AS i
INNER JOIN #inpat_closest_vis AS v
    ON
        i.person_id = v.person_id
        AND i.Abs_Days_From_First_Pos = v.Closest_Vis
GROUP BY i.person_id;

--Create flag for longest LOs per person per visit_start_date
SELECT
    i.person_id,
    visit_start_date,
    MAX(Length_Of_Stay) AS "max_los"
INTO #los
FROM #inpat AS i
GROUP BY i.person_id, i.visit_start_date;

--Apply criteria in sequence
SELECT i.*
INTO #closest_vis
FROM #inpat AS i
INNER JOIN #inpat_closest_vis
    AS c ON i.person_id = c.person_id
AND i.Abs_Days_From_First_Pos = c.Closest_Vis;

SELECT i.*
INTO #first_vis
FROM #closest_vis AS i
INNER JOIN #inpat_first_vis
    AS v ON i.person_id = v.person_id
AND i.Before_Or_After = v.Flag;

SELECT i.*
INTO #los_max
FROM #first_vis AS i
INNER JOIN #los
    AS los ON i.person_id = los.person_id
AND i.visit_start_date = los.visit_start_date
AND i.Length_Of_Stay = los.max_los;

--Make cohort table
SELECT
    v.*,
    p.birth_datetime,
    d.death_datetime
INTO #Vis_Occ
FROM #los_max AS v
INNER JOIN person AS p ON v.person_id = p.person_id
LEFT JOIN death AS d ON v.person_id = d.person_id;

--Creates cohort by adding on birth date and death date
INSERT INTO [Results].[CURE_ID_Cohort] --Change schema if not using Results
(
    [person_id], [visit_occurrence_id], [visit_start_date], [visit_end_date], [First_Pos_Date],
    [Days_From_First_Pos], [Abs_Days_From_First_Pos], [Before_Or_After],
    [birth_datetime], [death_datetime]
)
SELECT
    v.[person_id],
    v.[visit_occurrence_id],
    v.[visit_start_date],
    v.[visit_end_date],
    v.[First_Pos_Date],
    v.[Days_From_First_Pos],
    v.[Abs_Days_From_First_Pos],
    v.[Before_Or_After],
    v.[birth_datetime],
    v.[death_datetime]
FROM #Vis_Occ AS v;

--Final count of patients
SELECT COUNT(DISTINCT person_id) AS "Final_patient_count" FROM #Vis_Occ;

--View data
SELECT TOP 100 *
FROM [Results].[CURE_ID_Cohort]
