---------------------------
--Profile conditions
---------------------------
---Profile condition prevalence in cohort by individual low-level condition concept
select 
    concept_name as condition_name
    ,condition_concept_id 
    ,count(distinct coh.person_id) as persons_with_condition
    ,100 * count(distinct coh.person_id) / (select count(distinct person_id) from results.CURE_ID_Cohort) as percent_persons_with_condition
from 
    results.CURE_ID_Cohort coh
left join
    CONDITION_OCCURRENCE on
        CONDITION_OCCURRENCE.person_id = coh.person_id   
        AND (
      CONDITION_OCCURRENCE.condition_start_date < coh.visit_end_date
      OR CONDITION_OCCURRENCE.condition_end_date > coh.visit_start_date
      OR CONDITION_OCCURRENCE.condition_end_date IS NULL
      )
left join 
    CONCEPT on concept.concept_id = CONDITION_OCCURRENCE.condition_concept_id 
group by
    condition_concept_id 
    ,concept_name
order by persons_with_condition desc

 

---Profile condition prevalence in cohort by parent condition concepts
select 
    concept_name as condition_name
    ,ancestor_concept_id 
    ,count(distinct coh.person_id) as persons_with_condition
    ,100 * count(distinct coh.person_id) / (select count(distinct person_id) from results.CURE_ID_Cohort) as percent_persons_with_condition
from 
    results.CURE_ID_Cohort coh
left join
    CONDITION_OCCURRENCE on
        CONDITION_OCCURRENCE.person_id = coh.person_id   
        AND (
      CONDITION_OCCURRENCE.condition_start_date < coh.visit_end_date
      OR CONDITION_OCCURRENCE.condition_end_date > coh.visit_start_date
      OR CONDITION_OCCURRENCE.condition_end_date IS NULL
      )
left join
    CONCEPT_ancestor on
        descendant_concept_id = CONDITION_OCCURRENCE.condition_concept_id
left join 
    concept on concept.concept_id = CONCEPT_ancestor.ancestor_concept_id 
where
    ancestor_concept_id IN (317009, 4299535, 439727, 201820, 255573, 4063381, 316866, 4028244, 438112)
group by
    ancestor_concept_id 
    ,concept_name
order by persons_with_condition desc
