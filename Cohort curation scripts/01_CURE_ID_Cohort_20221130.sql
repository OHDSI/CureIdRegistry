/*
FDA CURE ID Cohort Script
This script creates a cohort of covid-positive, hospitalized patients.
Run this script first, then create your subsetted tables using the CURE_ID_All_Tables.sql script
Will need to designate the name of your own OMOP database, and schema you want results to be loaded into.
*/
USE [JHCrown_OMOP] --Change database name as appropriate

--Drop all tables
DROP TABLE IF EXISTS results.CURE_ID_Cohort; --Change schema as appropriate
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
   [person_id] [int] NOT NULL, [visit_occurrence_id] [int] NOT NULL, [visit_start_date] [date] NOT NULL, 
   [visit_end_date] [date] NOT NULL, [First_Pos_Date] [date] NULL, [Days_From_First_Pos] [int] NULL, 
   [Abs_Days_From_First_Pos] [int] NULL, [Before_Or_After] [int] NOT NULL,
   [birth_datetime] [datetime2](7) NULL, [death_datetime] [datetime2](7) NULL
   ) ON [PRIMARY];


--First identify patients (inpatient and outpatient) with covid positive lab results
SELECT DISTINCT person_id
   ,measurement_date
INTO #covid_lab_pos
FROM dbo.MEASUREMENT
WHERE measurement_concept_id IN (
      SELECT concept_id
      FROM dbo.CONCEPT
      -- here we look for the concepts that represent the LOINC codes for SARS-COV-2 nucleic acid test
      WHERE concept_id IN (
            '706169', '706156', '706154', '706170', '706157', '706155', '706173', '706175', '706163', 
            '706167', '706168', '706158', '706161', '706160', '723478', '723476', '723464', '723465', 
            '723466', '723467', '723468', '723469', '723470', '723471', '723463', '586528', '586529', 
            '586524', '586525', '586526', '715272', '586517', '586520', '586519', '715262', '715261', 
            '715260', '757677', '757678', '36661377', '36661378', '36661370', '36661371', '36031238', 
            '36031213', '36031506', '36032061', '36031944', '36032174', '36031652', '36031453', '36032258'
            )
      
      UNION
      
      SELECT c.concept_id
      FROM dbo.CONCEPT c
      INNER JOIN dbo.CONCEPT_ANCESTOR ca ON c.concept_id = ca.descendant_concept_id
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
         4126681 -- Detected
         , 45877985 -- Detected
         , 45884084 -- Positive
         , 9191 --- Positive 
         , 4181412 -- Present
         , 45879438 -- Present
         , 45881802 -- Reactive
         )
      -- To be exhaustive, we also look for Positive strings in the value_source_value field
      OR value_source_value IN ('Positive', 'Present', 'Detected', 'Reactive')
      );

--Show counts of unique covid-positive labs (not unique patients)
select count(*) "covid_positive_lab_count" from #covid_lab_pos;

--First positive test per patient
SELECT person_id
   ,min(measurement_date) "First_Pos_Date"
INTO #first_pos
FROM #covid_lab_pos
GROUP BY person_id;

--Show count of unique patients so far
select count(distinct person_id) "covid_positive_lab_person_count" from #first_pos;

--Covid-positive patients with inpatient encounters (intermediate table for debugging)
SELECT v.person_id
   ,v.visit_occurrence_id
   ,visit_start_date
   ,visit_end_date
   ,p.First_Pos_Date
   ,DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) "Days_From_First_Pos"
   ,ABS(DATEDIFF(day, p.First_Pos_Date, v.visit_start_date)) "Abs_Days_From_First_Pos"
INTO #inpat_intermed
FROM visit_occurrence v
INNER JOIN #first_pos p ON v.person_id = p.person_id
WHERE visit_concept_id in (9201,262); --Inpatient visit/ED and inpt visit

--Intermediate count of Covid-positive patients with inpatient encounters
select count(distinct person_id) "covid_pos_inpatients_count" from #inpat_intermed;

--Count of patients after temporal constraints applied
Select count(distinct person_id) "covid_pos_inpatients_date_filtered_count"
from #inpat_intermed
WHERE visit_start_date >= '2020-01-01'
   AND (
      DATEDIFF(day, First_Pos_Date, visit_start_date) > - 7
      AND DATEDIFF(day, First_Pos_Date, visit_start_date) < 21
      )

--Apply all incl/excl criteria to identify all patients hospitalized with symptomatic covid-19 up to 21 days after a positive SARS-CoV-2 test or up to 7 days prior to a positive SARS-CoV-2 test
SELECT v.person_id
   ,v.visit_occurrence_id
   ,visit_start_date
   ,visit_end_date
   ,p.First_Pos_Date
   ,DATEDIFF(MINUTE, v.visit_start_datetime, v.visit_end_datetime) "Length_Of_Stay"
   ,DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) "Days_From_First_Pos"
   ,ABS(DATEDIFF(day, p.First_Pos_Date, v.visit_start_date)) "Abs_Days_From_First_Pos"
   ,CASE 
      WHEN DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) < 0
         THEN - 1
      ELSE 1
      END AS Before_Or_After
INTO #inpat
FROM visit_occurrence v
INNER JOIN #first_pos p ON v.person_id = p.person_id
WHERE visit_concept_id in (9201,262) --Inpatient visit/ED and inpt visit
   AND v.visit_start_date >= '2020-01-01'
   AND (
      DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) > - 7
      AND DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) < 21
      );

--Count of patients and encounters that meet the criteria
SELECT count(DISTINCT person_id) "covid_pos_inpatients", 
count(DISTINCT visit_occurrence_id) "covid_pos_inpatient_visits"
FROM #inpat;

--Finds closest encounter to first positive SARS-COV-2 test (for patients hospitalized more than once)
SELECT person_id
   ,min(Abs_Days_From_First_Pos) "Closest_Vis"
INTO #inpat_closest_vis
FROM #inpat
GROUP BY person_id;

--Account for edge cases where patients have two hospitalizations same number of absolute days from SARS-COV-2 test
--Ex: Patient hospitalized separately 3 days before and 3 days after SARS-COV-2 test
SELECT i.person_id
   ,max(Before_Or_After) "Flag"
INTO #inpat_first_vis
FROM #inpat i
INNER JOIN #inpat_closest_vis v ON i.person_id = v.person_id
   AND i.Abs_Days_From_First_Pos = v.Closest_Vis
GROUP BY i.person_id;

--Create flag for longest LOs per person per visit_start_date
SELECT i.person_id, visit_start_date
   ,max(Length_Of_Stay) "max_los"
INTO #los
FROM #inpat i
GROUP BY i.person_id, i.visit_start_date;

--Apply criteria in sequence
SELECT i.*
INTO #closest_vis
FROM #inpat i
INNER JOIN #inpat_closest_vis c ON i.person_id = c.person_id
   AND i.Abs_Days_From_First_Pos = c.Closest_Vis;

SELECT i.*
INTO #first_vis
FROM #closest_vis i
INNER JOIN #inpat_first_vis v ON i.person_id = v.person_id
   AND i.Before_Or_After = v.Flag;

SELECT i.*
INTO #los_max
FROM #first_vis i
INNER JOIN #los los ON i.person_id = los.person_id
   AND i.visit_start_date = los.visit_start_date
   AND i.Length_Of_Stay = los.max_los;

--Make cohort table
SELECT v.*, p.birth_datetime, d.death_datetime
INTO #Vis_Occ
FROM #los_max v
INNER JOIN person p ON v.person_id = p.person_id
LEFT JOIN death d ON v.person_id = d.person_id;

--Creates cohort by adding on birth date and death date
INSERT INTO [Results].[CURE_ID_Cohort] --Change schema if not using Results
   (
   [person_id], [visit_occurrence_id], [visit_start_date], [visit_end_date], [First_Pos_Date], 
   [Days_From_First_Pos], [Abs_Days_From_First_Pos], [Before_Or_After], 
   [birth_datetime], [death_datetime]
   )
SELECT v.*
FROM #Vis_Occ v;

--Final count of patients
Select count(distinct person_id) "Final_patient_count" from #Vis_Occ;

--View data
SELECT TOP 100 *
FROM Results.CURE_ID_Cohort