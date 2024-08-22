/*
Filename:
04_COHORT_SUMMARY.sql

Purpose:
Generate a summary report for a cohort, including demographics, age distribution, race, ethnicity, death information, 
and the median and IQR of the length of stay (LOS) for the first visit per person_id.

Description:
This script calculates summary statistics for key demographic variables (age at first visit date, race, ethnicity), 
details about death occurrences, including the list of cause_source_value and concept_name from the death table, 
and the median and IQR for the length of stay (LOS).  Per OMOP CDM documentation: "The Visit duration, or ‘length of stay’, is defined as VISIT_END_DATE - VISIT_START_DATE." 

Dependencies:
Requires person, visit_occurrence, concept, and death tables in the specified schema.
*/

WITH first_visit AS (
    SELECT
        person_id,
        MIN(visit_start_date) AS first_visit_date
    FROM
        your_schema_name.visit_occurrence
    GROUP BY
        person_id
),
age_calculations AS (
    SELECT
        p.person_id,
        EXTRACT(YEAR FROM fv.first_visit_date) - p.year_of_birth AS age_at_first_visit
    FROM
        your_schema_name.person p
    JOIN
        first_visit fv
        ON p.person_id = fv.person_id
),
demographics AS (
    SELECT
        p.person_id,
        p.gender_concept_id,
        p.race_concept_id,
        p.ethnicity_concept_id,
        p.year_of_birth,
        ac.age_at_first_visit
    FROM
        your_schema_name.person p
    JOIN
        age_calculations ac
        ON p.person_id = ac.person_id
),
death_info AS (
    SELECT
        d.person_id,
        d.death_date,
        d.cause_source_value,
        c.concept_name AS cause_of_death
    FROM
        your_schema_name.death d
    LEFT JOIN
        your_schema_name.concept c
        ON d.cause_concept_id = c.concept_id
),
los_calculations AS (
    SELECT
        fv.person_id,
        DATEDIFF(day, vo.visit_start_date, vo.visit_end_date) AS length_of_stay  
    FROM
        first_visit fv
    JOIN
        your_schema_name.visit_occurrence vo
        ON fv.person_id = vo.person_id
        AND fv.first_visit_date = vo.visit_start_date
),
los_summary AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY length_of_stay) AS median_los,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY length_of_stay) AS iqr_los_25,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY length_of_stay) AS iqr_los_75
    FROM
        los_calculations
)
SELECT
    'Age Summary' AS section,
    NULL::text AS category,
    age_summary.mean_age::text AS mean,
    age_summary.median_age::text AS median,
    age_summary.min_age::text AS min,
    age_summary.max_age::text AS max,
    age_summary.age_sd::text AS standard_deviation,
    NULL::text AS count,
    NULL::text AS percent
FROM
    age_summary
UNION ALL
SELECT
    'Race Summary' AS section,
    race AS category,
    NULL::text AS mean,
    NULL::text AS median,
    NULL::text AS min,
    NULL::text AS max,
    NULL::text AS standard_deviation,
    count::text AS count,
    percent::text AS percent
FROM
    race_summary
UNION ALL
SELECT
    'Ethnicity Summary' AS section,
    ethnicity AS category,
    NULL::text AS mean,
    NULL::text AS median,
    NULL::text AS min,
    NULL::text AS max,
    NULL::text AS standard_deviation,
    count::text AS count,
    percent::text AS percent
FROM
    ethnicity_summary
UNION ALL
SELECT
    'Death Summary' AS section,
    'Total Deaths' AS category,
    NULL::text AS mean,
    NULL::text AS median,
    NULL::text AS min,
    NULL::text AS max,
    NULL::text AS standard_deviation,
    total_deaths::text AS count,
    NULL::text AS percent
FROM
    death_summary
UNION ALL
SELECT
    'Death Summary' AS section,
    'Causes of Death' AS category,
    NULL::text AS mean,
    NULL::text AS median,
    NULL::text AS min,
    NULL::text AS max,
    NULL::text AS standard_deviation,
    causes_of_death AS count,
    NULL::text AS percent
FROM
    death_summary
UNION ALL
SELECT
    'Death Summary' AS section,
    'Cause Source Values' AS category,
    NULL::text AS mean,
    NULL::text AS median,
    NULL::text AS min,
    NULL::text AS max,
    NULL::text AS standard_deviation,
    causes_source_value AS count,
    NULL::text AS percent
FROM
    death_summary
UNION ALL
SELECT
    'Length of Stay Summary' AS section,
    'Median Length of Stay (days)' AS category,
    NULL::text AS mean,
    los_summary.median_los::text AS median,
    los_summary.iqr_los_25::text AS min,
    los_summary.iqr_los_75::text AS max,
    NULL::text AS standard_deviation,
    NULL::text AS count,
    NULL::text AS percent
FROM
    los_summary;
