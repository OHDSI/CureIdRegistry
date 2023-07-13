/******* OVERVIEW *******/
--Step 1) Subset your data
--Step 2) Run the DDL for the deidentified tables
--Step 3) Use find and replace to set source and target DB and Schema names
--Step 4) Run this file to generate a deidentified copy of your target data
--Step 5) Run the DE ID Quality Checks (Optional)

/******* VARIABLES *******/
--SOURCE_SCHEMA: Results
--TARGET_SCHEMA: [Results]
DECLARE @START_DATE DATE = CAST('2016-01-01' AS DATE)
DECLARE @END_DATE DATE = CAST('2029-12-31' AS DATE)


/******* GENERATE MAP TABLES *******/

--Tables are dropped and created in a separate script.
--Please run that script first.

USE YOUR_DATABASE;


/******* GENERATE MAP TABLES *******/
insert into [Results].[source_id_person]
select 
person_id as sourceKey, 
row_number() over(order by p.gender_concept_id, person_id desc) as id, 
(FLOOR(RAND(convert(varbinary,newid()))*367))-183 as date_shift,
CAST((DATEPART(YEAR,GETDATE()) - 90 - (FLOOR(RAND(convert(varbinary,newid()))*10))) AS INT) as over_89_birth_year --If a person is > 89, then assign them a random age between 90 - 99
from [Results].[CURE_ID_Person] p
;
insert into [Results].[source_id_visit] 
select visit_occurrence_id as sourceKey, row_number() over(order by p.visit_occurrence_id) as new_id
from [Results].[CURE_ID_Visit_Occurrence] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id --Ask Ben about this self join?
where v.new_id is null and (DATEADD(DAY, s.date_shift, visit_start_date) >= @START_DATE 
and DATEADD(DAY, s.date_shift, visit_end_date) <= @END_DATE) order by p.person_id, p.visit_start_date
;

/******* PERSON *******/
insert into [Results].[deident_CURE_ID_Person]
select s.id as person_id 
,gender_concept_id 
,CASE 
	WHEN DATEDIFF(DAY,p.birth_datetime,GETDATE())/365.25 > 89 THEN s.over_89_birth_year
	ELSE DATEPART(YEAR,DATEADD(DAY,s.date_shift, p.birth_datetime)) 
 END AS year_of_birth
,DATEPART(MONTH,DATEADD(DAY, s.date_shift, p.birth_datetime)) as month_of_birth
,1 as day_of_birth 
,DATEFROMPARTS(
	CASE WHEN DATEDIFF(DAY,p.birth_datetime,GETDATE())/365.25 > 89 THEN s.over_89_birth_year ELSE DATEPART(YEAR,DATEADD(DAY,s.date_shift, p.birth_datetime)) END,
	DATEPART(MONTH,DATEADD(DAY,s.date_shift, p.birth_datetime))
	,1
) as birth_datetime 
,race_concept_id
,ethnicity_concept_id
,1 as location_id
,1 as provider_id
,1 as care_site_id 
,0 as person_source_value 
,0 as gender_source_value 
,0 as gender_source_concept_id 
,0 as race_source_value 
,0 as race_source_concept_id 
,0 as ethnicity_source_value 
,0 as ethnicity_source_concept_id 
from [Results].[CURE_ID_Person] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id
;
/******* VISIT *******/
insert into [Results].[deident_CURE_ID_Visit_Occurrence]
select 
v.new_id as visit_occurrence_id
,s.id as person_id
,visit_concept_id
,DATEADD(DAY, s.date_shift, visit_start_date) as visit_start_date
,DATEADD(DAY, s.date_shift, visit_start_datetime) as visit_start_datetime
,DATEADD(DAY, s.date_shift, visit_end_date) as visit_end_date
,DATEADD(DAY, s.date_shift, visit_end_datetime) as visit_end_datetime
,visit_type_concept_id
,1 as provider_id
,1 as care_site_id
,NULL as visit_source_value
,visit_source_concept_id
,admitted_from_concept_id
,NULL as admitted_from_source_value
,discharged_to_concept_id
,NULL as discharged_to_source_value
,preceding_visit_occurrence_id
from [Results].[CURE_ID_Visit_Occurrence] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id
where (DATEADD(DAY, s.date_shift, visit_start_date) >= @START_DATE and DATEADD(DAY, s.date_shift, visit_end_date) <= @END_DATE) 
;
/******* CONDITION OCCURENCE *******/
insert into [Results].[deident_CURE_ID_Condition_Occurrence]
select condition_occurrence_id
,s.id as person_id
,condition_concept_id
,DATEADD(DAY, s.date_shift, condition_start_date) as condition_start_date
,DATEADD(DAY, s.date_shift, condition_start_datetime) as condition_start_datetime
,DATEADD(DAY, s.date_shift, condition_end_date) as condition_end_date
,DATEADD(DAY, s.date_shift, condition_end_datetime) as condition_end_datetime
,condition_type_concept_id
,stop_reason
,1 as provider_id
,v.new_id as visit_occurrence_id
,visit_detail_id
,condition_source_value
,condition_source_concept_id
,condition_status_source_value
,condition_status_concept_id
from [Results].[CURE_ID_Condition_Occurrence_Rare_Removed] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, condition_start_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, condition_end_date) > @START_DATE)
;
/******* PROCEDURE OCCURENCE *******/
insert into [Results].[deident_CURE_ID_Procedure_Occurrence]
SELECT procedure_occurrence_id
      ,s.id as person_id
      ,procedure_concept_id
      ,DATEADD(DAY, s.date_shift, procedure_date) as procedure_date
      ,DATEADD(DAY, s.date_shift, procedure_date) as procedure_datetime
      ,procedure_type_concept_id
      ,modifier_concept_id
      ,quantity
      ,1 as provider_id
      ,v.new_id as visit_occurrence_id
      ,visit_detail_id
      ,procedure_source_value
      ,procedure_source_concept_id
      ,modifier_source_value
from [Results].[CURE_ID_Procedure_Occurrence] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, procedure_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, procedure_date) > @START_DATE) 
;

/******* DRUG EXPOSURE *******/
insert into [Results].[deident_CURE_ID_Drug_Exposure]
SELECT  drug_exposure_id
      ,s.id as person_id
      ,drug_concept_id
      ,DATEADD(DAY, s.date_shift, drug_exposure_start_date) as drug_exposure_start_date
      ,DATEADD(DAY, s.date_shift, drug_exposure_start_date) as drug_exposure_start_datetime
      ,DATEADD(DAY, s.date_shift, drug_exposure_end_date) as drug_exposure_end_date
      ,DATEADD(DAY, s.date_shift, drug_exposure_end_date) as drug_exposure_end_datetime
      ,DATEADD(DAY, s.date_shift, verbatim_end_date) as verbatim_end_date
      ,drug_type_concept_id
      ,stop_reason
      ,refills
      ,quantity
      ,days_supply
      ,sig
      ,route_concept_id
      ,lot_number
      ,1 as provider_id
      ,v.new_id as visit_occurrence_id
      ,visit_detail_id
      ,drug_source_value
      ,drug_source_concept_id
      ,route_source_value
      ,dose_unit_source_value
from [Results].[CURE_ID_Drug_Exposure] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, drug_exposure_start_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, drug_exposure_end_date) > @START_DATE)
;
/******* OBSERVATION *******/
insert into [Results].[deident_CURE_ID_Observation]
SELECT observation_id
      ,s.id as person_id
      ,observation_concept_id
      ,DATEADD(DAY, s.date_shift, observation_date) as observation_date
      ,DATEADD(DAY, s.date_shift, observation_date) as observation_datetime
      ,observation_type_concept_id
      ,value_as_number
      ,value_as_string
      ,value_as_concept_id
      ,qualifier_concept_id
      ,unit_concept_id
      ,1 as provider_id
      ,v.new_id as visit_occurrence_id
      ,visit_detail_id
      ,observation_source_value
      ,observation_source_concept_id
      ,unit_source_value
      ,qualifier_source_value
from [Results].[CURE_ID_Observation] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, observation_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, observation_date) > @START_DATE) 
;
/******* DEATH *******/
insert into [Results].[deident_CURE_ID_Death]
select s.id as person_id
      ,DATEADD(DAY, s.date_shift, death_date) as death_date
      ,DATEADD(DAY, s.date_shift, death_date) as death_datetime
      ,death_type_concept_id
      ,cause_concept_id
      ,cause_source_value
      ,cause_source_concept_id
from [Results].[CURE_ID_Death] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
;
/******* DEVICE EXPOSURE *******/
insert into [Results].[deident_CURE_ID_Device_Exposure]
SELECT device_exposure_id
      ,s.id as person_id
      ,device_concept_id
      ,DATEADD(DAY, s.date_shift, device_exposure_start_date)  as device_exposure_start_date
      ,DATEADD(DAY, s.date_shift, device_exposure_start_date)  as device_exposure_start_datetime
      ,DATEADD(DAY, s.date_shift, device_exposure_end_date)  as device_exposure_end_date
      ,DATEADD(DAY, s.date_shift, device_exposure_end_date)  as device_exposure_end_datetime
      ,device_type_concept_id
      ,unique_device_id
      ,quantity
      ,1 provider_id
      ,v.new_id as visit_occurrence_id
      ,visit_detail_id
      ,device_source_value
      ,device_source_concept_id
from [Results].[CURE_ID_Device_Exposure] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, device_exposure_start_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, device_exposure_end_date) > @START_DATE)
;

/******* MEASUREMENT *******/
insert into [Results].[deident_CURE_ID_Measurement]
select measurement_id
      ,s.id as person_id
      ,measurement_concept_id
      ,DATEADD(DAY, s.date_shift, measurement_date) as measurement_date
      ,DATEADD(DAY, s.date_shift, measurement_date) measurement_datetime
      ,measurement_time
      ,measurement_type_concept_id
      ,operator_concept_id
      ,value_as_number
      ,value_as_concept_id
      ,unit_concept_id
      ,range_low
      ,range_high
      ,1 as provider_id
      ,v.new_id as visit_occurrence_id
      ,visit_detail_id
      ,measurement_source_value
      ,measurement_source_concept_id
      ,unit_source_value
      ,value_source_value
from [Results].[CURE_ID_Measurement] p
inner join [Results].[source_id_person] s on s.sourceKey = p.person_id 
left join [Results].[source_id_visit] v on v.sourceKey = p.visit_occurrence_id 
where (DATEADD(DAY, s.date_shift, measurement_date) < @END_DATE 
and DATEADD(DAY, s.date_shift, measurement_date) > @START_DATE) 
;
