/*
FDA CURE ID Cohort Script

This script creates a cohort of covid-positive, hospitalized patients, to mimic the Johns Hopkins curated_IPEvents table cohort.

Run this script first, then create your subsetted tables using the CURE_ID_All_Tables.sql script

Will need to designate the name of your own OMOP database, and schema you want results to be loaded into.
*/
USE [JHM_OMOP_20220203] --This line will not be relevant for Trayson as his db will be named differently

DROP TABLE IF EXISTS results.CURE_ID_Cohort;

--Create table
CREATE TABLE [Results].[CURE_ID_Cohort] (
   [person_id] [int] NOT NULL, [visit_occurrence_id] [int] NOT NULL, [visit_start_date] [date] NOT NULL, 
   [visit_end_date] [date] NOT NULL, [First_Pos_Date] [date] NULL, [Days_From_First_Pos] [int] NULL, 
   [Abs_Days_From_First_Pos] [int] NULL, [Before_Or_After] [int] NOT NULL, [dx_strong] [int] NOT NULL, 
   [dx_weak] [int] NOT NULL, [birth_datetime] [datetime2](7) NULL, [death_datetime] [datetime2](7) NULL
   ) ON [PRIMARY];

--Create Cohort
WITH covid_lab_pos
AS (
   SELECT DISTINCT person_id, measurement_date
   FROM dbo.MEASUREMENT
   WHERE measurement_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- here we look for the concepts that are the LOINC codes we're looking for in the phenotype
         WHERE concept_id IN (
               '706169', '706156', '706154', '706170', '706157', '706155', '706173', '706175', '706163', 
               '706167', '706168', '706158', '706161', '706160', '723478', '723476', '723464', '723465', 
               '723466', '723467', '723468', '723469', '723470', '723471', '723463', '586528', '586529', 
               '586524', '586525', '586526', '715272', '586517', '586520', '586519', '715262', '715261', 
               '715260', '757677', '757678', '36661377', '36661378', '36661370', '36661371', '36031238', 
               '36031213', '36031506', '36032061', '36031944', '36032174', '36031652', '36031453', 
               '36032258'
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
         )
   ),
   --First positive test
first_pos
AS (
   SELECT person_id, min(measurement_date) "First_Pos_Date"
   FROM covid_lab_pos
   GROUP BY person_id
   ),
   -- UNION
   -- Phenotype Entry Criteria: ONE or more of the Strong Positive diagnosis codes from the ICD-10 or SNOMED tables
   -- This section constructs entry logic prior to the CDC guidance issued on April 1, 2020
dx_strong
AS (
   SELECT DISTINCT visit_occurrence_id
   FROM dbo.CONDITION_OCCURRENCE
   WHERE condition_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- The list of ICD-10 codes in the Phenotype Wiki
         -- This is the list of standard concepts that represent those terms
         WHERE concept_id IN (3661405, 3661406, 3662381, 756031, 37311061, 3663281, 3661408, 756039, 320651
               )
         )
      -- This logic imposes the restriction: these codes were only valid as Strong Positive codes between January 1, 2020 and March 31, 2020
      AND condition_start_date BETWEEN DATEFROMPARTS(2020, 01, 01)
         AND DATEFROMPARTS(2020, 03, 31)
   
   UNION
   
   -- the one condition code that maps to an observation (3731160)
   SELECT DISTINCT visit_occurrence_id
   FROM dbo.OBSERVATION
   WHERE observation_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- The list of ICD-10 codes in the Phenotype Wiki
         -- This is the list of standard concepts that represent those terms
         WHERE concept_id IN (37311060)
         )
      -- This logic imposes the restriction: these codes were only valid as Strong Positive codes between January 1, 2020 and March 31, 2020
      AND observation_date BETWEEN DATEFROMPARTS(2020, 01, 01)
         AND DATEFROMPARTS(2020, 03, 31)
   
   UNION
   
   -- The CDC issued guidance on April 1, 2020 that changed COVID coding conventions
   SELECT DISTINCT visit_occurrence_id
   FROM dbo.CONDITION_OCCURRENCE
   WHERE condition_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- The list of ICD-10 codes in the Phenotype Wiki were translated into OMOP standard concepts
         -- This is the list of standard concepts that represent those terms
         WHERE concept_id IN (37311061, 3661405, 756031, 756039, 3661406, 3662381, 3663281, 3661408
               )
         
         UNION
         
         SELECT c.concept_id
         FROM dbo.CONCEPT c
         INNER JOIN dbo.CONCEPT_ANCESTOR ca ON c.concept_id = ca.descendant_concept_id
            -- Here we pull the descendants (aka terms that are more specific than the concepts selected above)
            AND ca.ancestor_concept_id IN (
               3661406, 3661408, 37310283, 3662381, 3663281, 37310287, 3661405, 756031, 37310286, 37311061, 
               37310284, 756039, 37310254
               )
            AND c.invalid_reason IS NULL
         )
      AND condition_start_date >= DATEFROMPARTS(2020, 04, 01)
   
   UNION
   
   -- the one condition code that maps to an observation (3731160)
   SELECT DISTINCT visit_occurrence_id
   FROM dbo.OBSERVATION
   WHERE observation_concept_id IN (
         SELECT concept_id
         FROM dbo.CONCEPT
         -- The list of ICD-10 codes in the Phenotype Wiki were translated into OMOP standard concepts
         -- This is the list of standard concepts that represent those terms
         WHERE concept_id IN (37311060)
         
         UNION
         
         SELECT c.concept_id
         FROM dbo.CONCEPT c
         INNER JOIN dbo.CONCEPT_ANCESTOR ca ON c.concept_id = ca.descendant_concept_id
            -- Here we pull the descendants (aka terms that are more specific than the concepts selected above)
            AND ca.ancestor_concept_id IN (37311060)
            AND c.invalid_reason IS NULL
         )
      AND observation_date >= DATEFROMPARTS(2020, 04, 01)
   ), dx_weak
AS (
   SELECT DISTINCT visit_occurrence_id
   FROM (
      SELECT visit_occurrence_id
      FROM dbo.CONDITION_OCCURRENCE
      WHERE condition_concept_id IN (
            SELECT concept_id
            FROM dbo.CONCEPT
            -- The list of ICD-10 codes in the Phenotype Wiki were translated into OMOP standard concepts
            -- It also includes the OMOP only codes that are on the Phenotype Wiki
            -- This is the list of standard concepts that represent those terms
            WHERE concept_id IN (
                  260125, 260139, 46271075, 4307774, 4195694, 257011, 442555, 4059022, 4059021, 256451, 
                  4059003, 4168213, 434490, 439676, 254761, 4048098, 37311061, 4100065, 320136, 4038519, 
                  312437, 4060052, 4263848, 37311059, 37016200, 4011766, 437663, 4141062, 4164645, 4047610, 
                  4260205, 4185711, 4289517, 4140453, 4090569, 4109381, 4330445, 255848, 4102774, 436235, 
                  261326, 436145, 40482061, 439857, 254677, 40479642, 256722, 4133224, 4310964, 4051332, 
                  4112521, 4110484, 4112015, 4110023, 4112359, 4110483, 4110485, 254058, 40482069, 4256228, 
                  37016114, 46273719, 312940, 36716978, 37395564, 4140438, 46271074, 319049, 314971, 320651
                  )
            )
         -- This code list is only valid for CDC guidance before 04-01-2020
         AND condition_start_date >= DATEFROMPARTS(2020, 04, 01)
      -- Now we group by person_id and visit_occurrence_id to find people who have 2 or more
      GROUP BY person_id, visit_occurrence_id
      HAVING count(DISTINCT condition_concept_id) >= 2
         -- AFTER 04-01-2020 WEAK POSITIVE LOGIC:
         -- Here we start looking in the CONDITION_OCCCURRENCE table for visits on the same visit
      ) dx_same_encounter
   
   UNION
   
   -- Now we apply logic to look for same visit AND same date
   SELECT DISTINCT visit_occurrence_id
   FROM (
      SELECT visit_occurrence_id
      FROM dbo.CONDITION_OCCURRENCE
      WHERE condition_concept_id IN (
            SELECT concept_id
            FROM dbo.CONCEPT
            -- The list of ICD-10 codes in the Phenotype Wiki were translated into OMOP standard concepts
            -- It also includes the OMOP only codes that are on the Phenotype Wiki
            -- This is the list of standard concepts that represent those term
            WHERE concept_id IN (
                  260125, 260139, 46271075, 4307774, 4195694, 257011, 442555, 4059022, 4059021, 256451, 
                  4059003, 4168213, 434490, 439676, 254761, 4048098, 37311061, 4100065, 320136, 4038519, 
                  312437, 4060052, 4263848, 37311059, 37016200, 4011766, 437663, 4141062, 4164645, 4047610, 
                  4260205, 4185711, 4289517, 4140453, 4090569, 4109381, 4330445, 255848, 4102774, 436235, 
                  261326, 320651
                  )
            )
         -- This code list is based on CDC Guidance for code use AFTER 04-01-2020
         AND condition_start_date >= DATEFROMPARTS(2020, 04, 01)
      -- Now we group by person_id and visit_occurrence_id to find people who have 2 or more
      GROUP BY visit_occurrence_id, condition_start_date
      HAVING count(DISTINCT condition_concept_id) >= 2
      ) dx_same_date
   ),
   --determine if visit was an inpatient encounter
inpat
AS (
   SELECT v.person_id, v.visit_occurrence_id, visit_start_date, visit_end_date, p.First_Pos_Date, DATEDIFF
      (day, p.First_Pos_Date, v.visit_start_date) "Days_From_First_Pos", ABS(DATEDIFF(day, p.
            First_Pos_Date, v.visit_start_date)) "Abs_Days_From_First_Pos", CASE 
         WHEN DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) < 0
            THEN - 1
         ELSE 1
         END AS Before_Or_After, CASE 
         WHEN dx_strong.visit_occurrence_id IS NOT NULL
            THEN 1
         ELSE 0
         END AS dx_strong, CASE 
         WHEN dx_weak.visit_occurrence_id IS NOT NULL
            THEN 1
         ELSE 0
         END AS dx_weak
   FROM visit_occurrence v
   INNER JOIN first_pos p ON v.person_id = p.person_id
   LEFT JOIN dx_strong ON v.visit_occurrence_id = dx_strong.visit_occurrence_id
   LEFT JOIN dx_weak ON v.visit_occurrence_id = dx_weak.visit_occurrence_id
   WHERE visit_concept_id = 9201 --Inpatient visit
      AND v.visit_start_date >= '2020-01-01'
      AND (
         DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) > - 7
         AND DATEDIFF(day, p.First_Pos_Date, v.visit_start_date) < 21
         )
      AND (
         dx_strong.visit_occurrence_id IS NOT NULL
         OR dx_weak.visit_occurrence_id IS NOT NULL
         )
   ), inpat_closest_vis
AS (
   SELECT person_id, min(Abs_Days_From_First_Pos) "Closest_Vis"
   FROM inpat
   GROUP BY person_id
   ),
   --select Closest_Vis from inpat_closest_vis
inpat_first_vis
AS (
   --
   SELECT i.person_id, max(Before_Or_After) "Flag"
   FROM inpat i
   INNER JOIN inpat_closest_vis v ON i.person_id = v.person_id
      AND i.Abs_Days_From_First_Pos = v.Closest_Vis
   GROUP BY i.person_id
   ), Vis_Occ
AS (
   SELECT DISTINCT i.* --, c.Closest_Vis, v.Flag
   FROM inpat i
   INNER JOIN inpat_closest_vis c ON i.person_id = c.person_id
      AND i.Abs_Days_From_First_Pos = c.Closest_Vis
   INNER JOIN inpat_first_vis v ON i.person_id = v.person_id
      AND i.Before_Or_After = v.Flag
   )
--Load into results schema
INSERT INTO [Results].[CURE_ID_Cohort] --Change schema if not using Results
   (
   [person_id], [visit_occurrence_id], [visit_start_date], [visit_end_date], [First_Pos_Date], 
   [Days_From_First_Pos], [Abs_Days_From_First_Pos], [Before_Or_After], [dx_strong], [dx_weak], 
   [birth_datetime], [death_datetime]
   )
SELECT v.*, p.birth_datetime, d.death_datetime
FROM Vis_Occ v
INNER JOIN person p ON v.person_id = p.person_id
LEFT JOIN death d ON v.person_id = d.person_id
WHERE p.race_concept_id IN (8515, 8516, 8527, 8557, 8657)
   AND p.gender_concept_id IN (8507, 8521, 8532, 8551, 8570)
   AND p.ethnicity_concept_id IN (38003563, 38003564);

--View data
SELECT TOP 100 *
FROM Results.CURE_ID_Cohort