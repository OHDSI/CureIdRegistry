--Create table which includes the measurement concepts included in the cohort and their names
DROP TABLE IF EXISTS #measurement_parent_concepts_of_interest;
select descendant_concept_id as concept_id, ancestor_concept_id, concept_name
into #measurement_parent_concepts_of_interest
from 
CONCEPT_ancestor
left join concept on
concept.concept_id = CONCEPT_ancestor.ancestor_concept_id
where 
--With descendants
ancestor_concept_id in (3007220, 3045262, 40771922, 37032427, 3023091, 37070654, 3023361, 37051715, 3012888, 37063873, 
3034022, 40653596, 40653762, 40652870, 40653238, 40653900, 40653085, 40652709, 40652525, 40653994, 37043992, 
37041593, 37041261, 37042222, 40654069, 37070108, 40654088, 40654045, 36033639, 3020891, 4141684)  
union  (
select concept_id, concept_id as ancestor_concept_id, concept_name
from 
--No descendants
concept where concept_id in (3013176, 3038553, 3024171, 3025315, 3036277, 3027018, 3004249, 3020460, 3046279, 3022893, 3013721, 3045524, 4353936, 3010834, 3027801, 3016502, 3026238, 3022217, 3034426, 3018677, 3006315, 3002385, 3000963, 3007461, 3024929, 40762499, 703443, 3005629)
) 
order by concept_name

 

--The measurement_count_temp table counts the number of times that each concept is present for each patient in the cohort.
--It is rolled up into ancestor concepts grouped as above
--If no records for the patient of that concept are present, a record of 0 will be present 
DROP TABLE IF EXISTS #measurement_count_temp;
select 
    coh.person_id
    ,coh.visit_occurrence_id
    ,mpci.ancestor_concept_id as concept_id
    ,mpci.concept_name
    ,count(case when m.measurement_concept_id is not null then 1 else NULL end) as concept_count
into #measurement_count_temp
from 
    Results.CURE_ID_Cohort coh
left join
    #measurement_parent_concepts_of_interest mpci
on 1=1
left join 
    measurement m 
on
    mpci.concept_id = m.measurement_concept_id 
    and m.person_id = coh.person_id
    and m.visit_occurrence_id = coh.visit_occurrence_id
group by 
    coh.person_id
    ,coh.visit_occurrence_id
    ,mpci.ancestor_concept_id
    ,mpci.concept_name

 

--This orders patients by how frequently the record occurs and does so for each individual concept
DROP TABLE IF EXISTS #measurment_concept_count_rank;
select  
    concept_name,
    concept_id,
    concept_count,
    row_number() over (partition by concept_id order by concept_count) as rownumber
into
    #measurment_concept_count_rank 
from 
    #measurement_count_temp

 

--This summary table aims to show how many measurement records are present per patient. 
--Because the clinical course for patients varies considerably, some patients have very few records; others have many.
--The summary table has a row for each ancestor concept included in the measurement table
--For each measurement, each patient in the cohort is ranked according to how many records of the measurement are present during the defined visit
--The columns show how many measurement records are present per patient per measurement concept for the 25th percentile, median, 75th percentile, and 95th percentile of patients
select 
    concept_name, 
    x1.concept_id, 
    percentile_25, 
    median,
    percentile_75,
    percentile_95
from
    (select distinct ancestor_concept_id as concept_id, concept_name from #measurement_parent_concepts_of_interest) x1
full join 
    (select concept_id, concept_count as percentile_25
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.25 * (select count(person_id) from Results.CURE_ID_Cohort))
    ) as p25
    on p25.concept_id = x1.concept_id
full join 
    (select concept_id, concept_count as median
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.50 * (select count(person_id) from Results.CURE_ID_Cohort))
    ) as p50
    on p50.concept_id =x1.concept_id
full join 
    (select concept_id, concept_count as percentile_75
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.75 * (select count(person_id) from Results.CURE_ID_Cohort))
    ) as p75
    on p75.concept_id = x1.concept_id
full join 
    (select concept_id, concept_count as percentile_95
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.95 * (select count(person_id) from Results.CURE_ID_Cohort))
    ) as p95
    on p95.concept_id =x1.concept_id
order by median desc, 
percentile_75 desc,
percentile_95 desc
