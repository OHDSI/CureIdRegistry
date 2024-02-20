/*
Filename:
03_CURE_ID_replace_rare_conditions_with_parents.sql

Purpose:
Replace conditions occurring 10 or less times in the dataset with parent concepts
that have at least 10 counts.

Description:

Dependencies:
01_CURE_ID_Cohort.sql
02_CURE_ID_All_Tables.sql
*/

USE YOUR_DATABASE;

DROP TABLE IF EXISTS Results.CURE_ID_Condition_Occurrence_Rare_Removed

---Condition roll up
DROP TABLE IF EXISTS #condition_rollup
SELECT DISTINCT
    person_id,
    condition_concept_id AS original_concept_id,
    concept_name AS ancestor_concept_name,
    ancestor_concept_id,
    min_levels_of_separation
INTO #condition_rollup
FROM Results.CURE_ID_Condition_Occurrence
LEFT JOIN CONCEPT_ancestor
    ON descendant_concept_id = Results.CURE_ID_Condition_Occurrence.condition_concept_id
LEFT JOIN concept
    ON concept.concept_id = CONCEPT_ancestor.ancestor_concept_id

--Create table that counts the ancestor concepts for each original concept
DROP TABLE IF EXISTS #condition_rollup_counts
SELECT
    ancestor_concept_name,
    ancestor_concept_id,
    COUNT(ancestor_concept_id) AS ancestor_concept_count
INTO #condition_rollup_counts
FROM #condition_rollup
GROUP BY ancestor_concept_id, ancestor_concept_name

--Create table that counts the original concepts
DROP TABLE IF EXISTS #original_condition_counts
SELECT
    condition_concept_id AS original_concept_id,
    concept_name AS original_concept_name,
    COUNT(condition_concept_id) AS original_concept_count
INTO #original_condition_counts
FROM (
    SELECT DISTINCT
        person_id,
        condition_concept_id,
        concept_name
    FROM Results.CURE_ID_Condition_Occurrence
    LEFT JOIN concept
        ON concept.concept_id = Results.CURE_ID_Condition_Occurrence.condition_concept_id
) AS x1
GROUP BY condition_concept_id, concept_name

--Limit to conditions to those that have more than 10 counts
DROP TABLE IF EXISTS #condition_rollup_morethan10
SELECT
    person_id,
    #condition_rollup.original_concept_id,
    #condition_rollup.ancestor_concept_id,
    #condition_rollup.ancestor_concept_name,
    #condition_rollup_counts.ancestor_concept_count,
    #condition_rollup.min_levels_of_separation
INTO #condition_rollup_morethan10
FROM #condition_rollup
LEFT JOIN #condition_rollup_counts
    ON #condition_rollup_counts.ancestor_concept_id = #condition_rollup.ancestor_concept_id
WHERE
    ancestor_concept_count > 10

--Get just the most specfic condition in the ancestor-descendent hierarchy
DROP TABLE IF EXISTS #condition_rollup_morethan10_min_counts
SELECT DISTINCT
    #condition_rollup_morethan10.person_id,
    #condition_rollup_morethan10.original_concept_id,
    #condition_rollup_morethan10.ancestor_concept_id,
    #condition_rollup_morethan10.ancestor_concept_name,
    #condition_rollup_morethan10.ancestor_concept_count,
    #condition_rollup_morethan10.min_levels_of_separation
INTO #condition_rollup_morethan10_min_counts
FROM #condition_rollup_morethan10
INNER JOIN
    (
        SELECT DISTINCT
            #condition_rollup_morethan10.person_id,
            #condition_rollup_morethan10.original_concept_id,
            min(ancestor_concept_count) AS min_ancestor_concept_count
        FROM #condition_rollup_morethan10
        GROUP BY person_id, original_concept_id
    ) AS tb1
    ON
        #condition_rollup_morethan10.person_id = tb1.person_id
        AND #condition_rollup_morethan10.original_concept_id = tb1.original_concept_id
WHERE
    #condition_rollup_morethan10.ancestor_concept_count = tb1.min_ancestor_concept_count

DROP TABLE IF EXISTS #condition_rollup_morethan10_min_counts_and_levels
SELECT DISTINCT
    #condition_rollup_morethan10_min_counts.person_id,
    #condition_rollup_morethan10_min_counts.original_concept_id,
    #condition_rollup_morethan10_min_counts.ancestor_concept_id AS revised_concept_id,
    #condition_rollup_morethan10_min_counts.ancestor_concept_name AS revised_concept_name,
    #condition_rollup_morethan10_min_counts.ancestor_concept_count,
    #condition_rollup_morethan10_min_counts.min_levels_of_separation
INTO #condition_rollup_morethan10_min_counts_and_levels
FROM #condition_rollup_morethan10_min_counts
INNER JOIN
    (
        SELECT DISTINCT
            person_id,
            original_concept_id,
            min(min_levels_of_separation) AS min_min_levels_of_separation
        FROM #condition_rollup_morethan10_min_counts
        GROUP BY person_id, original_concept_id
    ) AS tb1
    ON
        #condition_rollup_morethan10_min_counts.person_id = tb1.person_id
        AND #condition_rollup_morethan10_min_counts.original_concept_id = tb1.original_concept_id
WHERE
    #condition_rollup_morethan10_min_counts.min_levels_of_separation = tb1.min_min_levels_of_separation

DROP TABLE IF EXISTS #condition_rollup_morethan10_min_counts_and_levels_forced_unique
SELECT
    x1.person_id,
    x1.original_concept_id,
    #original_condition_counts.original_concept_name,
    #original_condition_counts.original_concept_count,
    x1.revised_concept_id,
    x1.revised_concept_name,
    x1.min_levels_of_separation,
    x1.ancestor_concept_count
INTO #condition_rollup_morethan10_min_counts_and_levels_forced_unique
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY person_id, original_concept_id ORDER BY revised_concept_id DESC) AS row_number
    FROM #condition_rollup_morethan10_min_counts_and_levels
) AS x1
LEFT JOIN #original_condition_counts
    ON x1.original_concept_id = #original_condition_counts.original_concept_id
WHERE row_number = 1;

--SELECT top 10 * FROM #condition_rollup_morethan10_min_counts_and_levels_forced_unique where original_concept_id != revised_concept_id;

SELECT
    c.condition_occurrence_id,
    c.person_id,
    rare.revised_concept_id AS condition_concept_id,
    c.condition_start_date,
    c.condition_start_datetime,
    c.condition_end_date,
    c.condition_end_datetime,
    c.condition_type_concept_id,
    c.condition_status_concept_id,
    c.stop_reason,
    c.provider_id,
    c.visit_occurrence_id,
    c.visit_detail_id,
    c.condition_source_value,
    c.condition_source_concept_id,
    c.condition_status_source_value
INTO Results.CURE_ID_Condition_Occurrence_Rare_Removed
FROM Results.CURE_ID_Condition_Occurrence AS c
INNER JOIN #condition_rollup_morethan10_min_counts_and_levels_forced_unique AS rare
    ON
        c.condition_concept_id = rare.original_concept_id
        AND c.person_id = rare.person_id;

DROP TABLE IF EXISTS Results.CURE_ID_Condition_Occurrence;
