/*
Filename:
03C_SEPSIS_measurement_profile.sql

Purpose:
Generate a profile of measurement prevalence in the final Sepsis cohort

Description:
Measurement counts are calculated per patient and are aggregated by parent concepts
for each measurement concept present in the final Sepsis OMOP Measurement table.

Dependencies:

*/

WITH measurement_counts AS (
    SELECT
        measurement_concept_id,
        measurement_source_value,
        COUNT(DISTINCT person_id) AS unique_person_count,
        COUNT(*) / COUNT(DISTINCT person_id) AS mean_measurements_per_patient
    FROM
        YOUR SCHEMA NAME measurement
    GROUP BY
        measurement_concept_id,
        measurement_source_value
),
total_person_count AS (
    SELECT
        COUNT(DISTINCT person_id) AS total_persons
    FROM
        measurement
)
SELECT
    mc.measurement_concept_id,
    mc.measurement_source_value,
    mc.unique_person_count,
    ROUND((mc.unique_person_count / tpc.total_persons) * 100, 2) AS percent_of_persons,
    mc.mean_measurements_per_patient
FROM
    measurement_counts mc,
    total_person_count tpc
ORDER BY
    percent_of_persons DESC;
