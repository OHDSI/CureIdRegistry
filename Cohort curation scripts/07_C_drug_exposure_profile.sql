/*
Filename:
07_C_drug_exposure_profile.sql

Purpose:
Generate a profile of drug prevalence in the final cohort

Description:
Drug counts are calculated per patient and are aggregated by ingredient for each
drug concept present in the final OMOP Drug Exposure table

Dependencies:
*/

-- Create table of all drugs given in the cohort
DROP TABLE IF EXISTS #drug_concepts_of_interest;
SELECT DISTINCT
    CONCEPT.concept_id,
    CONCEPT.concept_name
INTO #drug_concepts_of_interest
FROM [Results].[deident_CURE_ID_drug_exposure]
LEFT JOIN CONCEPT
    ON CONCEPT.concept_id = [Results].[deident_CURE_ID_drug_exposure].drug_concept_id;

--Roll up drugs into ingredients
DROP TABLE IF EXISTS #ingredients_of_interest
SELECT
    dci.concept_id AS drug_concept_id,
    dci.concept_name AS drug_concept_name,
    CONCEPT.concept_id AS ingredient_concept_id,
    CONCEPT.concept_name AS ingredient_name
INTO #ingredients_of_interest
FROM #drug_concepts_of_interest AS dci
LEFT JOIN
    CONCEPT_ANCESTOR
    ON
        descendant_concept_id = dci.concept_id
LEFT JOIN CONCEPT
  ON CONCEPT.concept_id = ancestor_concept_id
WHERE
    concept_class_id = 'Ingredient'

--Create table of drug exposures by ingredient
DROP TABLE IF EXISTS #drug_exposure_by_ingredient
SELECT
    ingredient_name,
    ingredient_concept_id,
    d.drug_concept_id,
    person_id
INTO #drug_exposure_by_ingredient
FROM [Results].[deident_CURE_ID_drug_exposure] AS d
LEFT JOIN #ingredients_of_interest AS i
    ON i.drug_concept_id = d.drug_concept_id

--Ingredient use by person
DROP TABLE IF EXISTS #ingredient_use_by_person;
SELECT
    ingredient_name,
    ingredient_concept_id,
    COUNT(person_id) AS person_count,
    (
        100 * COUNT(person_id)
        / (SELECT COUNT(DISTINCT person_id) FROM #drug_exposure_by_ingredient)
    ) AS person_perc
INTO #ingredient_use_by_person
FROM
    (
        SELECT DISTINCT
            person_id,
            ingredient_concept_id,
            ingredient_name
        FROM
            #drug_exposure_by_ingredient
    ) AS x1
GROUP BY
    ingredient_concept_id,
    ingredient_name
ORDER BY
    person_count DESC

DROP TABLE IF EXISTS #ingredient_count_by_person
SELECT
    ingredient_name,
    ingredient_concept_id,
    AVG(ingredient_admin_count_per_person) AS average_admin_per_person,
    MAX(ingredient_admin_count_per_person) AS max_admin_per_person
INTO #ingredient_count_by_person
FROM
    (
        SELECT
            ingredient_name,
            ingredient_concept_id,
            person_id,
            COUNT(ingredient_concept_id) AS ingredient_admin_count_per_person
        FROM #drug_exposure_by_ingredient
        GROUP BY person_id, ingredient_concept_id, ingredient_name
    ) AS x1
GROUP BY
    ingredient_concept_id,
    ingredient_name

    --Display summary table for each drug ingredient:
    ----the number of persons who took the drug ingredient
    ----percent of persons who took the drug ingredient
    ----average administrations of the drug ingredient per person who took the drug
    ----maximum administrations of the drug ingredient per person
    SELECT
        #ingredient_use_by_person.ingredient_name,
        #ingredient_use_by_person.ingredient_concept_id,
        #ingredient_use_by_person.person_count,
        #ingredient_use_by_person.person_perc,
        #ingredient_count_by_person.average_admin_per_person,
        #ingredient_count_by_person.max_admin_per_person
    FROM
        #ingredient_use_by_person
    LEFT JOIN
        #ingredient_count_by_person
        ON
            #ingredient_use_by_person.ingredient_concept_id = #ingredient_count_by_person.ingredient_concept_id
    ORDER BY person_count DESC
