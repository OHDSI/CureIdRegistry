--Review source values for unmapped drugs identified as those that have a drug_concept_id of 0 that occur more than 20 times in the dataset
--Manually inspect results for PHI before sharing
select * from (
select 
    drug_source_value
    ,count(drug_source_value) as unmapped_drug_count
FROM
    DRUG_EXPOSURE de        
left join 
     [Results].[CURE_ID_Visit_Occurrence] coh
        on
        de.person_id = coh.person_id  AND
        de.drug_exposure_start_date >= coh.visit_start_date AND
        de.drug_exposure_start_date <= coh.visit_end_date
where
    drug_concept_id = 0
group by drug_source_value
) as x1
where unmapped_drug_count >20
order by unmapped_drug_count desc
