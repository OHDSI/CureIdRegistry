-------------------------------------
--Drug Exposure Profile Tool
-----------------------------------
 

--Create table of all drugs given in the cohort
DROP TABLE IF EXISTS #drug_concepts_of_interest;
select distinct
    concept_id,
    concept_name
into 
    #drug_concepts_of_interest
FROM
    results.CURE_ID_Cohort 
left join 
    DRUG_EXPOSURE on
        DRUG_EXPOSURE.person_id = results.CURE_ID_Cohort.person_id  AND
        DRUG_EXPOSURE.visit_occurrence_id = results.CURE_ID_Cohort.visit_occurrence_id
    left join 
        concept 
    on
        concept_id = drug_concept_id

 

---Roll up drugs into ingredients
drop table if exists #ingredients_of_interest
select 
    #drug_concepts_of_interest.concept_id as drug_concept_id,
    #drug_concepts_of_interest.concept_name as drug_concept_name,
    CONCEPT.concept_id as ingredient_concept_id,
    CONCEPT.concept_name as ingredient_name
into 
    #ingredients_of_interest
from 
    #drug_concepts_of_interest
left join
    CONCEPT_ancestor on
        descendant_concept_id = #drug_concepts_of_interest.concept_id
left join 
    CONCEPT on CONCEPT.concept_id = ancestor_concept_id 
where 
    concept_class_id = 'Ingredient'

 

--Create table of drug exposures by ingredient
drop table if exists #drug_exposure_by_ingredient
select
    ingredient_name
    ,ingredient_concept_id
    ,DRUG_EXPOSURE.drug_concept_id
    ,results.CURE_ID_Cohort.person_id
    ,results.CURE_ID_Cohort.visit_occurrence_id
into 
    #drug_exposure_by_ingredient
from
    results.CURE_ID_Cohort
left join 
    DRUG_EXPOSURE
    on
        DRUG_EXPOSURE.person_id = results.CURE_ID_Cohort.person_id  AND
        DRUG_EXPOSURE.visit_occurrence_id = results.CURE_ID_Cohort.visit_occurrence_id
left join
    #ingredients_of_interest
    on
        #ingredients_of_interest.drug_concept_id =DRUG_EXPOSURE.drug_concept_id

 

--Ingredient use by person
drop table if exists #ingredient_use_by_person
select
    ingredient_name
    ,ingredient_concept_id
    ,count(person_id) as person_count    
    ,(100 * count(person_id) / 
        (select count(distinct person_id) from #drug_exposure_by_ingredient)
    ) as person_perc
into #ingredient_use_by_person
from
(select distinct 
    person_id
    ,visit_occurrence_id
    ,ingredient_concept_id
    ,ingredient_name
from 
    #drug_exposure_by_ingredient) as x1
group by 
    ingredient_concept_id
    ,ingredient_name
order by
    person_count desc

 

drop table if exists #ingredient_count_by_person
select
    ingredient_name
    ,ingredient_concept_id
    ,avg(ingredient_admin_count_per_person) as average_admin_per_person
    ,max(ingredient_admin_count_per_person) as max_admin_per_person
into #ingredient_count_by_person
from
    (select 
        ingredient_name
        ,ingredient_concept_id
        ,person_id
        ,count(ingredient_concept_id) as ingredient_admin_count_per_person
    from #drug_exposure_by_ingredient
    group by person_id, ingredient_concept_id, ingredient_name
    ) as x1
group by 
    ingredient_concept_id
    ,ingredient_name

 

--Display summary table for each drug ingredient:
----the number of persons who took the drug ingredient
----percent of persons who took the drug ingredient
----average administrations of the drug ingredient per person who took the drug
----maximum administrations of the drug ingredient per person
select 
    #ingredient_use_by_person.ingredient_name
    ,#ingredient_use_by_person.ingredient_concept_id
    ,#ingredient_use_by_person.person_count
    ,#ingredient_use_by_person.person_perc
    ,#ingredient_count_by_person.average_admin_per_person
    ,#ingredient_count_by_person.max_admin_per_person
from
    #ingredient_use_by_person
left join
    #ingredient_count_by_person
on
    #ingredient_use_by_person.ingredient_concept_id = #ingredient_count_by_person.ingredient_concept_id
order by person_count desc

 

--Review source values for unmapped drugs identified as those that have a drug_concept_id of 0 that occur more than 20 times in the dataset
select * from (
select 
    drug_source_value
    ,count(drug_source_value) as unmapped_drug_count
FROM
    results.CURE_ID_Cohort 
left join 
    DRUG_EXPOSURE on
        DRUG_EXPOSURE.person_id = results.CURE_ID_Cohort.person_id  AND
        DRUG_EXPOSURE.visit_occurrence_id = results.CURE_ID_Cohort.visit_occurrence_id
    left join 
        concept 
    on
        concept_id = drug_concept_id
where
    drug_concept_id = 0
group by drug_source_value
) as x1
where unmapped_drug_count >20
order by unmapped_drug_count desc
