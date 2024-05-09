/*
Filename:
07_A_condition_profile.sql

Purpose:
Generate a profile of condition prevalence in the final cohort

Description:
Condition counts are calculated per patient and are aggregated by parent concepts
for each condition concept present in the final OMOP Condition Occurrence table.

Dependencies:

*/

USE YOUR_DATABASE;

--Profile condition prevalence in cohort by individual condition concept
--Condition counts include descendants 
SELECT
    CONCEPT.concept_name AS condition_name,
    CONCEPT_ANCESTOR.ancestor_concept_id,
    COUNT(DISTINCT c.person_id) AS persons_with_condition_or_descendant,
    100 * COUNT(DISTINCT c.person_id) / (SELECT COUNT(DISTINCT c.person_id) FROM [Results].[deident_CURE_ID_Person]) AS percent_persons_with_condition
FROM
    [Results].[deident_CURE_ID_Condition_Occurrence] AS c
INNER JOIN CONCEPT_ANCESTOR
    ON
        CONCEPT_ANCESTOR.descendant_concept_id = c.condition_concept_id
        AND CONCEPT_ANCESTOR.ancestor_concept_id IN
        (SELECT condition_concept_id FROM [Results].[deident_CURE_ID_Condition_Occurrence])
LEFT JOIN CONCEPT
    ON CONCEPT.concept_id = CONCEPT_ANCESTOR.ancestor_concept_id
GROUP BY CONCEPT_ANCESTOR.ancestor_concept_id, CONCEPT.concept_name
ORDER BY persons_with_condition_or_descendant DESC

--Profile condition prevalence in cohort by parent condition concepts
SELECT
    [Results].[cure_id_concepts].concept_name AS condition_name,
    CONCEPT_ANCESTOR.ancestor_concept_id,
    COUNT(DISTINCT c.person_id) AS persons_with_condition,
    100 * COUNT(DISTINCT c.person_id) / (SELECT COUNT(DISTINCT c.person_id) FROM [Results].[deident_CURE_ID_Person]) AS percent_persons_with_condition
FROM
    [Results].[deident_CURE_ID_Condition_Occurrence] AS c
LEFT JOIN CONCEPT_ANCESTOR
    ON CONCEPT_ANCESTOR.descendant_concept_id = c.condition_concept_id
INNER JOIN [Results].[cure_id_concepts]
    ON CONCEPT_ANCESTOR.ancestor_concept_id = [Results].[cure_id_concepts].concept_id
WHERE
    [Results].[cure_id_concepts].domain = 'Condition'
    AND (
        [Results].[cure_id_concepts].include_descendants = 'TRUE'
        OR CONCEPT_ANCESTOR.ancestor_concept_id = CONCEPT_ANCESTOR.descendant_concept_id
    )
GROUP BY
    CONCEPT_ANCESTOR.ancestor_concept_id, [Results].[cure_id_concepts].concept_name
ORDER BY persons_with_condition DESC
