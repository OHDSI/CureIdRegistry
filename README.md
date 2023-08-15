# CureIdRegistry

The Cure Id Registry is a clinical registry leveraging OMOP and EHR automation.  CURE ID is a collaboration between the FDA and the National Center for Advancing Translational Sciences (NCATS), part of the National Institutes of Health (NIH).

This Github repository is the migrated documentation from the FDA Cure ID project. This move was motivated by the inconsistencies of the current storage method, in Microsoft Teams. This repository takes the Concept list from the Cure-ID Registry group, within the Health Special Interests Teams group, and combines it with the Cohort Creation scripts from the Cure**S** ID Registry group, also within the same Teams environment. Essentially, it is meant to be the central authority of the definition of the registry- what concepts to include, how to generate the cohort, who is included, etc.

The cohort is comprised of the anonymized person_id, birthdate, and first date of a positive COVID test from the OMOP CDM. 

## NOTICE: It is currently rather difficult to make edits directly to the repo. We are working on streamlining the process of approving users to the organization, so that they may make pull requests/direct edits.

--------------------------------------------------------------------------------------------------

## Explanation of the Curation Script Files:

01 Cohort Creation: 
1. Identify all patients with a positive lab result measurement (get patient_id, first positive result)
2. Separately, identify all patients with a "strong" or "weak" COVID diagnosis based on condition codes
3. Combine these "strong" and "weak" tables into a "comb" table
4. Make an intermediary table "inpat_intermed" which is all patients with a positive lab result, who were flagged as inpatient treatment
5. Join the positive-lab-result, "inpat_intermed" and "comb" tables to get the criteria of the cohort (sans edge cases)

In summary the cohort contains patients who were hospitalized with COVID, and experienced symptoms that suggest COVID played a significant role in their hospitalization. They tested positive for COVID,  who started in-patient care 7 days before through 21 days after a positive test, and experienced COVID-symptoms around 2 weeks before or after their in-patient period. If the patient was hospitalized more than once, we prioritize the earliest occurrence. 

02 All Tables
1. Get all person_id's that are in the cohort, as identified in the first script. 
2. Get the measurements for each person for the duration of their in-patient stay. This is limited to a hardcoded list of measurements that is relevant to the topic of COVID inpatient stay, so any measurements not on the list are not exposed. 
3. Repeat Step 2, except get the drug concept, death, observations, procedure occurrence, condition occurrence, visit occurrence, and device exposure.

03 CDM Tables

1. Defines the ddl for generating the empty OMOP CDM tables.
2. These tables are blank, and will be filled with the 04th script.

04 DE ID 
1. Load the data from the 02 script. 
2. Parse the data so that it fits into the OMOP CDM tables. 
3. Table by table, insert the parsed data into the CDM

05 Quality Checks
1. Read the count, min, and max for various columns and tables.
2. Comments say what results are expected, if the script succeeded (more documentation is needed here)

--------------------------------------------------------------------------------------------------

## Explanation of the Concept Files

Parent Only: A csv that contains only the parent (highest in the hierarchy) concepts used within the registry. When adding concepts, check 1) is the concept a parent concept and 2) if not, is the parent concept already included within the file

Parent Only, with Descendants: A list of all parent concepts, where we track and include all descendants. This is primarily used for ATLAS concept set creation.

Parent Only, no Descendants: A list of all parent concepts, where we do not track descendants. This is primarily used for ATLAS concept set creation.

Concept All: All concepts, parents or descendents. When adding concepts, check if you wish to include or exclude specific descendent concepts.

Conditions, Device Exposure, Measurements, Observations, Person, Procedures: JSON representations of each of the parent concepts, separated by OMOP domain. You can use this JSON format to directly import/export as concept sets within ATLAS. When changing concepts, it may be easier to create the respective concept set already within ATLAS, make the edits there, export as JSON and overwrite this file. 

--------------------------------------------------------------------------------------------------

## Workflow of Adding a Concept (Having ATLAS set up extremely recommended)

### Section 1: I Do Not See/Have Access to the CURE ID Concept Set in ATLAS (if you do, skip to Section 2)

If you do not see the pre-existing concept set, you will need to create a version yourself first.
1. In ATLAS, click the "Concept Sets" tab on the sidebar.
2. In the upper right corner, click "New Concept Set".
3. Click the "Import Tab"
4. Copy and paste the contents of the "OMOP_concepts_parent_with_descendants.txt" folder, and click the "Descendants" button. Add these to the concept set.
5. Copy and paste the contents of the "OMOP_concepts_parent_without_descendants.txt" folder, making sure NOT to tick the "Descendants" button. Add these to the concept set.

### Section 2: I Have Access to the CURE ID Concept Set in ATLAS

Say we want to add a concept X into the set. 

1. Consider if X is a parent concept, or if it is a child concept of a pre-existing one.
2. Append it to the corresponding file: "OMOP_concepts_parent" with or without. 
3. Go to the Cure ID Concept Set.
4. Click Import, and paste X. Click the "Descendants" button, if you are including descendants.
5. Click the "Included Concepts" tab. Depending on what X's domain is (Drug, Condition, etc) filter to see just those concepts.
6. Click the "CSV" button. This will download these concepts to a CSV file. 
7. Override the corresponding "cure_id_{domain}.csv" file in the repo.
8. Save the concept set in ATLAS, push changes to repo.