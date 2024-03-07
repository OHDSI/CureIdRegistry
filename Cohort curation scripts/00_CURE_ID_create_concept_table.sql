DROP TABLE IF EXISTS [Results].[cure_id_concepts];
CREATE TABLE [Results].[cure_id_concepts]
(
	concept_id		INTEGER	NOT NULL,
	concept_code	VARCHAR(50) NULL,
	concept_name	VARCHAR(250) NULL,
	domain	VARCHAR(50) NULL,
	vocabulary	VARCHAR(50) NULL,
	is_standard	VARCHAR(50) NULL,
	include_descendants VARCHAR(50) NULL
)
;

INSERT INTO [Results].[cure_id_concepts]
VALUES
   (2000000999, NULL, NULL, 'Observation', NULL, NULL, 'FALSE'),  --Advance branch
   (24966, '28670008', 'Esophageal varices', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (80800, '31384009', 'Polymyositis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (80809, '69896004', 'Rheumatoid arthritis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (134442, '89155008', 'Systemic sclerosis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (192606, '60389000', 'Paraplegia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (192680, '34742003', 'Portal hypertension', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (201820, '73211009', 'Diabetes mellitus', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (255348, '65323003', 'Polymyalgia rheumatica', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (256197, '398726004', 'Rheumatoid lung disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (257628, '55464009', 'Systemic lupus erythematosus', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (316139, '84114007', 'Heart failure', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (321052, '400047006', 'Peripheral vascular disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (374022, '50582007', 'Hemiplegia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (381591, '62914000', 'Cerebrovascular disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (432851, '128462008', 'Secondary malignant neoplastic disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (434056, '195239002', 'Late effects of cerebrovascular disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (439727, '86406008', 'Human immunodeficiency virus infection', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (442793, '74627003', 'Complication due to diabetes mellitus', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (443392, '363346000', 'Malignant neoplastic disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (443767, '25093002', 'Disorder of eye due to diabetes mellitus', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4029488, '13920009', 'Hepatic encephalopathy', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4030518, '236423003', 'Renal impairment', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4063381, '17097001', 'Chronic disease of respiratory system', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4064161, '19943007', 'Cirrhosis of liver', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4182210, '52448006', 'Dementia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4212540, '328383001', 'Chronic liver disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4245975, '59927004', 'Hepatic failure', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4247120, '40845000', 'Gastrointestinal ulcer', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (4329847, '22298006', 'Myocardial infarction', 'Condition', 'SNOMED', 'S', 'TRUE'),  --Charlson
   (1175907, '90886-3', 'Influenza virus B RNA [Cycle Threshold #] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (1761752, '100343-3', 'Influenza virus B RNA [Presence] in Saliva (oral fluid) by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (3030134, '49535-8', 'Influenza virus B RNA [Presence] in Isolate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (3033001, '49536-6', 'Influenza virus B RNA [Identifier] in Isolate by Sequencing', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (3038288, '40982-1', 'Influenza virus B RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (3039888, '53251-5', 'Influenza virus B RNA [#/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (21493336, '82170-2', 'Influenza virus B RNA [Presence] in Nasopharynx by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (21495067, '81309-7', 'Influenza virus B RNA [Cycle Threshold #] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36203322, '85478-6', 'Influenza virus B RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36204261, '86571-7', 'Influenza virus B RNA [Presence] in Cerebral spinal fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36204262, '86572-5', 'Influenza virus B RNA [Presence] in Tissue by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36303847, '88195-3', 'Influenza virus B RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36304919, '88592-1', 'Influenza virus B RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (36305766, '88596-2', 'Influenza virus B RNA [Presence] in Pericardial fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (37021109, '92976-0', 'Influenza virus B RNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (37021252, '92141-1', 'Influenza virus B RNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (46235758, '76079-3', 'Influenza virus B RNA [Presence] in Bronchoalveolar lavage by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (46235759, '76080-1', 'Influenza virus B RNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37024394|LP378559-1|Influenza virus B RNA | XXX | Microbiology
   (3042208, '41000-1', 'Human coronavirus RNA [Identifier] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (3042596, '41001-9', 'Human coronavirus RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (36303349, '88628-3', 'Human coronavirus RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (36303355, '88620-0', 'Human coronavirus RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (36304988, '88627-5', 'Human coronavirus RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (36305929, '88614-3', 'Human coronavirus RNA [Presence] in Aspirate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (37021050, '92979-4', 'Human coronavirus RNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (40763320, '60265-6', 'Human coronavirus RNA [Presence] in Serum or Plasma by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37025945|LP377195-5|Human coronavirus RNA | XXX | Microbiology
   (3035826, '35383-9', 'Galactomannan Ag [Units/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (3036424, '35671-7', 'Galactomannan Ag [Units/volume] in Specimen', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (3045331, '44357-2', 'Galactomannan Ag [Units/volume] in Serum or Plasma by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (3046760, '44099-0', 'Galactomannan Ag [Presence] in Serum or Plasma by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (3050899, '53865-2', 'Galactomannan Ag [Units/volume] in Cerebral spinal fluid', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (36303951, '88555-8', 'Galactomannan Ag [Presence] in Bronchoalveolar lavage', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (40765204, '62467-6', 'Galactomannan Ag [Units/volume] in Specimen by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (46235754, '76075-1', 'Galactomannan Ag [Units/volume] in Bronchoalveolar lavage', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37033649|LP376244-2|Galactomannan Ag | Serum or Plasma | Microbiology
   (1176105, '90463-1', 'Adenovirus DNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (1989093, '99386-5', 'Adenovirus DNA [Log #/volume] (viral load) in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3028979, '49341-1', 'Adenovirus DNA [#/volume] (viral load) in Blood by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3029254, '49336-1', 'Adenovirus DNA [#/volume] (viral load) in Bronchoalveolar lavage by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3029524, '49338-7', 'Adenovirus DNA [#/volume] (viral load) in Cerebral spinal fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3030149, '49337-9', 'Adenovirus DNA [#/volume] (viral load) in Bone marrow by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3032207, '49334-6', 'Adenovirus DNA [#/volume] (viral load) in Serum or Plasma by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3032682, '49340-3', 'Adenovirus DNA [#/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3033020, '49339-5', 'Adenovirus DNA [#/volume] (viral load) in Stool by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3033255, '49335-3', 'Adenovirus DNA [#/volume] (viral load) in Tissue by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3036522, '21055-9', 'Adenovirus DNA [Presence] in Serum or Plasma by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3038281, '40975-5', 'Adenovirus DNA [Identifier] in Specimen by RFLP', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3040853, '40976-3', 'Adenovirus DNA [Identifier] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3041623, '39528-5', 'Adenovirus DNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3048178, '38375-2', 'Adenovirus DNA [Presence] in Cerebral spinal fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (3049223, '48609-2', 'Adenovirus DNA [#/volume] (viral load) in Urine by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (21493329, '82160-3', 'Adenovirus DNA [Presence] in Nasopharynx by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36032114, '96503-8', 'Adenovirus DNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36203754, '86510-5', 'Adenovirus DNA [Presence] in Tissue by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36203755, '86511-3', 'Adenovirus DNA [Presence] in Blood by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36203756, '86512-1', 'Adenovirus DNA [Presence] in Urine by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36304136, '88533-5', 'Adenovirus DNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36304215, '88541-8', 'Adenovirus DNA [Presence] in Aspirate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (36304745, '88539-2', 'Adenovirus DNA [Presence] in Stool by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (37019639, '92854-9', 'Adenovirus DNA [#/volume] (viral load) in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (37020093, '91820-1', 'Adenovirus DNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (37020807, '92987-7', 'Adenovirus DNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40763314, '60259-9', 'Adenovirus DNA [Presence] in Isolate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40765217, '62480-9', 'Adenovirus DNA [Presence] in Bronchoalveolar lavage by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40766755, '64038-3', 'Adenovirus DNA [Log #/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769379, '66719-6', 'Adenovirus DNA [Log #/volume] (viral load) in Urine by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769380, '66720-4', 'Adenovirus DNA [Log #/volume] (viral load) in Body fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769381, '66721-2', 'Adenovirus DNA [#/volume] (viral load) in Body fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769382, '66722-0', 'Adenovirus DNA [Log #/volume] (viral load) in Tissue by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769383, '66723-8', 'Adenovirus DNA [Log #/volume] (viral load) in Serum or Plasma by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769384, '66724-6', 'Adenovirus DNA [Log #/volume] (viral load) in Stool by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769385, '66725-3', 'Adenovirus DNA [Log #/volume] (viral load) in Blood by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769386, '66726-1', 'Adenovirus DNA [Log #/volume] (viral load) in Genital specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769387, '66727-9', 'Adenovirus DNA [#/volume] (viral load) in Genital specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769388, '66728-7', 'Adenovirus DNA [Log #/volume] (viral load) in Skin by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769389, '66729-5', 'Adenovirus DNA [#/volume] (viral load) in Skin by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769390, '66730-3', 'Adenovirus DNA [Log #/volume] (viral load) in Cerebral spinal fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (40769391, '66731-1', 'Adenovirus DNA [Log #/volume] (viral load) in Sputum or Bronchial by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (46235749, '76070-2', 'Adenovirus DNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050195|LP377083-3|Adenovirus DNA | XXX | Microbiology
   (1761540, '100344-1', 'Influenza virus A RNA [Presence] in Saliva (oral fluid) by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (3032475, '49531-7', 'Influenza virus A RNA [Presence] in Isolate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (3042219, '53250-7', 'Influenza virus A RNA [#/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (3044938, '34487-9', 'Influenza virus A RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (3046850, '44263-2', 'Influenza virus A RNA [Units/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (21493332, '82166-0', 'Influenza virus A RNA [Presence] in Nasopharynx by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (21495066, '81308-9', 'Influenza virus A RNA [Cycle Threshold #] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36203321, '85477-8', 'Influenza virus A RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36204258, '86568-3', 'Influenza virus A RNA [Presence] in Cerebral spinal fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36204259, '86569-1', 'Influenza virus A RNA [Presence] in Tissue by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36303833, '88600-2', 'Influenza virus A RNA [Presence] in Pericardial fluid by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36304962, '88193-8', 'Influenza virus A RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (36305662, '88599-6', 'Influenza virus A RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (37020635, '92142-9', 'Influenza virus A RNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (37020995, '92977-8', 'Influenza virus A RNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (46235756, '76077-7', 'Influenza virus A RNA [Presence] in Bronchoalveolar lavage by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (46235757, '76078-5', 'Influenza virus A RNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37050664|LP378502-1|Influenza virus A RNA | XXX | Microbiology
   (1175203, '91131-3', 'Rhinovirus RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (3025023, '7993-9', 'Rhinovirus RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (3040406, '40990-4', 'Rhinovirus RNA [Identifier] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (36303481, '88213-4', 'Rhinovirus RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (37019747, '91793-0', 'Rhinovirus RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (37020003, '92130-4', 'Rhinovirus RNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (46236735, '77025-5', 'Rhinovirus RNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37055446|LP378971-8|Rhinovirus RNA | XXX | Microbiology
   (1176171, '91133-9', 'Respiratory syncytial virus RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (3043924, '40987-0', 'Respiratory syncytial virus RNA [Identifier] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (3044254, '40988-8', 'Respiratory syncytial virus RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (21493342, '82176-9', 'Respiratory syncytial virus RNA [Presence] in Nasopharynx by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (36203323, '85479-4', 'Respiratory syncytial virus RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (36304900, '88528-5', 'Respiratory syncytial virus RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (37019493, '92957-0', 'Respiratory syncytial virus RNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (37021152, '92131-2', 'Respiratory syncytial virus RNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (40763326, '60271-4', 'Respiratory syncytial virus RNA [Presence] in Isolate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (46235767, '76088-4', 'Respiratory syncytial virus RNA [Presence] in Bronchoalveolar lavage by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (46235794, '76089-2', 'Respiratory syncytial virus RNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37065137|LP378960-1|Respiratory syncytial virus RNA | XXX | Microbiology
   (1176113, '89651-4', 'Human metapneumovirus RNA [Presence] in Lower respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (3038522, '40978-9', 'Human metapneumovirus RNA [Identifier] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (3040511, '53249-9', 'Human metapneumovirus RNA [#/volume] (viral load) in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (3042194, '38917-1', 'Human metapneumovirus RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (21493149, '82165-2', 'Human metapneumovirus RNA [Presence] in Nasopharynx by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (36303433, '88534-3', 'Human metapneumovirus RNA [Presence] in Cornea or Conjunctiva by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (37020057, '91809-4', 'Human metapneumovirus RNA [Presence] in Upper respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (37020565, '92978-6', 'Human metapneumovirus RNA [Presence] in Lower respiratory specimen by NAA with non-probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (37020808, '92134-6', 'Human metapneumovirus RNA [Presence] in Respiratory specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (40763321, '60266-4', 'Human metapneumovirus RNA [Presence] in Isolate by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (46236734, '77024-8', 'Human metapneumovirus RNA [Presence] in Nasopharynx by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37068812|LP378241-6|Human metapneumovirus RNA | XXX | Microbiology
   (3000062, '19108-0', 'Histoplasma capsulatum Ag [Presence] in Serum', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3002786, '19109-8', 'Histoplasma capsulatum Ag [Presence] in Specimen', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3005048, '19107-2', 'Histoplasma capsulatum Ag [Units/volume] in Serum by Radioimmunoassay (RIA)', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3005263, '31856-8', 'Histoplasma capsulatum Ag [Units/volume] in Urine', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3017325, '13971-7', 'Histoplasma capsulatum Ag [Units/volume] in Urine by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3022300, '31855-0', 'Histoplasma capsulatum Ag [Units/volume] in Serum', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3024411, '6428-7', 'Histoplasma capsulatum Ag [Units/volume] in Serum by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3031957, '42916-7', 'Histoplasma capsulatum Ag [Units/volume] in Specimen by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3035835, '35734-3', 'Histoplasma capsulatum Ag [Presence] in Urine', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3039780, '53931-2', 'Histoplasma capsulatum Ag [Units/volume] in Cerebral spinal fluid by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3040259, '51754-0', 'Histoplasma capsulatum Ag [Mass/volume] in Cerebral spinal fluid by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3041268, '51753-2', 'Histoplasma capsulatum Ag [Mass/volume] in Serum by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3041999, '40776-7', 'Histoplasma capsulatum Ag [Presence] in Cerebral spinal fluid', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3044418, '44870-4', 'Histoplasma capsulatum Ag [Presence] in Urine by Radioimmunoassay (RIA)', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3045349, '44525-4', 'Histoplasma capsulatum Ag [Presence] in Serum by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3045525, '34158-6', 'Histoplasma capsulatum Ag [Units/volume] in Cerebral spinal fluid', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3045754, '34171-9', 'Histoplasma capsulatum Ag [Units/volume] in Specimen', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3047267, '44524-7', 'Histoplasma capsulatum Ag [Presence] in Urine by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3048508, '48338-8', 'Histoplasma capsulatum Ag [Presence] in Tissue by Immune stain', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3048918, '48952-6', 'Histoplasma capsulatum Ag [Mass/volume] in Urine', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (3050603, '53930-4', 'Histoplasma capsulatum Ag [Units/volume] in Bronchoalveolar lavage by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (36659888, '95073-3', 'Histoplasma capsulatum Ag [Mass/volume] in Bronchoalveolar lavage by Immunoassay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (40760876, '57766-8', 'Histoplasma capsulatum Ag [Mass/volume] in Body fluid', 'Measurement', 'LOINC', 'S', 'FALSE'),  --Expanded LOINC|37069484|LP376381-2|Histoplasma capsulatum Ag | Serum | Microbiology
   (4152194, '271649006', 'Systolic blood pressure', 'Measurement', 'SNOMED', 'S', 'FALSE'),  --Site
   (4154790, '271650006', 'Diastolic blood pressure', 'Measurement', 'SNOMED', 'S', 'FALSE'),  --Site
   (436677, '17226007', 'Adjustment disorder', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (437449, '397940009', 'Victim of child abuse', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (439664, '160822004', 'Relationship problems', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4019836, '105412007', 'Social exclusion', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4019971, '105515007', 'Discord in school', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022078, '105520007', 'Discord with counselor', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022639, '105413002', 'Acculturation difficulty', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4100089, '192119003', 'Sibling jealousy', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4107655, '284465006', 'Finding relating to psychosocial functioning', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4204229, '54038000', 'Insecurity', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4217086, '417427001', 'At risk of discriminatory abuse', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4275902, '64313000', 'Alteration in family processes', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4279142, '65367001', 'Victim status', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (37207707, '82531000000100', 'At risk of homelessness', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020462, '287991000119107', 'Discord with neighbors, lodgers and landlord', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020468, '288171000119109', 'Child in welfare custody', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020488, '288561000119106', 'Problem related to release from prison', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020489, '288571000119100', 'Psychosocial problems related to multiparity', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43021845, '151901000119101', 'Psychosocial problems related to unwanted pregnancy', 'Condition', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (1340204, 'OMOP5165859', 'History of event', 'Observation', 'OMOP Extension', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (439395, '371775004', 'Emotional abuse of child', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (762059, '288431000119102', 'Inadequate parental supervision and control', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (765265, '15929301000119104', 'Problem related to living in residential institution', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4009858, '102425009', 'Exposure to polluted air, occupational', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4010022, '102610002', 'Inadequate food diet', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4010331, '102442003', 'Exposure to toxic agricultural agents, occupational', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4015401, '11403006', 'Financially poor', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022050, '105419003', 'Academic underachievement', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022065, '105483008', 'Overprotective parent', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022070, '105497000', 'Threat of dismissal', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022652, '105477005', 'Failed exams', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022658, '105514006', 'Discord in the workplace', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4022661, '105531004', 'Housing problem', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4023168, '105529008', 'Lives alone', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4031491, '14345008', 'Parent/child conflict', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4052625, '160932005', 'Financial problem', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4059628, '160881008', 'Institutionalized childhood', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4059637, '160909006', 'Work environment deleterious', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4059786, '161138004', 'Literacy problems', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4076209, '224229008', 'Sleeping out', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4094126, '248539004', 'Family problems', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4105261, '281575007', 'Family social history', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4139934, '32911000', 'Homeless', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4154624, '271437004', 'Problem situation relating to social and personal history', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4166675, '45361006', 'Imprisonment', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4171584, '276068009', 'Changed job', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4175353, '425022003', 'Inadequate social support', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4175370, '276072008', 'Sexual problems at work', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4177669, '49588008', 'Military services member', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4188165, '414418009', 'Housed', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4251171, '73438004', 'Unemployed', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4261613, '4506002', 'Educational problem', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4273155, '365510008', 'Temporary shelter arrangements - finding', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4296024, '76799001', 'Family disruption due to divorce', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4301229, '78427001', 'Occupational noise exposure', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4310138, '424860001', 'Low income', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4311456, '424466003', 'Water supply insufficient', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4326265, '75148009', 'Employment problem', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (4329840, '22268004', 'Legal problem', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (35622979, '765226004', 'Occupational exposure to extreme temperature', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (36712857, '134561000119109', 'Family disruption due to death of family member', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (37108964, '15936461000119100', 'Stressful work schedule', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (37116643, '733423003', 'Food insecurity', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (37395583, '288001000119103', 'Family member absent due to military deployment', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (42535209, '16090451000119101', 'Occupational exposure to radiation', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (42536905, '735932007', 'Occupational exposure to vibration', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (42537800, '737376008', 'Uncongenial work environment', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (42539211, '16090691000119109', 'Occupational exposure to dust', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020416, '105661000119103', 'Problem with aged spouse or partner', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020469, '288231000119101', 'Cares for dependent relative at home', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020484, '288501000119105', 'Parent child estrangement', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020486, '288541000119107', 'Problem related to upbringing', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43020487, '288551000119109', 'Problem in relationship with in-laws', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43021798, '473447008', 'Exerting inappropriate parental pressure', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (43021867, '288531000119103', 'Problem related to social environment', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (44782749, '134571000119103', 'Family disruption due to extended absence of family member', 'Observation', 'SNOMED', 'S', 'FALSE'),  --Z code mapped to SNOMED
   (201820, '73211009', 'Diabetes mellitus', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (255573, '13645005', 'Chronic obstructive lung disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (316866, '38341003', 'Hypertensive disorder', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (317009, '195967001', 'Asthma', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (438112, '55342001', 'Neoplastic disease', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (439727, '86406008', 'Human immunodeficiency virus infection', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4028244, '128292002', 'Chronic disease of cardiovascular system', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4063381, '17097001', 'Chronic disease of respiratory system', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4299535, '77386006', 'Pregnant', 'Condition', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (2004208004, NULL, 'Other oxygen device', 'Device', 'Custom', 'C', 'FALSE'),  --from extraction script
   (2004208005, NULL, 'Room air (in the context of a device)', 'Device', 'Custom', 'C', 'FALSE'),  --from extraction script
   (2004208006, NULL, 'CPAP (continuous positive airway pressure)', 'Device', 'Custom', 'C', 'FALSE'),  --from extraction script
   (2004208007, NULL, 'BiPAP (bilevel positive airway pressure)', 'Device', 'Custom', 'C', 'FALSE'),  --from extraction script
   (2004208008, NULL, 'NIPPV (non-invasive positive pressure ventilation or nasal intermittent positive pressure ventilation)', 'Device', 'Custom', 'C', 'FALSE'),  --from extraction script
   (4138487, '426294006', 'Face tent oxygen delivery device', 'Device', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4164918, '45633005', 'Peritoneal dialyzer', 'Device', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4222966, '336602003', 'Oxygen mask', 'Device', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4224038, '336623009', 'Oxygen nasal cannula', 'Device', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4281167, '36965003', 'Hemodialysis machine', 'Device', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (40493026, '449071006', 'Mechanical ventilator', 'Device', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (45768197, '706172005', 'Ventilator', 'Device', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (21600280, 'C01CA', 'Adrenergic and dopaminergic agents', 'Drug', 'ATC', 'C', 'TRUE'),  --from extraction script
   (1135766, '8163', 'phenylephrine', 'Drug', 'RxNorm', 'S', 'FALSE'),  --from extraction script
   (1321341, '7512', 'norepinephrine', 'Drug', 'RxNorm', 'S', 'FALSE'),  --from extraction script
   (1337720, '3616', 'dobutamine', 'Drug', 'RxNorm', 'S', 'FALSE'),  --from extraction script
   (1343916, '3992', 'epinephrine', 'Drug', 'RxNorm', 'S', 'FALSE'),  --from extraction script
   (1507835, '11149', 'vasopressin (USP)', 'Drug', 'RxNorm', 'S', 'FALSE'),  --from extraction script
   (38003563, 'Hispanic', 'Hispanic or Latino', 'Ethnicity', 'Ethnicity', 'S', 'FALSE'),  --from extraction script
   (38003564, 'Not Hispanic', 'Not Hispanic or Latino', 'Ethnicity', 'Ethnicity', 'S', 'FALSE'),  --from extraction script
   (8507, 'M', 'MALE', 'Gender', 'Gender', 'S', 'FALSE'),  --from extraction script
   (8521, 'O', 'OTHER', 'Gender', 'Gender', 'N', 'FALSE'),  --from extraction script
   (8532, 'F', 'FEMALE', 'Gender', 'Gender', 'S', 'FALSE'),  --from extraction script
   (8551, 'U', 'UNKNOWN', 'Gender', 'Gender', 'N', 'FALSE'),  --from extraction script
   (8570, 'A', 'AMBIGUOUS', 'Gender', 'Gender', 'N', 'FALSE'),  --from extraction script
   (3000963, '718-7', 'Hemoglobin [Mass/volume] in Blood', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3002385, '30385-9', 'Erythrocyte distribution width [Ratio]', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3004249, '8480-6', 'Systolic blood pressure', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3005629, '3151-8', 'Inhaled oxygen flow rate', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3006315, '26444-0', 'Basophils [#/volume] in Blood', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3007220, '2157-6', 'Creatine kinase [Enzymatic activity/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3007461, '26515-7', 'Platelets [#/volume] in Blood', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3010834, '778-1', 'Platelets [#/volume] in Blood by Manual count', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3012888, '8462-4', 'Diastolic blood pressure', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3013721, '1920-8', 'Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3016502, '2708-6', 'Oxygen saturation in Arterial blood', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3018677, '14979-9', 'aPTT in Platelet poor plasma by Coagulation assay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3020460, '1988-5', 'C reactive protein [Mass/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3020891, '8310-5', 'Body temperature', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3022217, '6301-6', 'INR in Platelet poor plasma by Coagulation assay', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3022893, '1916-6', 'Aspartate aminotransferase/Alanine aminotransferase [Enzymatic activity ratio] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3023091, '26881-3', 'Interleukin 6 [Mass/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3023361, '7799-0', 'Deprecated Fibrin D-dimer [Units/volume] in Platelet poor plasma', 'Measurement', 'LOINC', 'N', 'TRUE'),  --from extraction script
   (3024171, '9279-1', 'Respiratory rate', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3024929, '777-3', 'Platelets [#/volume] in Blood by Automated count', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3025315, '29463-7', 'Body weight', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3026238, '19996-8', 'Oxygen/Inspired gas Respiratory system --on ventilator', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3027018, '8867-4', 'Heart rate', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3027801, '2703-7', 'Oxygen [Partial pressure] in Arterial blood', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3034022, '42929-0', 'Lactate dehydrogenase panel - Serum or Plasma', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3034426, '5902-2', 'Prothrombin time (PT)', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3036277, '8302-2', 'Body height', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3038553, '39156-5', 'Body mass index (BMI) [Ratio]', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3045262, '45066-8', 'Creatinine and Glomerular filtration rate.predicted panel - Serum, Plasma or Blood', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (3045524, '34543-9', 'Bilirubin direct and total panel [Mass/volume] - Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (3046279, '33959-8', 'Procalcitonin [Mass/volume] in Serum or Plasma', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (37032427, 'LP394019-6', 'Fibrinogen | Platelet poor plasma | Coagulation', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37041261, 'LP393348-0', 'Erythrocyte distribution width | Red Blood Cells | Hematology and Cell counts', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37041593, 'LP393946-1', 'aPTT | Platelet poor plasma | Coagulation', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37042222, 'LP392736-7', 'Basophils | Blood | Hematology and Cell counts', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37043992, 'LP392599-9', 'Leukocytes | Blood | Hematology and Cell counts', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37051715, 'LP394015-4', 'Fibrin D-dimer FEU | Platelet poor plasma | Coagulation', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37063873, 'LP385942-0', 'Troponin I.cardiac | Serum or Plasma | Chemistry - non-challenge', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37070108, 'LP392479-4', 'Hematocrit | Blood | Hematology and Cell counts', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (37070654, 'LP385083-3', 'Ferritin | Serum or Plasma | Chemistry - non-challenge', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40652525, 'LG5272-2', 'Alanine aminotransferase|CCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40652709, 'LG6199-6', 'Bilirubin|MCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40652870, 'LG6657-3', 'Creatinine|MCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653085, 'LG7967-5', 'Glucose|MCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653238, 'LG6039-4', 'Lactate|SCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653596, 'LG10990-6', 'Potassium|SCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653762, 'LG11363-5', 'Sodium|SCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653900, 'LG1314-6', 'Urea nitrogen|MCnc|Pt|ANYBldSerPl', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40653994, 'LG32849-8', 'Eosinophils|NCnc|Pt|Bld', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40654045, 'LG32863-9', 'Lymphocytes|NCnc|Pt|Bld', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40654069, 'LG32885-2', 'Monocytes|NCnc|Pt|Bld', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40654088, 'LG32886-0', 'Neutrophils|NCnc|Pt|Bld', 'Measurement', 'LOINC', 'C', 'TRUE'),  --from extraction script
   (40762499, '59408-5', 'Oxygen saturation in Arterial blood by Pulse oximetry', 'Measurement', 'LOINC', 'S', 'FALSE'),  --from extraction script
   (40771922, '69405-9', 'Glomerular filtration rate/1.73 sq M.predicted [Volume Rate/Area] in Serum, Plasma or Blood', 'Measurement', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (703443, '1300671000000104', 'COVID-19 severity scale', 'Measurement', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4141684, '427081008', 'Delivered oxygen flow rate', 'Measurement', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4353936, '250774007', 'Inspired oxygen concentration', 'Measurement', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (45889365, '1012740', 'Dialysis Services and Procedures', 'Observation', 'CPT4', 'C', 'TRUE'),  --from extraction script
   (3046853, '32624-9', 'Race', 'Observation', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (36033639, '97155-6', 'SARS coronavirus 2 (COVID-19) immunization status', 'Observation', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (46235215, '76691-5', 'Gender identity', 'Observation', 'LOINC', 'S', 'TRUE'),  --from extraction script
   (4039922, '229306004', 'Positive pressure therapy', 'Observation', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4275495, '365981007', 'Tobacco smoking behavior - finding', 'Observation', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4298794, '77176002', 'Smoker', 'Observation', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (2213572, '90935', 'Hemodialysis procedure with single evaluation by a physician or other qualified health care professional', 'Procedure', 'CPT4', 'S', 'FALSE'),  --from extraction script
   (2213573, '90937', 'Hemodialysis procedure requiring repeated evaluation(s) with or without substantial revision of dialysis prescription', 'Procedure', 'CPT4', 'S', 'FALSE'),  --from extraction script
   (2213576, '90945', 'Dialysis procedure other than hemodialysis (eg, peritoneal dialysis, hemofiltration, or other continuous renal replacement therapies), with single evaluation by a physician or other qualified health care professional', 'Procedure', 'CPT4', 'S', 'TRUE'),  --from extraction script
   (45889034, '1012752', 'Hemodialysis Procedures', 'Procedure', 'CPT4', 'C', 'TRUE'),  --from extraction script
   (46257585, '1022227', 'Extracorporeal membrane oxygenation (ECMO)/extracorporeal life support (ECLS) provided by physician', 'Procedure', 'CPT4', 'C', 'TRUE'),  --from extraction script
   (3171077, '28690001000004105', 'Emergent dialysis', 'Procedure', 'Nebraska Lexicon', 'S', 'FALSE'),  --from extraction script
   (3655896, '870386000', 'Vasopressor therapy', 'Procedure', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (3655950, '870533002', 'Heated and humidified high flow oxygen therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4052536, '233573008', 'Extracorporeal membrane oxygenation', 'Procedure', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4082249, '182714002', 'Oxygenator therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4119964, '304577004', 'Humidified oxygen therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4120120, '302497006', 'Hemodialysis', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4146536, '265764009', 'Renal dialysis', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4155151, '371907003', 'Oxygen administration by nasal cannula', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4162736, '371908008', 'Oxygen administration by mask', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4177224, '428311008', 'Noninvasive ventilation', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4201025, '315041000', 'High concentration oxygen therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4216695, '71786000', 'Intranasal oxygen therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4230167, '40617009', 'Artificial respiration', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (4237460, '408853006', 'Intermittent positive pressure ventilation via endotracheal tube', 'Procedure', 'SNOMED', 'S', 'TRUE'),  --from extraction script
   (4324124, '71192002', 'Peritoneal dialysis', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (37018292, '714749008', 'Continuous renal replacement therapy', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (40486624, '447837008', 'Noninvasive positive pressure ventilation', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (44790731, '240051000000102', 'Oxygen administration by non rebreather mask', 'Procedure', 'SNOMED', 'S', 'FALSE'),  --from extraction script
   (8515, '2', 'Asian', 'Race', 'Race', 'S', 'FALSE'),  --from extraction script
   (8516, '3', 'Black or African American', 'Race', 'Race', 'S', 'FALSE'),  --from extraction script
   (8527, '5', 'White', 'Race', 'Race', 'S', 'FALSE'),  --from extraction script
   (8557, '4', 'Native Hawaiian or Other Pacific Islander', 'Race', 'Race', 'S', 'FALSE'),  --from extraction script
   (8657, '1', 'American Indian or Alaska Native', 'Race', 'Race', 'S', 'FALSE'),  --from extraction script
   (280, '1', 'Medicare', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (289, '2', 'Medicaid', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (327, '5', 'Private Health Insurance', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (332, '6', 'Blue Cross/Blue Shield', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (340, '7', 'Managed Care, Unspecified', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (375, '31', 'Department of Defense', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (383, '32', 'Department of Veterans Affairs', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (436, '81', 'Self-pay', 'Payer', 'SOPT', 'S', 'TRUE'),  --payer
   (132736, '5758002', 'Bacteremia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (192671, '74474003', 'Gastrointestinal hemorrhage', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (197320, '14669001', 'Acute renal failure syndrome', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (197494, '50711007', 'Viral hepatitis C', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (253796, '36118008', 'Pneumothorax', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (254061, '60046008', 'Pleural effusion', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (257315, '53084003', 'Bacterial pneumonia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (261326, '75570004', 'Viral pneumonia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (314383, '50920009', 'Myocarditis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (319835, '42343007', 'Congestive heart failure', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (321042, '410429000', 'Cardiac arrest', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (377091, '91175000', 'Seizure', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (435785, '7180009', 'Meningitis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (436093, '67406007', 'Disseminated intravascular coagulation', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (439776, '35919005', 'Autism spectrum disorder', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (440417, '59282003', 'Pulmonary embolism', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (441589, '56819008', 'Endocarditis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (4195694, '67782005', 'Acute respiratory distress syndrome', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (4281232, '66071002', 'Type B viral hepatitis', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (40401938, '205614001', '(Down syndrome - trisomy 21) or (mongolism) or (trisomy 21) or (trisomy 22)', 'Condition', 'SNOMED', 'N', 'TRUE'),  --refresh spreadsheet
   (43530623, '1131000119105', 'Sequela of cerebrovascular accident', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (43531681, '651000119108', 'Acute deep vein thrombosis of lower limb', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (44784217, '698247007', 'Cardiac arrhythmia', 'Condition', 'SNOMED', 'S', 'TRUE'),  --refresh spreadsheet
   (3473837, '426160001', 'Oxygen ventilator', 'Device', 'Nebraska Lexicon', 'N', 'TRUE'),  --refresh spreadsheet
   (32765, 'OMOP4873976', 'Favipiravir', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (33000, 'OMOP5043059', 'COVID-19 convalescent plasma', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (702418, '2587300', 'tixagevimab', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (702423, '2587306', 'cilgavimab', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (702530, '2587892', 'nirmatrelvir', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (702536, '2587901', 'molnupiravir', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1101554, '2683', 'colchicine', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1114375, '72435', 'anakinra', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1235357, 'OMOP5216063', 'nirmatrelvir / ritonavir Oral Tablet', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1510627, '2047232', 'baricitinib', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1518254, '3264', 'dexamethasone', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1536976, '2550731', 'sotrovimab', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1734104, '18631', 'azithromycin', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1748921, '85762', 'ritonavir', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1759073, '2592360', 'bebtelovimab', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1777087, '5521', 'hydroxychloroquine', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (1784444, '6069', 'ivermectin', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (37499271, '2284718', 'remdesivir', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (40171288, '612865', 'tocilizumab', 'Drug', 'RxNorm', 'S', 'TRUE'),  --refresh spreadsheet
   (3018198, '7889-9', 'Francisella tularensis IgG Ab [Presence] in Serum', 'Measurement', 'LOINC', 'S', 'FALSE'),  --refresh spreadsheet
   (3025634, '29908-1', 'Parainfluenza virus 1 RNA [Presence] in Specimen by NAA with probe detection', 'Measurement', 'LOINC', 'S', 'FALSE'),  --refresh spreadsheet
   (36205488, 'LP260072-6', 'Galactomannan | Bronchoalveolar lavage', 'Measurement', 'LOINC', 'N', 'FALSE'),  --refresh spreadsheet
   (36207253, 'LP256485-6', 'Histoplasma capsulatum | Urine', 'Measurement', 'LOINC', 'N', 'FALSE'),  --refresh spreadsheet
   (37024394, 'LP378559-1', 'Influenza virus B RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37024723, 'LP380002-8', 'Herpes virus 6 DNA panel | XXX | Microbiology Panels', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37025945, 'LP377195-5', 'Human coronavirus RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37033649, 'LP376244-2', 'Galactomannan Ag | Serum or Plasma | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37049794, 'LP382722-9', 'Alkaline phosphatase | Serum or Plasma | Chemistry - non-challenge', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37050195, 'LP377083-3', 'Adenovirus DNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37050664, 'LP378502-1', 'Influenza virus A RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37055446, 'LP378971-8', 'Rhinovirus RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37065137, 'LP378960-1', 'Respiratory syncytial virus RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37068812, 'LP378241-6', 'Human metapneumovirus RNA | XXX | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37069484, 'LP376381-2', 'Histoplasma capsulatum Ag | Serum | Microbiology', 'Measurement', 'LOINC', 'C', 'FALSE'),  --refresh spreadsheet
   (37075814, 'LP379721-6', '13 beta glucan | Serum | Microbiology', 'Measurement', 'LOINC', 'C', 'TRUE'),  --refresh spreadsheet
   (40773382, 'LP43012-1', 'Coccidioides immitis IgG | Bld-Ser-Plas', 'Measurement', 'LOINC', 'N', 'FALSE'),  --refresh spreadsheet
   (40796545, 'LP43013-9', 'Coccidioides immitis IgM | Bld-Ser-Plas', 'Measurement', 'LOINC', 'N', 'FALSE'),  --refresh spreadsheet
   (4203942, '52870002', 'Admitting diagnosis', 'Observation', 'SNOMED', 'S', 'FALSE')  --refresh spreadsheet
;