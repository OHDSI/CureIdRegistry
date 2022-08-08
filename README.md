CureIdRegistry

The Cure Id Registry is a clinical registry leveraging OMOP and EHR automation.  CURE ID is a collaboration between the FDA and the National Center for Advancing Translational Sciences (NCATS), part of the National Institutes of Health (NIH).

This Github repository is the migrated documentation from the FDA Cure ID project. This move was motivated by the inconsistencies of the current storage method, in Microsoft Teams. This repository takes the Concept list from the Cure-ID Registry group, within the Health Special Interests Teams group, and combines it with the Cohort Creation scripts from the Cure**S** ID Registry group, also within the same Teams environment. 

The cohorts extract the anonymized person_id, birthdate, and first date of a positive COVID test from the OMOP CDM. 

--------------------------------------------------------------------------------------------------

Explanation of the scripts:

01 Cohort Creation: 
1. Identify all patients with a positive lab result measurement (get patient_id, first positive result)
2. Separately, identify all patients with a "strong" or "weak" COVID diagnosis based on condition codes
3. Combine these "strong" and "weak" tables into a "comb" table
4. Make an intermediary table "inpat_intermed" which is all patients with a positive lab result, who were flagged as inpatient treatment
5. Join the positive-lab-result, "inpat_intermed" and "comb" tables to get the criteria of the cohort (sans edge cases)

In summary the cohort contains patients who were hospitalized with COVID, and experienced symptoms that suggest COVID played a significant role in their hospitalization. They tested positive for COVID,  who started in-patient care 7 days before through 21 days after a positive test, and experienced COVID-symptoms around 2 weeks before or after their in-patient period. If the patient was hospitalized more than once, we prioritize the earliest occurrence. 
