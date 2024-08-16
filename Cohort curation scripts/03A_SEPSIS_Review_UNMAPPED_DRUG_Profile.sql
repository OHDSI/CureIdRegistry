/*
Filename:
03A_SEPSIS_Review_UNMAPPED_DRUG_Profile.sql

Purpose:
Generate a profile of drugs that are not mapped to drug_concept_ids in the final cohort

Description:
This file filters drugs that were unsuccessfully mapped to a drug_concept_id in the sepsis cohort. Drug source values for which the
drug_concept_id is “0” and have at least 20 instances in the final cohort are
aggregated for manual review.
Drug source values can contain PHI. Please review the output for PHI before sharing.

Dependencies:
*/

SELECT *
FROM (
    SELECT
        de.drug_source_value,
        COUNT(de.drug_source_value) AS unmapped_drug_count
    FROM
        DRUG_EXPOSURE AS de
    LEFT JOIN
        [Results].[YOUR_SEPSIS_CDM_Visit_Occurrence] AS coh
        ON
            de.person_id = coh.person_id
            AND de.drug_exposure_start_date >= coh.visit_start_date
            AND de.drug_exposure_start_date <= coh.visit_end_date
    WHERE
        de.drug_concept_id = 0
    GROUP BY de.drug_source_value
) AS x1
WHERE unmapped_drug_count > 20
ORDER BY unmapped_drug_count DESC;