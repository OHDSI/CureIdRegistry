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
DROP TABLE IF EXISTS #dx_strong;
DROP TABLE IF EXISTS #dx_weak;
DROP TABLE IF EXISTS #dx_comb;
DROP TABLE IF EXISTS #inpat_intermed;
DROP TABLE IF EXISTS #inpat_intermed_temporal;
DROP TABLE IF EXISTS #inpat;
DROP TABLE IF EXISTS #inpat_closest_vis;
DROP TABLE IF EXISTS #inpat_first_vis;
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

--Phenotype Entry Criteria: visits with ONE or more of the Strong Positive diagnosis codes from the ICD-10 or SNOMED tables
--Strong diagnoses are codes that indicate symptomatic COVID-19
SELECT DISTINCT person_id, condition_start_date, condition_end_date
INTO #dx_strong
FROM dbo.CONDITION_OCCURRENCE
WHERE condition_concept_id IN (
      SELECT concept_id
      FROM dbo.CONCEPT
      -- The list of ICD-10 codes in the Phenotype Wiki
      -- This is the list of standard concepts that represent those terms
      WHERE concept_id IN (3661405, 3661406, 3662381, 756031, 37311061, 3663281, 3661408, 756039, 320651
            )
      )

UNION

SELECT DISTINCT person_id, condition_start_date, condition_end_date
FROM dbo.CONDITION_OCCURRENCE
WHERE condition_concept_id IN (
      SELECT concept_id
      FROM dbo.CONCEPT
      -- The list of ICD-10 codes in the Phenotype Wiki were translated into OMOP standard concepts
      -- This is the list of standard concepts that represent those terms
      WHERE concept_id IN (37311061, 3661405, 756031, 756039, 3661406, 3662381, 3663281, 3661408)
      
      UNION
      
      SELECT concept_id
      FROM dbo.CONCEPT c
      INNER JOIN dbo.CONCEPT_ANCESTOR ca ON c.concept_id = ca.descendant_concept_id
         -- Here we pull the descendants (aka terms that are more specific than the concepts selected above)
         AND ca.ancestor_concept_id IN (
            3661406, 3661408, 37310283, 3662381, 3663281, 37310287, 3661405, 756031, 37310286, 37311061, 
            37310284, 756039, 37310254
            )
         AND c.invalid_reason IS NULL
      )
   AND condition_start_date >= DATEFROMPARTS(2020, 04, 01);

--number of encounters with strong diagnoses
select count(*) "covid_enc_strong_count" from #dx_strong;

--Phenotype Entry Criteria: visits with ONE or more of the Weak diagnosis codes from the ICD-10 or SNOMED tables
--weak diagnoses are codes that indicate symptoms such as fever and cough that, in combination with a positive SARS-COV-2 test, indicate symptomatic covid
SELECT DISTINCT person_id, condition_start_date, condition_end_date
INTO #dx_weak
FROM (
   SELECT person_id, condition_start_date, condition_end_date
   FROM dbo.CONDITION_OCCURRENCE
   WHERE condition_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- The list of ICD-10 codes in the Phenotype Wiki (https://github.com/National-COVID-Cohort-Collaborative/Phenotype_Data_Acquisition/wiki/Latest-Phenotype) were translated into OMOP standard concepts
         -- It also includes the OMOP only codes that are on the Phenotype Wiki
         -- This is the list of standard concepts that represent those terms
         WHERE 
				--N3C Before 4/1/2020
				concept_id IN (
                  260125, 260139, 46271075, 4307774, 4195694, 257011, 442555, 4059022, 4059021, 256451, 
                  4059003, 4168213, 434490, 439676, 254761, 4048098, 37311061, 4100065, 320136, 4038519, 
                  312437, 4060052, 4263848, 37311059, 37016200, 4011766, 437663, 4141062, 4164645, 4047610, 
                  4260205, 4185711, 4289517, 4140453, 4090569, 4109381, 4330445, 255848, 4102774, 436235, 
                  261326, 436145, 40482061, 439857, 254677, 40479642, 256722, 4133224, 4310964, 4051332, 
                  4112521, 4110484, 4112015, 4110023, 4112359, 4110483, 4110485, 254058, 40482069, 4256228, 
                  37016114, 46273719, 312940, 36716978, 37395564, 4140438, 46271074, 319049, 314971, 320651
                  )
				--N3C After 4/1/2020
				or concept_id IN (
                  260125, 260139, 46271075, 4307774, 4195694, 257011, 442555, 4059022, 4059021, 256451, 
                  4059003, 4168213, 434490, 439676, 254761, 4048098, 37311061, 4100065, 320136, 4038519, 
                  312437, 4060052, 4263848, 37311059, 37016200, 4011766, 437663, 4141062, 4164645, 4047610, 
                  4260205, 4185711, 4289517, 4140453, 4090569, 4109381, 4330445, 255848, 4102774, 436235, 
                  261326, 320651
                  )
         )
      AND condition_start_date >= DATEFROMPARTS(2020, 04, 01)
   ) dx_same_encounter

 --number of encounters with weak diagnoses (independent of Covid testing status)
select count(*) "covid_weak_enc_count" from #dx_weak;

--Combine dx_strong and dx_weak tables
SELECT t.*
INTO #dx_comb
FROM (
   SELECT *,'dx_strong' "src"
   FROM #dx_strong
   UNION
   SELECT *,'dx_weak' "src"
   FROM #dx_weak
   ) t

--Covid-positive patients with inpatient encounters (intermediate table)
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
WHERE visit_concept_id in(262,9201); --Inpatient, ER visit

--Intermediate count of Covid-positive patients with inpatient encounters
select count(distinct person_id) "covid_pos_inpatients_count" from #inpat_intermed;

--Intermedite Table with Temporal constraints
Select *
into #inpat_intermed_temporal
from #inpat_intermed
WHERE visit_start_date >= '2020-01-01'
   AND (
      DATEDIFF(day, First_Pos_Date, visit_start_date) > - 7
      AND DATEDIFF(day, First_Pos_Date, visit_start_date) < 21
      )

--Count of patients after temporal constraints applied
Select count(distinct person_id) "covid_pos_inpatients_date_filtered_count"
from #inpat_intermed_temporal


--Apply all incl/excl criteria to identify all patients hospitalized with symptomatic covid-19 up to 21 days after a positive SARS-CoV-2 test or up to 7 days prior to a positive SARS-CoV-2 test
SELECT v.person_id
   ,v.visit_occurrence_id
   ,v.visit_start_date
   ,v.visit_end_date
   ,p.First_Pos_Date
   ,DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) "Days_From_First_Pos"
   ,ABS(DATEDIFF(day, p.First_Pos_Date, v.visit_start_date)) "Abs_Days_From_First_Pos"
   ,CASE 
      WHEN DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) < 0
         THEN - 1
      ELSE 1
      END AS Before_Or_After
   --,#dx_comb.src "dx_source"
INTO #inpat
FROM visit_occurrence v
INNER JOIN #inpat_intermed_temporal p ON v.visit_occurrence_id = p.visit_occurrence_id
INNER JOIN #dx_comb ON v.person_id = #dx_comb.person_id
	AND (
      DATEDIFF(day, #dx_comb.condition_start_date, v.visit_start_date) > -14
      AND DATEDIFF(day, #dx_comb.condition_start_date, v.visit_start_date) < 14
      )

--Count of patients and encounters that meet the criteria
select count(distinct person_id) "covid_pos_inpatients",
count(distinct visit_occurrence_id) "covid_pos_inpatient_visits"
from #inpat;

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

--Applies previous two criteria
SELECT DISTINCT i.* --, c.Closest_Vis, v.Flag
INTO #Vis_Occ
FROM #inpat i
INNER JOIN #inpat_closest_vis c ON i.person_id = c.person_id
   AND i.Abs_Days_From_First_Pos = c.Closest_Vis
INNER JOIN #inpat_first_vis v ON i.person_id = v.person_id
   AND i.Before_Or_After = v.Flag;

--Creates cohort by adding on birth date and death date
INSERT INTO [Results].[CURE_ID_Cohort] --Change schema if not using Results
   (
   [person_id], [visit_occurrence_id], [visit_start_date], [visit_end_date], [First_Pos_Date], 
   [Days_From_First_Pos], [Abs_Days_From_First_Pos], [Before_Or_After], 
   [birth_datetime], [death_datetime]
   )
SELECT v.*, p.birth_datetime, d.death_datetime
FROM #Vis_Occ v
INNER JOIN person p ON v.person_id = p.person_id
LEFT JOIN death d ON v.person_id = d.person_id;

--Final count of patients
Select count(distinct person_id) "Final_patient_count" from #Vis_Occ;

--View data
SELECT TOP 100 *
FROM Results.CURE_ID_Cohort