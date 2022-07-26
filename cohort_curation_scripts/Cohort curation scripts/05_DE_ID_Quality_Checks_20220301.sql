/******* OVERVIEW *******/
-- This script runs a number of summary checks for each table
-- to check basic data population.
-- Step 1) Run Deidentification process
-- Step 2) Use find and replace to update de-id DB and SCHEMA
-- Step 3) Run this script to do basic quality checks

/******* VARIABLES *******/
--SOURCE_DB: [JHM_OMOP_Test]
--SOURCE_SCHEMA: [deident]


/******* PERSON *******/
  SELECT 
  COUNT(distinct person_id) [Num People],
  MAX([birth_datetime]) [Max Birthday],
  MIN([birth_datetime]) [Min Birthday] -- should not be older than 99
  FROM [JHM_OMOP_Test].[deident].[person]

/******* DEATH *******/
  SELECT 
  COUNT(distinct person_id) [Num People]
  FROM [JHM_OMOP_Test].[deident].[death]

/******* OBSERVATION *******/
  SELECT 
  observation_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[observation]
  group by observation_concept_id

  SELECT
  MAX([observation_date]) [Max Observation Date], -- Should fall within target range
  MIN([observation_date]) [Min Observation Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[observation]

/******* PROCEDURE OCCURENCE *******/
  SELECT 
  procedure_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[procedure_occurrence]
  group by procedure_concept_id

  SELECT
  MAX([procedure_date]) [Max Procedure Date], -- Should fall within target range
  MIN([procedure_date]) [Min Procedure Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[procedure_occurrence]

/******* CONDITION OCCURENCE *******/
  SELECT 
  condition_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[condition_occurrence]
  group by condition_concept_id

  SELECT
  MAX([condition_end_date]) [Max Condition Date], -- Should fall within target range
  MIN([condition_start_date]) [Min Condition Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[condition_occurrence]

/******* MEASUREMENT *******/
  SELECT 
  measurement_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[measurement]
  group by measurement_concept_id

  SELECT
  MAX([measurement_date]) [Max Measurement Date], -- Should fall within target range
  MIN([measurement_date]) [Min Measurement Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[measurement]

/******* DEVICE EXPOSURE *******/
  SELECT 
  device_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[device_exposure]
  group by device_concept_id

  SELECT
  MAX([device_exposure_end_date]) [Max Condition Date], -- Should fall within target range
  MIN([device_exposure_start_date]) [Min Condition Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[device_exposure]

/******* DRUG EXPOSURE *******/
  SELECT 
  drug_concept_id,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [JHM_OMOP_Test].[deident].[drug_exposure]
  group by drug_concept_id

  SELECT
  MAX([drug_exposure_end_date]) [Max Condition Date], -- Should fall within target range
  MIN([drug_exposure_start_date]) [Min Condition Date] -- Should fall within target range
  from [JHM_OMOP_Test].[deident].[drug_exposure]