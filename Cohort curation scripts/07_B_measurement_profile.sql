-------------------------------------
--Drug Exposure Profile Tool
-----------------------------------
 


drop table if exists [Results].[cure_id_drugs_of_interest];
create table [Results].[cure_id_drugs_of_interest] (drug_category varchar(255),
                                                    concept_id int not null,
                                                    drug_description varchar(512));

insert into [Results].[cure_id_drugs_of_interest] (drug_category, concept_id, drug_description) values
   ('nirmatrelvir and ritonavir', 780186, '{10 (nirmatrelvir 150 MG Oral Tablet) / 10 (ritonavir 100 MG Oral Tablet) } Pack [Paxlovid 150 MG /100 MG Dose Pack]'),
   ('nirmatrelvir and ritonavir', 780185, '{10 (nirmatrelvir 150 MG Oral Tablet) / 10 (ritonavir 100 MG Oral Tablet) } Pack'),
   ('nirmatrelvir and ritonavir', 702577, '{20 (nirmatrelvir 150 MG Oral Tablet) / 10 (ritonavir 100 MG Oral Tablet) } Pack'),
   ('nirmatrelvir and ritonavir', 702578, '{20 (nirmatrelvir 150 MG Oral Tablet) / 10 (ritonavir 100 MG Oral Tablet) } Pack [Paxlovid 5-Day]'),
   ('nirmatrelvir and ritonavir', 702530, 'nirmatrelvir'),
   ('nirmatrelvir and ritonavir', 702531, 'nirmatrelvir 150 MG'),
   ('nirmatrelvir and ritonavir', 702535, 'nirmatrelvir 150 MG Oral Tablet'),
   ('nirmatrelvir and ritonavir', 702534, 'nirmatrelvir Oral Tablet'),
   ('remdesivir', 37499272, 'remdesivir 100 MG'),
   ('remdesivir', 36057819, 'remdesivir 100 MG Injectable Solution Box of 1'),
   ('remdesivir', 36057825, 'remdesivir 100 MG Injectable Solution [Veklury]'),
   ('remdesivir', 35896882, 'remdesivir 100 MG Injectable Solution [Veklury]'),
   ('remdesivir', 35896880, 'remdesivir 100 MG Injectable Solution [Veklury] Box of 1'),
   ('remdesivir', 36057823, 'remdesivir 100 MG Injectable Solution [Veklury] Box of 1'),
   ('remdesivir', 36057811, 'remdesivir 100 MG Injection Box of 1'),
   ('remdesivir', 37002796, 'remdesivir 100 MG Injection [Veklury]'),
   ('remdesivir', 36057814, 'remdesivir 100 MG Injection [Veklury] Box of 1'),
   ('remdesivir', 36074072, 'remdesivir 150 MG'),
   ('remdesivir', 36057828, 'remdesivir 150 MG Injectable Solution Box of 1'),
   ('remdesivir', 1145689, 'remdesivir 5 MG/ML'),
   ('remdesivir', 36074073, 'remdesivir 5 MG/ML Injectable Solution Box of 1'),
   ('remdesivir', 36074076, 'remdesivir 5 MG/ML Injectable Solution [Veklury]'),
   ('remdesivir', 35896884, 'remdesivir 5 MG/ML Injectable Solution [Veklury]'),
   ('remdesivir', 35896883, 'remdesivir 5 MG/ML Injectable Solution [Veklury] Box of 1'),
   ('remdesivir', 36074075, 'remdesivir 5 MG/ML Injectable Solution [Veklury] Box of 1'),
   ('remdesivir', 37002798, 'remdesivir 5 MG/ML Injection [Veklury]'),
   ('remdesivir', 36057833, 'remdesivir Injectable Solution'),
   ('remdesivir', 37499274, 'remdesivir Injection'),
   ('Molnupiravir', 702536, 'molnupiravir'),
   ('Molnupiravir', 702537, 'molnupiravir 200 MG'),
   ('Molnupiravir', 779914, 'molnupiravir 200 MG [Lagevrio]'),
   ('Molnupiravir', 702541, 'molnupiravir 200 MG Oral Capsule'),
   ('Molnupiravir', 779918, 'molnupiravir 200 MG Oral Capsule [Lagevrio]'),
   ('Molnupiravir', 702540, 'molnupiravir Oral Capsule'),
   ('Molnupiravir', 779917, 'molnupiravir Oral Capsule [Lagevrio]'),
   ('Molnupiravir', 702538, 'molnupiravir Oral Product'),
   ('Molnupiravir', 702539, 'molnupiravir Pill'),
   ('Favipiravir', 32765, 'Favipiravir'),
   ('Favipiravir', 36061098, 'Favipiravir 200 MG'),
   ('Favipiravir', 36061099, 'Favipiravir 200 MG [Avigan]'),
   ('Favipiravir', 36061095, 'Favipiravir 200 MG Oral Tablet'),
   ('Favipiravir', 36061097, 'Favipiravir 200 MG Oral Tablet [Avigan]'),
   ('Favipiravir', 36061096, 'Favipiravir 200 MG Oral Tablet [Avigan] Box of 100'),
   ('Favipiravir', 36061094, 'Favipiravir 200 MG Oral Tablet Box of 100'),
   ('Favipiravir', 36061100, 'Favipiravir Oral Tablet'),
   ('Favipiravir', 36061101, 'Favipiravir Oral Tablet [Avigan]'),
   ('Lopinavir and ritonavir', 19048073, 'lopinavir 100 MG / ritonavir 25 MG [Kaletra]'),
   ('Lopinavir and ritonavir', 1748985, 'lopinavir 100 MG / ritonavir 25 MG Oral Tablet'),
   ('Lopinavir and ritonavir', 1748987, 'lopinavir 100 MG / ritonavir 25 MG Oral Tablet [Kaletra]'),
   ('Lopinavir and ritonavir', 19048077, 'lopinavir 133 MG / ritonavir 33.3 MG [Kaletra]'),
   ('Lopinavir and ritonavir', 1748955, 'lopinavir 133 MG / ritonavir 33.3 MG Oral Capsule'),
   ('Lopinavir and ritonavir', 1748989, 'lopinavir 133 MG / ritonavir 33.3 MG Oral Capsule [Kaletra]'),
   ('Lopinavir and ritonavir', 19048071, 'lopinavir 200 MG / ritonavir 50 MG [Kaletra]'),
   ('Lopinavir and ritonavir', 19125242, 'lopinavir 200 MG / ritonavir 50 MG Oral Capsule'),
   ('Lopinavir and ritonavir', 19122186, 'lopinavir 200 MG / ritonavir 50 MG Oral Tablet'),
   ('Lopinavir and ritonavir', 1748986, 'lopinavir 200 MG / ritonavir 50 MG Oral Tablet [Kaletra]'),
   ('Lopinavir and ritonavir', 19048075, 'lopinavir 80 MG/ML / ritonavir 20 MG/ML [Kaletra]'),
   ('Lopinavir and ritonavir', 1748956, 'lopinavir 80 MG/ML / ritonavir 20 MG/ML Oral Solution'),
   ('Lopinavir and ritonavir', 1748988, 'lopinavir 80 MG/ML / ritonavir 20 MG/ML Oral Solution [Kaletra]'),
   ('Lopinavir and ritonavir', 40059335, 'lopinavir / ritonavir Oral Capsule'),
   ('Lopinavir and ritonavir', 40160001, 'lopinavir / ritonavir Oral Capsule [Kaletra]'),
   ('Lopinavir and ritonavir', 40059337, 'lopinavir / ritonavir Oral Solution'),
   ('Lopinavir and ritonavir', 40160002, 'lopinavir / ritonavir Oral Solution [Kaletra]'),
   ('Lopinavir and ritonavir', 40128015, 'lopinavir / ritonavir Oral Tablet'),
   ('Lopinavir and ritonavir', 40160004, 'lopinavir / ritonavir Oral Tablet [Kaletra]'),
   ('Ivermectin', 36232554, 'Stromectol Oral Product'),
   ('Ivermectin', 36232555, 'Stromectol Pill'),
   ('Ivermectin', 19085038, 'ivermectin 3 MG'),
   ('Ivermectin', 36227067, 'ivermectin Oral Product'),
   ('Ivermectin', 36227069, 'ivermectin Pill'),
   ('Ivermectin', 19081725, 'ivermectin 3 MG [Stromectol]'),
   ('Ivermectin', 40053195, 'ivermectin Oral Tablet [Stromectol]'),
   ('Ivermectin', 40053194, 'ivermectin Oral Tablet'),
   ('Hydroxychloroquine', 1777087, 'hydroxychloroquine'),
   ('Hydroxychloroquine', 40051595, 'hydroxychloroquine Oral Tablet'),
   ('Hydroxychloroquine', 40051596, 'hydroxychloroquine Oral Tablet [Plaquenil]'),
   ('Hydroxychloroquine', 40184083, 'hydroxychloroquine sulfate 200 MG'),
   ('Hydroxychloroquine', 40184084, 'hydroxychloroquine sulfate 200 MG Oral Tablet'),
   ('Hydroxychloroquine', 40184085, 'hydroxychloroquine sulfate 200 MG Oral Tablet [Plaquenil]'),
   ('Hydroxychloroquine', 40184087, 'hydroxychloroquine sulfate 200 MG [Plaquenil]'),
   ('Hydroxychloroquine', 40051597, 'hydroxychloroquine Oral Tablet [Quineprox]'),
   ('Hydroxychloroquine', 701777, 'hydroxychloroquine sulfate 100 MG'),
   ('Hydroxychloroquine', 701778, 'hydroxychloroquine sulfate 100 MG Oral Tablet'),
   ('Hydroxychloroquine', 40184086, 'hydroxychloroquine sulfate 200 MG Oral Tablet [Quineprox]'),
   ('Hydroxychloroquine', 40184088, 'hydroxychloroquine sulfate 200 MG [Quineprox]'),
   ('Hydroxychloroquine', 701779, 'hydroxychloroquine sulfate 300 MG'),
   ('Hydroxychloroquine', 701780, 'hydroxychloroquine sulfate 300 MG Oral Tablet'),
   ('Hydroxychloroquine', 40242199, 'hydroxychloroquine sulfate 400 MG'),
   ('Hydroxychloroquine', 40242200, 'hydroxychloroquine sulfate 400 MG Oral Tablet'),
   ('Dexamethasone', 1518254, 'dexamethasone'),
   ('Dexamethasone', 40028260, 'dexamethasone Injectable Solution'),
   ('Dexamethasone', 40241503, 'dexamethasone phosphate 4 MG/ML'),
   ('Dexamethasone', 40241504, 'dexamethasone phosphate 4 MG/ML Injectable Solution'),
   ('Dexamethasone', 40028601, 'dexamethasone Oral Tablet'),
   ('Dexamethasone', 40028602, 'dexamethasone Oral Tablet [Decadron]'),
   ('Dexamethasone', 1518608, 'dexamethasone 4 MG'),
   ('Dexamethasone', 19117916, 'dexamethasone 4 MG [Decadron]'),
   ('Dexamethasone', 1518292, 'dexamethasone 4 MG Oral Tablet'),
   ('Dexamethasone', 19030003, 'dexamethasone 4 MG Oral Tablet [Decadron]'),
   ('Dexamethasone', 1518607, 'dexamethasone 1.5 MG'),
   ('Dexamethasone', 19117914, 'dexamethasone 1.5 MG [Decadron]'),
   ('Dexamethasone', 19018906, 'dexamethasone 1.5 MG Oral Tablet'),
   ('Dexamethasone', 19030001, 'dexamethasone 1.5 MG Oral Tablet [Decadron]'),
   ('Dexamethasone', 1518609, 'dexamethasone 6 MG'),
   ('Dexamethasone', 19117921, 'dexamethasone 6 MG [Decadron]'),
   ('Dexamethasone', 1518293, 'dexamethasone 6 MG Oral Tablet'),
   ('Dexamethasone', 19030008, 'dexamethasone 6 MG Oral Tablet [Decadron]'),
   ('Dexamethasone', 1518606, 'dexamethasone 1 MG'),
   ('Dexamethasone', 1518259, 'dexamethasone 1 MG Oral Tablet'),
   ('Dexamethasone', 1719011, 'dexamethasone phosphate 10 MG/ML'),
   ('Dexamethasone', 19076145, 'dexamethasone phosphate 10 MG/ML Injectable Solution'),
   ('Dexamethasone', 1518603, 'dexamethasone 0.1 MG/ML'),
   ('Dexamethasone', 19088972, 'dexamethasone 0.1 MG/ML [Decadron]'),
   ('Dexamethasone', 19076136, 'dexamethasone 0.1 MG/ML Oral Solution'),
   ('Dexamethasone', 1518851, 'dexamethasone 0.1 MG/ML Oral Solution [Decadron]'),
   ('Dexamethasone', 40028599, 'dexamethasone Oral Solution'),
   ('Dexamethasone', 40146415, 'dexamethasone Oral Solution [Decadron]'),
   ('Baricitinib', 1510627, 'baricitinib'),
   ('Baricitinib', 37497352, 'baricitinib 1 MG'),
   ('Baricitinib', 37497354, 'baricitinib 1 MG [Olumiant]'),
   ('Baricitinib', 37497353, 'baricitinib 1 MG Oral Tablet'),
   ('Baricitinib', 37497355, 'baricitinib 1 MG Oral Tablet [Olumiant]'),
   ('Baricitinib', 1510628, 'baricitinib 2 MG'),
   ('Baricitinib', 1510634, 'baricitinib 2 MG [Olumiant]'),
   ('Baricitinib', 1510632, 'baricitinib 2 MG Oral Tablet'),
   ('Baricitinib', 1510638, 'baricitinib 2 MG Oral Tablet [Olumiant]'),
   ('Baricitinib', 1758612, 'baricitinib 4 MG'),
   ('Baricitinib', 779706, 'baricitinib 4 MG [Olumiant]'),
   ('Baricitinib', 1758613, 'baricitinib 4 MG Oral Tablet'),
   ('Baricitinib', 779707, 'baricitinib 4 MG Oral Tablet [Olumiant]'),
   ('Baricitinib', 1510631, 'baricitinib Oral Tablet'),
   ('Baricitinib', 1510635, 'baricitinib Oral Tablet [Olumiant]'),
   ('Tocilizumab', 1356447, '0.9 ML tocilizumab 180 MG/ML Auto-Injector'),
   ('Tocilizumab', 1356448, '0.9 ML tocilizumab 180 MG/ML Auto-Injector [Actemra]'),
   ('Tocilizumab', 44507566, '0.9 ML tocilizumab 180 MG/ML Prefilled Syringe'),
   ('Tocilizumab', 44507562, '0.9 ML tocilizumab 180 MG/ML Prefilled Syringe [Actemra]'),
   ('Tocilizumab', 46275121, '10 ML tocilizumab 20 MG/ML Injection'),
   ('Tocilizumab', 46275122, '10 ML tocilizumab 20 MG/ML Injection [Actemra]'),
   ('Tocilizumab', 46275123, '20 ML tocilizumab 20 MG/ML Injection'),
   ('Tocilizumab', 46275124, '20 ML tocilizumab 20 MG/ML Injection [Actemra]'),
   ('Tocilizumab', 46275116, '4 ML tocilizumab 20 MG/ML Injection'),
   ('Tocilizumab', 46275118, '4 ML tocilizumab 20 MG/ML Injection [Actemra]'),
   ('Tocilizumab', 40171288, 'tocilizumab'),
   ('Tocilizumab', 44507701, 'tocilizumab 180 MG/ML'),
   ('Tocilizumab', 44507704, 'tocilizumab 180 MG/ML [Actemra]'),
   ('Tocilizumab', 1355866, 'tocilizumab 180 MG/ML Auto-Injector'),
   ('Tocilizumab', 1355867, 'tocilizumab 180 MG/ML Auto-Injector [Actemra]'),
   ('Tocilizumab', 44507702, 'tocilizumab 180 MG/ML Prefilled Syringe'),
   ('Tocilizumab', 44507703, 'tocilizumab 180 MG/ML Prefilled Syringe [Actemra]'),
   ('Tocilizumab', 40171289, 'tocilizumab 20 MG/ML'),
   ('Tocilizumab', 40171292, 'tocilizumab 20 MG/ML [Actemra]'),
   ('Tocilizumab', 46275119, 'tocilizumab 20 MG/ML Injection'),
   ('Tocilizumab', 46275120, 'tocilizumab 20 MG/ML Injection [Actemra]'),
   ('Tocilizumab', 1355864, 'tocilizumab Auto-Injector'),
   ('Tocilizumab', 1355865, 'tocilizumab Auto-Injector [Actemra]'),
   ('Tocilizumab', 46275115, 'tocilizumab Injection'),
   ('Tocilizumab', 46275117, 'tocilizumab Injection [Actemra]'),
   ('Tocilizumab', 44507705, 'tocilizumab Prefilled Syringe'),
   ('Tocilizumab', 44507706, 'tocilizumab Prefilled Syringe [Actemra]'),
   ('Colchicine', 1101554, 'colchicine'),
   ('Colchicine', 1101586, 'colchicine 0.6 MG'),
   ('Colchicine', 40164493, 'colchicine 0.6 MG [Colcrys]'),
   ('Colchicine', 1101556, 'colchicine 0.6 MG Oral Tablet'),
   ('Colchicine', 40164492, 'colchicine 0.6 MG Oral Tablet [Colcrys]'),
   ('Colchicine', 40031428, 'colchicine Oral Tablet'),
   ('Colchicine', 40164494, 'colchicine Oral Tablet [Colcrys]'),
   ('Colchicine', 1101560, 'allopurinol 100 MG / colchicine 0.5 MG Oral Tablet'),
   ('Colchicine', 19061795, 'allopurinol 300 MG / colchicine 0.5 MG Extended Release Oral Capsule'),
   ('Colchicine', 40005863, 'allopurinol / colchicine Extended Release Oral Capsule'),
   ('Colchicine', 40005864, 'allopurinol / colchicine Oral Tablet'),
   ('Colchicine', 1101588, 'colchicine 0.001 MG/MG'),
   ('Colchicine', 19060123, 'colchicine 0.001 MG/MG / podophyllin 0.02 MG/MG Topical Ointment'),
   ('Colchicine', 1366576, 'colchicine 0.12 MG/ML'),
   ('Colchicine', 1361345, 'colchicine 0.12 MG/ML [Gloperba]'),
   ('Colchicine', 1366579, 'colchicine 0.12 MG/ML Oral Solution'),
   ('Colchicine', 1361349, 'colchicine 0.12 MG/ML Oral Solution [Gloperba]'),
   ('Colchicine', 19099374, 'colchicine 0.25 MG'),
   ('Colchicine', 19002015, 'colchicine 0.25 MG Oral Tablet'),
   ('Colchicine', 19109346, 'colchicine 0.432 MG'),
   ('Colchicine', 19108528, 'colchicine 0.432 MG Oral Tablet'),
   ('Colchicine', 1101585, 'colchicine 0.54 MG'),
   ('Colchicine', 19075823, 'colchicine 0.54 MG Oral Tablet'),
   ('Colchicine', 1101583, 'colchicine 0.5 MG'),
   ('Colchicine', 1101584, 'colchicine 0.5 MG/ML'),
   ('Colchicine', 1101557, 'colchicine 0.5 MG/ML Injectable Solution'),
   ('Colchicine', 19018901, 'colchicine 0.5 MG Oral Tablet'),
   ('Colchicine', 1151424, 'colchicine 0.5 MG / probenecid 500 MG Oral Tablet'),
   ('Colchicine', 1101587, 'colchicine 0.65 MG'),
   ('Colchicine', 19075824, 'colchicine 0.65 MG Oral Tablet'),
   ('Colchicine', 45776979, 'colchicine 0.6 MG [Mitigare]'),
   ('Colchicine', 45776977, 'colchicine 0.6 MG Oral Capsule'),
   ('Colchicine', 45776981, 'colchicine 0.6 MG Oral Capsule [Mitigare]'),
   ('Colchicine', 1101589, 'colchicine 1 MG'),
   ('Colchicine', 1101558, 'colchicine 1 MG Oral Tablet'),
   ('Colchicine', 40031427, 'colchicine Injectable Solution'),
   ('Colchicine', 45776976, 'colchicine Oral Capsule'),
   ('Colchicine', 45776980, 'colchicine Oral Capsule [Mitigare]'),
   ('Colchicine', 1366578, 'colchicine Oral Solution'),
   ('Colchicine', 1361346, 'colchicine Oral Solution [Gloperba]'),
   ('Colchicine', 40031406, 'colchicine / podophyllin Topical Ointment'),
   ('Azithromycin', 1734104, 'azithromycin'),
   ('Azithromycin', 40013068, 'azithromycin Oral Tablet'),
   ('Azithromycin', 40013069, 'azithromycin Oral Tablet [Zithromax]'),
   ('Azithromycin', 19128020, '{6 (azithromycin 250 MG Oral Tablet) } Pack'),
   ('Azithromycin', 19128124, '{6 (azithromycin 250 MG Oral Tablet [Zithromax]) } Pack [Z-PAK]'),
   ('Azithromycin', 1734140, 'azithromycin 250 MG'),
   ('Azithromycin', 19073777, 'azithromycin 250 MG Oral Tablet'),
   ('Azithromycin', 1734132, 'azithromycin 250 MG Oral Tablet [Zithromax]'),
   ('Azithromycin', 19116114, 'azithromycin 250 MG [Zithromax]'),
   ('Azithromycin', 19128018, '{3 (azithromycin 500 MG Oral Tablet) } Pack'),
   ('Azithromycin', 19128131, '{3 (azithromycin 500 MG Oral Tablet [Zithromax]) } Pack [TRI-PAK]'),
   ('Azithromycin', 19085757, 'azithromycin 500 MG'),
   ('Azithromycin', 1734134, 'azithromycin 500 MG Oral Tablet'),
   ('Azithromycin', 1734133, 'azithromycin 500 MG Oral Tablet [Zithromax]'),
   ('Azithromycin', 19120522, 'azithromycin 500 MG [Zithromax]'),
   ('Azithromycin', 19133860, '{3 (azithromycin 250 MG Oral Tablet) } Pack'),
   ('Azithromycin', 19133861, '{3 (azithromycin 250 MG Oral Tablet [Zithromax]) } Pack [Z-Pak Sample]'),
   ('Azithromycin', 19128019, '{6 (azithromycin 250 MG Oral Capsule) } Pack'),
   ('Azithromycin', 19108236, 'azithromycin 1000 MG'),
   ('Azithromycin', 19106272, 'azithromycin 1000 MG Oral Tablet'),
   ('Azithromycin', 40164101, 'azithromycin 1000 MG Powder for Oral Suspension'),
   ('Azithromycin', 40164102, 'azithromycin 1000 MG Powder for Oral Suspension [Zithromax]'),
   ('Azithromycin', 40221346, 'azithromycin 1000 MG [Zithromax]'),
   ('Azithromycin', 19126614, 'azithromycin 10 MG/ML'),
   ('Azithromycin', 19126616, 'azithromycin 10 MG/ML [AzaSite]'),
   ('Azithromycin', 19126615, 'azithromycin 10 MG/ML Ophthalmic Solution'),
   ('Azithromycin', 19126617, 'azithromycin 10 MG/ML Ophthalmic Solution [AzaSite]'),
   ('Azithromycin', 19128200, 'azithromycin 10 MG/ML Ophthalmic Suspension'),
   ('Azithromycin', 1734139, 'azithromycin 20 MG/ML'),
   ('Azithromycin', 19073776, 'azithromycin 20 MG/ML Oral Suspension'),
   ('Azithromycin', 19046028, 'azithromycin 20 MG/ML Oral Suspension [Zithromax]'),
   ('Azithromycin', 19038753, 'azithromycin 20 MG/ML [Zithromax]'),
   ('Azithromycin', 19123885, 'azithromycin 250 MG [Azinthromycin]'),
   ('Azithromycin', 1734107, 'azithromycin 250 MG Oral Capsule'),
   ('Azithromycin', 19006685, 'azithromycin 250 MG Oral Capsule [Zithromax]'),
   ('Azithromycin', 19123886, 'azithromycin 250 MG Oral Tablet [Azinthromycin]'),
   ('Azithromycin', 19113148, 'azithromycin 250 MG Oral Tablet [ZPAK]'),
   ('Azithromycin', 19113147, 'azithromycin 250 MG [ZPAK]'),
   ('Azithromycin', 1734167, 'azithromycin 33.3 MG/ML'),
   ('Azithromycin', 1734168, 'azithromycin 33.3 MG/ML Extended Release Suspension'),
   ('Azithromycin', 1734169, 'azithromycin 33.3 MG/ML Extended Release Suspension [Zmax]'),
   ('Azithromycin', 19121228, 'azithromycin 33.3 MG/ML Oral Suspension'),
   ('Azithromycin', 19122010, 'azithromycin 33.3 MG/ML [Zmax]'),
   ('Azithromycin', 19080954, 'azithromycin 40 MG/ML'),
   ('Azithromycin', 1734108, 'azithromycin 40 MG/ML Oral Suspension'),
   ('Azithromycin', 19006686, 'azithromycin 40 MG/ML Oral Suspension [Zithromax]'),
   ('Azithromycin', 19116115, 'azithromycin 40 MG/ML [Zithromax]'),
   ('Azithromycin', 35603389, 'azithromycin 500 MG Injection'),
   ('Azithromycin', 35603391, 'azithromycin 500 MG Injection [Zithromax]'),
   ('Azithromycin', 19108237, 'azithromycin 50 MG'),
   ('Bebtelovimab', 1759259, '2 ML bebtelovimab 87.5 MG/ML Injection'),
   ('Bebtelovimab', 1759073, 'bebtelovimab'),
   ('Bebtelovimab', 1759074, 'bebtelovimab 87.5 MG/ML'),
   ('Bebtelovimab', 1759077, 'bebtelovimab 87.5 MG/ML Injection'),
   ('Bebtelovimab', 1759076, 'bebtelovimab Injection'),
   ('Tixagevimab and cilgavimab', 702575, '{1 (1.5 ML cilgavimab 100 MG/ML Injection) / 1 (1.5 ML tixagevimab 100 MG/ML Injection) } Pack'),
   ('Tixagevimab and cilgavimab', 702576, '{1 (1.5 ML cilgavimab 100 MG/ML Injection) / 1 (1.5 ML tixagevimab 100 MG/ML Injection) } Pack [Evusheld 2 vial carton]'),
   ('Tixagevimab and cilgavimab', 702580, '1.5 ML tixagevimab 100 MG/ML Injection'),
   ('Tixagevimab and cilgavimab', 702418, 'tixagevimab'),
   ('Tixagevimab and cilgavimab', 702419, 'tixagevimab 100 MG/ML'),
   ('Tixagevimab and cilgavimab', 702422, 'tixagevimab 100 MG/ML Injection'),
   ('Tixagevimab and cilgavimab', 702421, 'tixagevimab Injection'),
   ('Tixagevimab and cilgavimab', 702649, '1.5 ML cilgavimab 100 MG/ML Injection'),
   ('Tixagevimab and cilgavimab', 702423, 'cilgavimab'),
   ('Tixagevimab and cilgavimab', 702424, 'cilgavimab 100 MG/ML'),
   ('Tixagevimab and cilgavimab', 702427, 'cilgavimab 100 MG/ML Injection'),
   ('Tixagevimab and cilgavimab', 702425, 'cilgavimab Injectable Product'),
   ('Tixagevimab and cilgavimab', 702426, 'cilgavimab Injection'),
   ('Sotrovimab', 1537593, '8 ML sotrovimab 62.5 MG/ML Injection'),
   ('Sotrovimab', 1536976, 'sotrovimab'),
   ('Sotrovimab', 1536986, 'sotrovimab 62.5 MG/ML'),
   ('Sotrovimab', 1536989, 'sotrovimab 62.5 MG/ML Injection'),
   ('Sotrovimab', 1536988, 'sotrovimab Injection'),
   ('Anakinra', 1114379, '0.67 ML anakinra 149 MG/ML Prefilled Syringe'),
   ('Anakinra', 1114380, '0.67 ML anakinra 149 MG/ML Prefilled Syringe [Kineret]'),
   ('Anakinra', 1114375, 'anakinra'),
   ('Anakinra', 19127200, 'anakinra 149 MG/ML'),
   ('Anakinra', 19033445, 'anakinra 149 MG/ML [Kineret]'),
   ('Anakinra', 42902611, 'anakinra 149 MG/ML Prefilled Syringe'),
   ('Anakinra', 42902489, 'anakinra 149 MG/ML Prefilled Syringe [Kineret]'),
   ('Anakinra', 40141482, 'anakinra Prefilled Syringe'),
   ('Anakinra', 40141483, 'anakinra Prefilled Syringe [Kineret]')
;


--Create table of all drugs given in the cohort
DROP TABLE IF EXISTS #drug_concepts_of_interest;
select distinct
    concept_id,
    concept_name
into 
    #drug_concepts_of_interest
FROM
     [Results].[deident_CURE_ID_drug_exposure]
    left join 
        CONCEPT 
    on
        concept_id = drug_concept_id
;
 

---Roll up drugs into ingredients
drop table if exists #ingredients_of_interest
select 
    dci.concept_id as drug_concept_id,
    dci.concept_name as drug_concept_name,
    CONCEPT.concept_id as ingredient_concept_id,
    CONCEPT.concept_name as ingredient_name
into 
    #ingredients_of_interest
from 
    #drug_concepts_of_interest dci
left join
    CONCEPT_ANCESTOR on
        descendant_concept_id = dci.concept_id
left join 
    CONCEPT on CONCEPT.concept_id = ancestor_concept_id 
where 
    concept_class_id = 'Ingredient'
;
 

--Create table of drug exposures by ingredient
drop table if exists #drug_exposure_by_ingredient
select
    ingredient_name
    ,ingredient_concept_id
    ,d.drug_concept_id
    ,person_id
into 
    #drug_exposure_by_ingredient
from
    [Results].[deident_CURE_ID_drug_exposure] d
left join 
    #ingredients_of_interest i
    on
        i.drug_concept_id = d.drug_concept_id
;
 

--Ingredient use by person
drop table if exists #ingredient_use_by_person
select
    ingredient_name
    ,ingredient_concept_id
    ,count(person_id) as person_count    
    ,(100 * count(person_id) / 
        (select count(distinct person_id) from #drug_exposure_by_ingredient)
    ) as person_perc
into #ingredient_use_by_person
from
        (select distinct 
            person_id
            ,ingredient_concept_id
            ,ingredient_name
        from 
            #drug_exposure_by_ingredient) as x1
group by 
    ingredient_concept_id
    ,ingredient_name
order by
    person_count desc
;
 

drop table if exists #ingredient_count_by_person
select
    ingredient_name
    ,ingredient_concept_id
    ,avg(ingredient_admin_count_per_person) as average_admin_per_person
    ,max(ingredient_admin_count_per_person) as max_admin_per_person
into #ingredient_count_by_person
from
    (select 
        ingredient_name
        ,ingredient_concept_id
        ,person_id
        ,count(ingredient_concept_id) as ingredient_admin_count_per_person
    from #drug_exposure_by_ingredient
    group by person_id, ingredient_concept_id, ingredient_name
    ) as x1
group by 
    ingredient_concept_id
    ,ingredient_name
;
 

--Display summary table for each drug ingredient:
----the number of persons who took the drug ingredient
----percent of persons who took the drug ingredient
----average administrations of the drug ingredient per person who took the drug
----maximum administrations of the drug ingredient per person
select 
    #ingredient_use_by_person.ingredient_name
    ,#ingredient_use_by_person.ingredient_concept_id
    ,#ingredient_use_by_person.person_count
    ,#ingredient_use_by_person.person_perc
    ,#ingredient_count_by_person.average_admin_per_person
    ,#ingredient_count_by_person.max_admin_per_person
from
    #ingredient_use_by_person
left join
    #ingredient_count_by_person
on
    #ingredient_use_by_person.ingredient_concept_id = #ingredient_count_by_person.ingredient_concept_id
order by person_count desc
;

--Match at the drug_concept_id for the cure_id drugs of interest
drop table if exists #person_drug_category;
select person_id, concept_id, drug_category, count(distinct drug_exposure_id) as n_drug_exposures
into #person_drug_category
from [Results].[deident_CURE_ID_drug_exposure] de
    join [Results].[cure_id_drugs_of_interest] di on de.drug_concept_id = di.concept_id
    group by person_id, concept_id, drug_category
    order by person_id, drug_category
;


--This matches at the drug_concept_id which will miss drug_exposures coded at the ingredient level
select * from (select drug_category, count(distinct person_id) as n
               from #person_drug_category
               group by drug_category
               union
               select distinct drug_category, 0
               from [Results].[cure_id_drugs_of_interest]
               where drug_category not in (select distinct drug_category from #person_drug_category)) t
order by n desc
;

-- Testing the code
-- with ingredient_drug_exposure as (
--         select drug_exposure_id, person_id, c1.concept_id as ingredient_concept_id,
--             c1.concept_name as ingredient_concept_name
--         from [Results].[deident_CURE_ID_drug_exposure] cde
--             join concept_ancestor ca on cde.drug_concept_id = ca.descendant_concept_id
--             join concept c1 on c1.concept_id = ca.ancestor_concept_id and c1.concept_class_id = 'Ingredient'
--     )
-- select drug_exposure_id, person_id,
--            string_agg(ingredient_concept_name, '|') within group ( order by ingredient_concept_name ) as ingredient_list
--            from ingredient_drug_exposure group by drug_exposure_id, person_id
-- ;


--build an ingredient list for drugs in different categories
drop table if exists #drug_categories_expanded_to_ingredients;
with expanded_to_ingredients as (
select distinct drug_category,
                c2.concept_id as ingredient_concept_id,
                c2.concept_name as ingredient_concept_name
from [Results].[cure_id_drugs_of_interest] cid
    join concept c1 on cid.concept_id = c1.concept_id
    join concept_ancestor ca on ca.descendant_concept_id = cid.concept_id
    join concept c2 on c2.concept_id = ca.ancestor_concept_id and c2.concept_class_id = 'Ingredient')
select dei.*, n_ingredients
    into #drug_categories_expanded_to_ingredients
from expanded_to_ingredients dei join
    (select drug_category, count(distinct ingredient_concept_id) as n_ingredients
     from expanded_to_ingredients group by drug_category) ni
        on ni.drug_category = dei.drug_category
order by dei.drug_category, ingredient_concept_name
;

-- Groups at the drug_exposure_id level to find drugs with combination ingredients, e.g., Paxlovid (nirmatrelvir and ritonavir)
drop table if exists #drug_exposure_id_ingredient_list;
with drug_categories as (select drug_category,
                                string_agg(ingredient_concept_name, '|') within group (order by ingredient_concept_name)
                                    as ingredient_list
                         from #drug_categories_expanded_to_ingredients
                         group by drug_category),
    ingredient_drug_exposure as (
        select drug_exposure_id, person_id, c1.concept_id as ingredient_concept_id,
            c1.concept_name as ingredient_concept_name
        from [Results].[deident_CURE_ID_drug_exposure] cde
            join concept_ancestor ca on cde.drug_concept_id = ca.descendant_concept_id
            join concept c1 on c1.concept_id = ca.ancestor_concept_id and c1.concept_class_id = 'Ingredient'
    )
    select t.*, dc.drug_category
    into #drug_exposure_id_ingredient_list
    from (
    select drug_exposure_id, person_id,
           string_agg(ingredient_concept_name, '|') within group ( order by ingredient_concept_name ) as ingredient_list
           from ingredient_drug_exposure group by drug_exposure_id, person_id) t
    join drug_categories dc on dc.ingredient_list = t.ingredient_list
;

--Results for evaluating Cure ID drugs of interest
with drug_category_count as (select count(distinct person_id) as n_with_drug, drug_category
                             from (select distinct person_id, drug_category
                                   from #drug_exposure_id_ingredient_list
                                   group by person_id, drug_category
                                   union
                                   select distinct person_id, drug_category from #person_drug_category
                                   ) t
                             group by drug_category)
select z.*, (cast(n_with_drug as float) / n_with_any_drug_exposure) * 100 as percent_with_drug_category from
            (select *
               from drug_category_count
               union
               select distinct 0, drug_category
               from [Results].[cure_id_drugs_of_interest]
               where drug_category
                         not in (select distinct drug_category from drug_category_count)) z
cross join (select count(distinct person_id) as n_with_any_drug_exposure from [Results].[deident_CURE_ID_drug_exposure]) zz
order by n_with_drug desc
;

