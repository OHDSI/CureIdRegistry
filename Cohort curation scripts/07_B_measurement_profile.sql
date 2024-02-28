--Create table which includes the measurement concepts included in the cohort and their names
DROP TABLE IF EXISTS #measurement_parent_concepts_of_interest;
select
    descendant_concept_id as concept_id
    ,ancestor_concept_id
    ,concept_name
into #measurement_parent_concepts_of_interest

from [Results].[cure_id_concepts]
INNER JOIN CONCEPT_ANCESTOR
	ON ancestor_concept_id =concept_id
where
	domain  = 'Measurement'
	and (include_descendants = 'TRUE' or ancestor_concept_id = descendant_concept_id)
order by concept_name
;

--The measurement_count_temp table counts the number of times that each concept is present for each patient in the cohort.
--It is rolled up into ancestor concepts grouped as above
--If no records for the patient of that concept are present, a record of 0 will be present
--Added field for percentage of person's with the measurement
DROP TABLE IF EXISTS #measurement_count_temp;
select 
    p.person_id
    ,mpci.ancestor_concept_id as concept_id
    ,mpci.concept_name
    ,count(case when m.measurement_concept_id is not null then 1 else NULL end) as concept_count
into #measurement_count_temp
from 
    #measurement_parent_concepts_of_interest mpci
cross join
    [Results].[deident_CURE_ID_person] p
left join
    [Results].[deident_CURE_ID_measurement] m
on
    mpci.concept_id = m.measurement_concept_id 
    and m.person_id = p.person_id
group by 
    p.person_id
    ,mpci.ancestor_concept_id
    ,mpci.concept_name
;
 

--This orders patients by how frequently the record occurs and does so for each individual concept
DROP TABLE IF EXISTS #measurement_concept_count_rank;
select  
    concept_name,
    concept_id,
    concept_count,
    row_number() over (partition by concept_id order by concept_count) as rownumber
into
    #measurement_concept_count_rank 
from 
    #measurement_count_temp
;
 

--This summary table aims to show how many measurement records are present per patient. 
--Because the clinical course for patients varies considerably, some patients have very few records; others have many.
--The summary table has a row for each ancestor concept included in the measurement table
--For each measurement, each patient in the cohort is ranked according to how many records of the measurement are present during the defined visit
--The columns show how many measurement records are present per patient per measurement concept for the 25th percentile, median, 75th percentile, and 95th percentile of patients
with person_measurement_count (concept_id, n) as
(
    select concept_id, count(distinct person_id) as n from #measurement_count_temp
    where concept_count > 0
    group by concept_id
),
n_person as (
  select count(distinct person_id) as n_population from #measurement_count_temp
)
select 
    concept_name, 
    x1.concept_id, 
    percentile_25, 
    median,
    percentile_75,
    percentile_95,
	CASE
	WHEN median = 0
		THEN 'For half of patients, there were no records of this measurement. 5% of patients had ' +
		CAST(percentile_95 AS VARCHAR(10)) +
		' or more records.'
	ELSE
		'For half of patients, there were at least ' +
		CAST(median AS VARCHAR(10)) +
		' records. Most patients (25th-75th percentile) had '  +
		CAST(percentile_25 AS VARCHAR(10)) + '-' +
		CAST(percentile_75 AS VARCHAR(10)) +
		' records. 5% of patients had ' +
		CAST(percentile_95 AS VARCHAR(10)) +
		' or more records.'
   END AS interpretation,
case when pmr.n is null then 0 else pmr.n end as n_person_with_measurement,
case when pmr.n is null then 0 else (cast(pmr.n as float) / np.n_population) * 100 end as person_percentage_with_measurement
from
    (select distinct ancestor_concept_id as concept_id, concept_name from #measurement_parent_concepts_of_interest) x1
full join 
    (select concept_id, concept_count as percentile_25
        FROM #measurement_concept_count_rank
        where rownumber = floor(0.25 * (select count(person_id) from [Results].[deident_CURE_ID_person]))
    ) as p25
    on p25.concept_id = x1.concept_id
full join 
    (select concept_id, concept_count as median
        FROM #measurement_concept_count_rank
        where rownumber = floor(0.50 * (select count(person_id) from [Results].[deident_CURE_ID_person]))
    ) as p50
    on p50.concept_id =x1.concept_id
full join 
    (select concept_id, concept_count as percentile_75
        FROM #measurement_concept_count_rank
        where rownumber = floor(0.75 * (select count(person_id) from [Results].[deident_CURE_ID_person]))
    ) as p75
    on p75.concept_id = x1.concept_id
full join 
    (select concept_id, concept_count as percentile_95
        FROM #measurement_concept_count_rank
        where rownumber = floor(0.95 * (select count(person_id) from [Results].[deident_CURE_ID_person]))
    ) as p95
    on p95.concept_id =x1.concept_id
cross join n_person as np
left join person_measurement_count pmr on x1.concept_id = pmr.concept_id
   
order by person_percentage_with_measurement desc, median desc,
concept_name
;