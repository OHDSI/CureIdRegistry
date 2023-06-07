---------------------------
--Profile conditions
---------------------------
---Profile condition prevalence in cohort by individual low-level condition concept
select 
    concept_name as condition_name
    ,condition_concept_id 
    ,count(distinct c.person_id) as persons_with_condition
    ,100 * count(distinct c.person_id) / (select count(distinct person_id) from results.CURE_ID_Cohort) as percent_persons_with_condition
from 
    Results.CURE_ID_Condition_Occurrence c
left join 
    CONCEPT on concept.concept_id = c.condition_concept_id 
group by
    condition_concept_id 
    ,concept_name
order by persons_with_condition desc

 

---Profile condition prevalence in cohort by parent condition concepts
select 
    concept_name as condition_name
    ,ancestor_concept_id 
    ,count(distinct c.person_id) as persons_with_condition
    ,100 * count(distinct c.person_id) / (select count(distinct person_id) from results.CURE_ID_Cohort) as percent_persons_with_condition
from 
   Results.CURE_ID_Condition_Occurrence c
left join
    CONCEPT_ancestor on
        descendant_concept_id = c.condition_concept_id
left join 
    concept on concept.concept_id = CONCEPT_ancestor.ancestor_concept_id 
where
    ancestor_concept_id IN (317009, 4299535, 439727, 201820, 255573, 4063381, 316866, 4028244, 438112)
group by
    ancestor_concept_id 
    ,concept_name
order by persons_with_condition desc
