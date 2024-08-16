-- This query retrieves the count of patients exposed to specific drug ingredients,
-- aggregated by ingredient concept ID, ingredient name, drug source value, and route of administration.

SELECT
    i.concept_id AS ingredient_concept_id,          -- Concept ID representing the drug ingredient
    i.concept_name AS ingredient_name,              -- Name of the drug ingredient
    de.route_source_value AS route_source_value,    -- Source value representing the route of administration (e.g., oral, intravenous)
    de.drug_source_value AS drug_source_value,      -- Source value representing the specific drug as recorded in the database
    COUNT(DISTINCT de.person_id) AS patient_count   -- Count of unique patients exposed to this drug ingredient
FROM YOUR_CDM.drug_exposure de                      -- Table containing drug exposure records
JOIN vocab.concept_ancestor ca                      -- Table linking drug concepts to their ancestors (i.e., higher-level concepts like ingredients)
    ON ca.descendant_concept_id = de.drug_concept_id -- Join on drug concept ID from drug_exposure to find the ancestor concept
JOIN vocab.concept i                                -- Table containing details of each concept (e.g., drugs, ingredients)
    ON i.concept_id = ca.ancestor_concept_id         -- Join to get the ingredient concept details
    AND i.concept_class_id = 'Ingredient'            -- Filter to only include concepts classified as 'Ingredient'
WHERE i.concept_id IN (                             -- Filter for specific ingredient concept IDs of interest
    40171288, 44818461, 37002573, 1594587, 36860404, 
    1758974, 1510627, 36851220, 36855247, 1525713, 
    1361614, 36849476, 779180, 36858062, 745970, 
    40244464, 42904205, 1361580, 1555120, 1114375, 
    40161669, 19023450, 43012762, 905518, 45775965, 
    42629079, 35200783, 45892628, 1302024, 747052, 
    1319998, 1314002, 1322081, 1338005, 1346823, 
    19063575, 1386957, 1307046, 1313200, 1314577, 
    1327978, 1345858, 1353766, 1370109, 902427, 
    963889, 19137312
)
GROUP BY 
    i.concept_id,             -- Group by ingredient concept ID
    i.concept_name,           -- Group by ingredient name
    de.drug_source_value,      -- Group by drug source value
    de.route_source_value      -- Group by route of administration
ORDER BY 
    patient_count DESC;        -- Order results by patient count in descending order
