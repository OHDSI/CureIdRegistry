--Create table which includes the measurement concepts included in the cohort and their names
DROP TABLE IF EXISTS #measurement_concepts_of_interest;
select 
  concept_id, 
  concept_name 
into #measurement_concepts_of_interest
from 
  concept
where 
  concept_id in (703443, 3000285, 3000483, 3000905, 3000963, 3001122, 3001604, 3001657, 3002385, 3002888, 3002937, 
        3003215, 3003282, 3004077, 3004144, 3004249, 3004295, 3004327, 3004501, 3005225, 3005456, 3005629, 
        3005755, 3005949, 3006315, 3006898, 3006923, 3007220, 3007328, 3007461, 3007760, 3007858, 3008037, 
        3008766, 3008791, 3009347, 3009542, 3009932, 3010335, 3010424, 3010813, 3010834, 3011424, 3012481, 
        3012888, 3013115, 3013429, 3013650, 3013682, 3013721, 3013752, 3014053, 3014111, 3015182, 3015242, 
        3016407, 3016436, 3016502, 3016723, 3017501, 3017732, 3018198, 3018405, 3018677, 3018928, 3019198, 
        3019550, 3019897, 3019909, 3020460, 3020891, 3021337, 3022217, 3022250, 3022893, 3023091, 3023103, 
        3023314, 3023361, 3023919, 3024128, 3024171, 3024830, 3024929, 3025315, 3026238, 3026617, 3027018, 
        3027219, 3027388, 3027651, 3027801, 3028271, 3028615, 3028833, 3029829, 3031219, 3031266, 3031579, 
        3032393, 3032971, 3033408, 3033575, 3034022, 3034107, 3034426, 3034962, 3036277, 3038425, 3038547, 
        3038553, 3038668, 3038702, 3039283, 3040598, 3040623, 3040681, 3040743, 3040750, 3040893, 3041232, 
        3041354, 3041473, 3041944, 3041974, 3042294, 3042436, 3042449, 3042634, 3043409, 3043706, 3045262, 
        3045524, 3045961, 3046279, 3046900, 3047181, 3049187, 3049516, 3050746, 3051714, 3051825, 3052648, 
        3052964, 3052968, 3053283, 4141684, 4353936, 36033639, 36303797, 36304114, 36306105, 36306178, 
        37032427, 37041261, 37041593, 37042222, 37043992, 37051715, 37063873, 37070108, 37070654, 40652525, 
        40652709, 40652870, 40653085, 40653238, 40653596, 40653762, 40653900, 40653994, 40654045, 40654069, 
        40654088, 40762499, 40762888, 40762889, 40764999, 40771922, 42869588, 44782836, 44816672, 46235078, 
        46235106, 46235784, 46236949)   

--Create an empty table that for each person in the cohort has every measurement requested. 
--The purpose for this is to create counts of 0 later for concepts that are not present for sopme patients
DROP TABLE IF EXISTS #concept_person;
select 
    person_id, 
    concept_id,
    concept_name
into #concept_person
from 
    #measurement_concepts_of_interest 
cross join
    results.CURE_ID_Cohort 

--The measurement_count_temp table counts the number of times that each concept is present for each patient in the cohort.
--Because this count is left joined onto the #concept_person table, if no records for the patient of that concept are present, a record of 0 will be present
DROP TABLE IF EXISTS #measurement_count_temp;
select 
    #concept_person.person_id, 
    concept_name,
    concept_id,
    count(measurement_concept_id) as concept_count
into #measurement_count_temp
from 
    #concept_person 
left join
    Results.CURE_ID_Measurement m on measurement_concept_id = concept_id and 
    m.person_id = #concept_person.person_id
group by #concept_person.person_id, measurement_concept_id, concept_id, concept_name

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
--The summary table has a row for each concept included in the measurement table
--For each measurement, each patient in the cohort is ranked according to how many records of the measurement are present during the defined visit
--The columns show how many measurement records are present per patient per measurement concept for the 25th percentile, median, 75th percentile, and 95th percentile of patients
select 
    concept_name, 
    #measurement_concepts_of_interest.concept_id, 
    percentile_25, 
    median,
    percentile_75,
    percentile_95
from
    #measurement_concepts_of_interest 
full join 
    (select concept_id, concept_count as percentile_25
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.25 * (select count(person_id) from results.CURE_ID_Cohort))
    ) as p25
    on p25.concept_id = #measurement_concepts_of_interest.concept_id
full join 
    (select concept_id, concept_count as median
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.50 * (select count(person_id) from results.CURE_ID_Cohort))
    ) as p50
    on p50.concept_id = #measurement_concepts_of_interest.concept_id
full join 
    (select concept_id, concept_count as percentile_75
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.75 * (select count(person_id) from results.CURE_ID_Cohort))
    ) as p75
    on p75.concept_id = #measurement_concepts_of_interest.concept_id
full join 
    (select concept_id, concept_count as percentile_95
        FROM #measurment_concept_count_rank
        where rownumber = floor(0.95 * (select count(person_id) from results.CURE_ID_Cohort))
    ) as p95
    on p95.concept_id = #measurement_concepts_of_interest.concept_id
order by median desc, 
percentile_75 desc,
percentile_95 desc
