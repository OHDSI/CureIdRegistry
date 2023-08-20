---------------------------
--Profile conditions
---------------------------

USE YOUR_DATABASE;

---Profile condition prevalence in cohort by individual condition concept
---Condition counts include descendants 
select 
    concept_name as condition_name
    ,ancestor_concept_id 
    ,count(distinct c.person_id) as persons_with_condition_or_descendant
    ,100 * count(distinct c.person_id) / (select count(distinct person_id) from [Results].[deident_CURE_ID_Person]) as percent_persons_with_condition
from 
    [Results].[deident_CURE_ID_Condition_Occurrence] c
    inner join CONCEPT_ANCESTOR
        on descendant_concept_id = c.condition_concept_id
        and ancestor_concept_id in 
            (select condition_concept_id from [Results].[deident_CURE_ID_Condition_Occurrence])
left join CONCEPT
  on concept.concept_id = CONCEPT_ANCESTOR.ancestor_concept_id 
group by
    ancestor_concept_id 
    ,concept_name
order by persons_with_condition_or_descendant desc

 

---Profile condition prevalence in cohort by parent condition concepts
select 
    concept_name as condition_name
    ,ancestor_concept_id 
    ,count(distinct c.person_id) as persons_with_condition
    ,100 * count(distinct c.person_id) / (select count(distinct person_id) from [Results].[deident_CURE_ID_Person]) as percent_persons_with_condition
from 
   [Results].[deident_CURE_ID_Condition_Occurrence] c
left join
    CONCEPT_ANCESTOR on
        descendant_concept_id = c.condition_concept_id
left join 
    concept on concept.concept_id = CONCEPT_ANCESTOR.ancestor_concept_id 
INNER JOIN [Results].[cure_id_concepts]
	on ancestor_concept_id = concept_id
where 
	domain  = 'Condition' 
	and (include_descendants = 'TRUE' or ancestor_concept_id = descendant_concept_id)
group by
    ancestor_concept_id 
    ,concept_name
order by persons_with_condition desc
