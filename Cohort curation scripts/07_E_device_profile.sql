--Create table which includes the device concepts included in the cohort and their names
DROP TABLE IF EXISTS #device_concepts_of_interest;
select 
  descendant_concept_id as concept_id
  ,ancestor_concept_id
  ,concept_name
into #device_concepts_of_interest
from 
  CONCEPT_ANCESTOR
left join 
  CONCEPT 
    on
    CONCEPT.concept_id = CONCEPT_ANCESTOR.descendant_concept_id
where 
--With descendants
ancestor_concept_id in (4224038, 45768197, 4222966, 4281167)  
union  (
  select concept_id, concept_id as ancestor_concept_id, concept_name
  from 
  --No descendants
  concept where concept_id in (4138487, 4164918)
) 
order by concept_name


--The #device_count_temp table counts the number of times that each concept is present for each patient in the cohort.
DROP TABLE IF EXISTS #device_count_temp;
select 
    p.person_id
    ,dci.concept_id as concept_id
    ,dci.concept_name
    ,count(case when d.device_concept_id is not null then 1 else NULL end) as concept_count
into #device_count_temp
from 
    [Results].[deident_CURE_ID_person] p
cross join
    #device_concepts_of_interest dci
left join 
    [Results].[deident_CURE_ID_device_exposure] d
on
    dci.concept_id = d.device_concept_id 
    and d.person_id = p.person_id
group by 
    p.person_id
    ,dci.concept_id
    ,dci.concept_name

--Device use by person
DROP TABLE IF EXISTS #device_use_by_person
select
    concept_name
    ,concept_id
    ,count(distinct d.person_id) as person_count    
    ,(100 * count(distinct d.person_id) / 
        (select count(distinct person_id) from [Results].[deident_CURE_ID_person])
    ) as person_perc
into #device_use_by_person
from
    #device_concepts_of_interest dci
left join
    [Results].[deident_CURE_ID_device_exposure] d
on 
    d.device_concept_id = dci.concept_id
group by
    concept_id,
    concept_name
order by person_count desc


DROP TABLE IF EXISTS #device_count_by_person
select
    concept_name
    ,concept_id
    ,avg(concept_count) as average_entries_per_person
    ,max(concept_count) as max_entries_per_person
into #device_count_by_person
from
    #device_count_temp
where
    concept_count > 0
group by 
    concept_id
    ,concept_name



--Display summary table for each device:
----the number of persons who used the device
----percent of persons who  used the device
----average entries of the device per person who used the device
----maximum entries of the device per person who used the device

select 
    du.concept_name
    ,du.concept_id
    ,du.person_count
    ,du.person_perc
    ,dc.average_entries_per_person
    ,dc.max_entries_per_person
from
    #device_use_by_person du
left join
    #device_count_by_person dc
on
    du.concept_id = dc.concept_id
order by person_count desc
