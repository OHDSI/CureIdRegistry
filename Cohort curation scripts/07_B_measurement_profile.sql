/*
Filename:
07_B_measurement_profile.sql

Purpose:
Generate a profile of measurement prevalence in the final cohort

Description:
Measurement counts are calculated per patient and are aggregated by parent concepts
for each measurement concept present in the final OMOP Measurement table.

Dependencies:

*/

-- Create table which includes the measurement concepts included in the cohort and their names

DROP TABLE IF EXISTS #measurement_parent_concepts_of_interest;
SELECT
    descendant_concept_id AS concept_id,
    ancestor_concept_id,
    concept_name
INTO #measurement_parent_concepts_of_interest
FROM [Results].[cure_id_concepts]
INNER JOIN CONCEPT_ANCESTOR
    ON ancestor_concept_id = concept_id
WHERE
    domain = 'Measurement'
    AND (include_descendants = 'TRUE' OR ancestor_concept_id = descendant_concept_id)
ORDER BY concept_name


--The measurement_count_temp table counts the number of times that each concept is present for each patient in the cohort.
--It is rolled up into ancestor concepts grouped as above
--If no records for the patient of that concept are present, a record of 0 will be present 
DROP TABLE IF EXISTS #measurement_count_temp;
SELECT
    p.person_id,
    mpci.ancestor_concept_id AS concept_id,
    mpci.concept_name,
    COUNT(CASE WHEN m.measurement_concept_id IS NOT NULL THEN 1 ELSE NULL END) AS concept_count
INTO #measurement_count_temp
FROM
    #measurement_parent_concepts_of_interest AS mpci
CROSS JOIN
    [Results].[deident_CURE_ID_person] AS p
LEFT JOIN
    [Results].[deident_CURE_ID_measurement] AS m
    ON
        mpci.concept_id = m.measurement_concept_id
        AND m.person_id = p.person_id
GROUP BY
    p.person_id,
    mpci.ancestor_concept_id,
    mpci.concept_name

--This orders patients by how frequently the record occurs and does so for each individual concept
DROP TABLE IF EXISTS #measurment_concept_count_rank;
SELECT
    concept_name,
    concept_id,
    concept_count,
    ROW_NUMBER() OVER (PARTITION BY concept_id ORDER BY concept_count) AS rownumber
INTO #measurment_concept_count_rank
FROM #measurement_count_temp;

-- This summary table aims to show how many measurement records are present per patient. 
-- Because the clinical course for patients varies considerably, some patients have very few records; others have many.
-- The summary table has a row for each ancestor concept included in the measurement table
-- For each measurement, each patient in the cohort is ranked according to how many records of the measurement are present during the defined visit
-- The columns show how many measurement records are present per patient per measurement concept for the 25th percentile, median, 75th percentile, and 95th percentile of patients
SELECT
    concept_name,
    x1.concept_id,
    percentile_25,
    median,
    percentile_75,
    percentile_95,
    CASE
        WHEN median = 0
            THEN
                'For half of patients, there were no records of this measurement. 5% of patients had '
                + CAST(percentile_95 AS VARCHAR(10))
                + ' or more records.'
        ELSE
            'For half of patients, there were at least '
            + CAST(median AS VARCHAR(10))
            + ' records. Most patients (25th-75th percentile) had '
            + CAST(percentile_25 AS VARCHAR(10)) + '-'
            + CAST(percentile_75 AS VARCHAR(10))
            + ' records. 5% of patients had '
            + CAST(percentile_95 AS VARCHAR(10))
            + ' or more records.'
    END AS interpretation
FROM
    (SELECT DISTINCT
        ancestor_concept_id AS concept_id,
        concept_name
    FROM #measurement_parent_concepts_of_interest) AS x1
FULL JOIN
    (
        SELECT
            concept_id,
            concept_count AS percentile_25
        FROM #measurment_concept_count_rank
        WHERE rownumber = FLOOR(0.25 * (SELECT COUNT(person_id) FROM [Results].[deident_CURE_ID_person]))
    ) AS p25
    ON p25.concept_id = x1.concept_id
FULL JOIN
    (
        SELECT
            concept_id,
            concept_count AS median
        FROM #measurment_concept_count_rank
        WHERE rownumber = FLOOR(0.50 * (SELECT COUNT(person_id) FROM [Results].[deident_CURE_ID_person]))
    ) AS p50
    ON p50.concept_id = x1.concept_id
FULL JOIN
    (
        SELECT
            concept_id,
            concept_count AS percentile_75
        FROM #measurment_concept_count_rank
        WHERE rownumber = FLOOR(0.75 * (SELECT COUNT(person_id) FROM [Results].[deident_CURE_ID_person]))
    ) AS p75
    ON p75.concept_id = x1.concept_id
FULL JOIN
    (
        SELECT
            concept_id,
            concept_count AS percentile_95
        FROM #measurment_concept_count_rank
        WHERE rownumber = FLOOR(0.95 * (SELECT COUNT(person_id) FROM [Results].[deident_CURE_ID_person]))
    ) AS p95
    ON p95.concept_id = x1.concept_id
ORDER BY
    median DESC,
    percentile_75 DESC,
    percentile_95 DESC
