/*
Filename:
07_E_device_profile.sql

Purpose:
Generate a profile of device prevalence in the final cohort

Description:
Device counts are calculated per patient and are aggregated by parent concepts for
each device concept present in the final OMOP Device Exposure table

Dependencies:
*/

--Create table which includes the device concepts included in the cohort and their names
DROP TABLE IF EXISTS #device_concepts_of_interest;
SELECT
    CONCEPT_ANCESTOR.descendant_concept_id AS concept_id,
    CONCEPT_ANCESTOR.ancestor_concept_id,
    [Results].[cure_id_concepts].concept_name
INTO #device_concepts_of_interest
FROM [Results].[cure_id_concepts]
INNER JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Device'
    AND ([Results].[cure_id_concepts].include_descendants = 'TRUE' OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id)
ORDER BY [Results].[cure_id_concepts].concept_name

--The #device_count_temp table counts the number of times that each concept is present for each patient in the cohort.
DROP TABLE IF EXISTS #device_count_temp;
SELECT
    p.person_id,
    dci.concept_id AS concept_id,
    dci.concept_name,
    COUNT(
        CASE
            WHEN d.device_concept_id IS NOT NULL THEN 1
        END
    ) AS concept_count
INTO #device_count_temp
FROM [Results].[deident_CURE_ID_person] AS p
CROSS JOIN #device_concepts_of_interest AS dci
LEFT JOIN [Results].[deident_CURE_ID_device_exposure] AS d
    ON
        dci.concept_id = d.device_concept_id
        AND d.person_id = p.person_id
GROUP BY
    p.person_id,
    dci.concept_id,
    dci.concept_name

--Device use by person
DROP TABLE IF EXISTS #device_use_by_person
SELECT
    dci.concept_name,
    dci.concept_id,
    COUNT(DISTINCT d.person_id) AS person_count,
    (
        100 * COUNT(DISTINCT d.person_id)
        / (SELECT COUNT(DISTINCT person_id) FROM [Results].[deident_CURE_ID_person])
    ) AS person_perc
INTO #device_use_by_person
FROM #device_concepts_of_interest AS dci
LEFT JOIN [Results].[deident_CURE_ID_device_exposure] AS d
    ON d.device_concept_id = dci.concept_id
GROUP BY
    dci.concept_id,
    dci.concept_name
ORDER BY person_count DESC


DROP TABLE IF EXISTS #device_count_by_person
SELECT
    concept_name,
    concept_id,
    AVG(concept_count) AS average_entries_per_person,
    MAX(concept_count) AS max_entries_per_person
INTO #device_count_by_person
FROM #device_count_temp
WHERE concept_count > 0
GROUP BY
    concept_id,
    concept_name
    
    -- Display summary table for each device:
    -- the number of persons who used the device
    -- percent of persons who  used the device
    -- average entries of the device per person who used the device
    -- maximum entries of the device per person who used the device

    SELECT
        du.concept_name,
        du.concept_id,
        du.person_count,
        du.person_perc,
        dc.average_entries_per_person,
        dc.max_entries_per_person
    FROM #device_use_by_person AS du
    LEFT JOIN #device_count_by_person AS dc
        ON du.concept_id = dc.concept_id
    ORDER BY du.person_count DESC;
