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
   (2000000999, NULL, NULL, NULL, NULL, NULL, 'FALSE'),  --Advance branch
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