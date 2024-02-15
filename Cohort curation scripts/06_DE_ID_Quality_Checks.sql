/*
Filename:
06_DE_ID_Quality_Checks.sql

Purpose:
This script checks basic metrics for each table in the deidentified dataset to ensure
the previous scripts were successful. This does

Description:
This script runs a number of summary level quality checks for each table to audit
basic data counts and date ranges.

Dependencies:
01_CURE_ID_Cohort.sql
02_CURE_ID_All_Tables.sql
03_CURE_ID_replace_rare_conditions_with_parents.sql
04_DE_ID_CDM_Table_ddl.sql
05_DE_ID_script.sql
*/


/******* VARIABLES *******/
--SOURCE_SCHEMA: [deident]


USE YOUR_DATABASE;

/******* PERSON *******/
SELECT
    COUNT(distinct person_id) [Num People],
    MAX([birth_datetime]) [Max Birthday],
    MIN([birth_datetime]) [Min Birthday] -- should not be older than 99
FROM [Results].[deident_CURE_ID_person]
;

/******* DEATH *******/
SELECT
    COUNT(distinct person_id) [Num People]
FROM [Results].[deident_CURE_ID_death]
;

/******* OBSERVATION *******/
SELECT
    observation_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_observation]
group by observation_concept_id
;

SELECT
    MAX([observation_date]) [Max Observation Date], -- Should fall within target range
    MIN([observation_date]) [Min Observation Date] -- Should fall within target range
from [Results].[deident_CURE_ID_observation]
;

/******* PROCEDURE OCCURENCE *******/
SELECT
    procedure_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_procedure_occurrence]
group by procedure_concept_id
;

SELECT
    MAX([procedure_date]) [Max Procedure Date], -- Should fall within target range
    MIN([procedure_date]) [Min Procedure Date] -- Should fall within target range
from [Results].[deident_CURE_ID_procedure_occurrence]
;

/******* CONDITION OCCURENCE *******/
SELECT
    condition_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_condition_occurrence]
group by condition_concept_id
;

SELECT
    MAX(coalesce([condition_end_date], [condition_start_date])) [Max Condition Date], -- Should fall within target range
    MIN([condition_start_date]) [Min Condition Date] -- Should fall within target range
from [Results].[deident_CURE_ID_condition_occurrence]
;

/******* MEASUREMENT *******/
SELECT
    measurement_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_measurement]
group by measurement_concept_id
;

SELECT
    MAX([measurement_date]) [Max Measurement Date], -- Should fall within target range
    MIN([measurement_date]) [Min Measurement Date] -- Should fall within target range
from [Results].[deident_CURE_ID_measurement]
;

/******* DEVICE EXPOSURE *******/
SELECT
    device_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_device_exposure]
group by device_concept_id
;

SELECT
    MAX(coalesce([device_exposure_end_date], [device_exposure_start_date])) [Max Device Date], -- Should fall within target range
    MIN([device_exposure_start_date]) [Min DECICE Date] -- Should fall within target range
from [Results].[deident_CURE_ID_device_exposure]
;

/******* DRUG EXPOSURE *******/
SELECT
    drug_concept_id,
    COUNT(distinct person_id) as [Num People],
    COUNT(*) as [Num Records]
from [Results].[deident_CURE_ID_drug_exposure]
group by drug_concept_id
;

SELECT
    MAX([drug_exposure_end_date]) [Max Condition Date], -- Should fall within target range
    MIN([drug_exposure_start_date]) [Min Condition Date] -- Should fall within target range
from [Results].[deident_CURE_ID_drug_exposure]
;
