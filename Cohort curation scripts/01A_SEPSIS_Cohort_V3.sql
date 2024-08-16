/*
Filename:
01A_SEPSIS_Cohort.sql

Purpose:
This script creates a cohort of patients for the SEPSIS registry.
The patient list is saved in the cohort table, along with other useful data elements.

Description:
This SQL script creates a cohort of hospitalized patients with sepsis
based on specific criteria. The script performs several steps to identify and filter
the patients before finally creating the cohort table. The script sets the context to
use a specific database, but the schema name is meant to be provided
by the user.

Dependencies:
None
*/

USE YOUR_DATABASE;

-- Drop all tables
DROP TABLE IF EXISTS [Results].[Sepsis_Cohort]; -- Change schema as appropriate
DROP TABLE IF EXISTS #sepsis_diagnosis;
DROP TABLE IF EXISTS #inpat;
DROP TABLE IF EXISTS #Vis_Occ;

-- Create cohort table (again specify schema as appropriate)
CREATE TABLE [Results].[Sepsis_Cohort] (
    [person_id] [int] NOT NULL,
    [visit_occurrence_id] [int] NOT NULL,
    [visit_start_date] [date] NOT NULL,
    [visit_end_date] [date] NOT NULL,
     NULL,
     NULL
) ON [PRIMARY];

-- First identify patients (inpatient and outpatient) with sepsis diagnosis
SELECT DISTINCT
    person_id,
    condition_start_date AS diagnosis_date
INTO #sepsis_diagnosis
FROM dbo.CONDITION_OCCURRENCE
WHERE condition_concept_id IN (
    SELECT c.concept_id
    FROM dbo.CONCEPT AS c
    INNER JOIN dbo.CONCEPT_ANCESTOR AS ca ON c.concept_id = ca.descendant_concept_id
    WHERE ca.ancestor_concept_id = 132797
    AND c.invalid_reason IS NULL
)
AND condition_start_date >= DATEFROMPARTS(2020, 01, 01);

-- Show counts of unique sepsis diagnoses (not unique patients)
SELECT COUNT(*) AS "sepsis_diagnosis_count" FROM #sepsis_diagnosis;

-- Show count of unique patients so far
SELECT COUNT(DISTINCT person_id) AS "sepsis_positive_person_count" FROM #sepsis_diagnosis;

-- Sepsis patients with inpatient encounters
SELECT
    v.person_id,
    v.visit_occurrence_id,
    v.visit_start_date,
    v.visit_end_date
INTO #inpat
FROM visit_occurrence AS v
INNER JOIN #sepsis_diagnosis AS sd ON v.person_id = sd.person_id
WHERE v.visit_concept_id IN (9201, 262) -- Inpatient visit/ED and inpatient visit
AND v.visit_start_date >= '2020-01-01'
AND (
    DATEDIFF(DAY, sd.diagnosis_date, v.visit_start_date) > -7
    AND DATEDIFF(DAY, sd.diagnosis_date, v.visit_start_date) < 21
);

-- Count of patients and encounters that meet the criteria
SELECT
    COUNT(DISTINCT person_id) AS "sepsis_inpatients",
    COUNT(DISTINCT visit_occurrence_id) AS "sepsis_inpatient_visits"
FROM #inpat;

-- Create cohort table with birth and death dates
SELECT
    i.person_id,
    i.visit_occurrence_id,
    i.visit_start_date,
    i.visit_end_date,
    p.birth_datetime,
    d.death_datetime
INTO #Vis_Occ
FROM #inpat AS i
INNER JOIN person AS p ON i.person_id = p.person_id
LEFT JOIN death AS d ON i.person_id = d.person_id;

-- Inserts the cohort into the final table
INSERT INTO [Results].[Sepsis_Cohort] -- Change schema if not using Results
(
    [person_id], [visit_occurrence_id], [visit_start_date], [visit_end_date],
    [birth_datetime], [death_datetime]
)
SELECT
    v.[person_id],
    v.[visit_occurrence_id],
    v.[visit_start_date],
    v.[visit_end_date],
    v.[birth_datetime],
    v.[death_datetime]
FROM #Vis_Occ AS v;

-- Final count of patients
SELECT COUNT(DISTINCT person_id) AS "Final_patient_count" FROM #Vis_Occ;

-- View data
SELECT TOP 100 *
FROM [Results].[Sepsis_Cohort];
