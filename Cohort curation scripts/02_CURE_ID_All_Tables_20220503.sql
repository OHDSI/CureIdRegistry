/*
Create CURE_ID tables based off generated CURE_ID cohort
This script depends on CURE_ID_Cohort.sql, and must be run after that script compeltes
*/
USE [JHM_OMOP_20220203] --Change database name as appropriate

--Drop existing tables
DROP TABLE IF EXISTS Results.CURE_ID_Person;
DROP TABLE IF EXISTS Results.CURE_ID_Measurement;
DROP TABLE IF EXISTS Results.CURE_ID_Drug_Exposure;
DROP TABLE IF EXISTS Results.CURE_ID_Death;
DROP TABLE IF EXISTS Results.CURE_ID_Observation;
DROP TABLE IF EXISTS Results.CURE_ID_Procedure_Occurrence;
DROP TABLE IF EXISTS Results.CURE_ID_Condition_Occurrence;
DROP TABLE IF EXISTS Results.CURE_ID_Visit_Occurrence;
DROP TABLE IF EXISTS Results.CURE_ID_Device_Exposure;
	
--Load person table
SELECT pe.*
INTO Results.CURE_ID_Person
FROM person pe
INNER JOIN Results.CURE_ID_Cohort coh
	ON pe.person_id = coh.person_id

--Load measurements table
SELECT m.*
INTO Results.CURE_ID_Measurement
FROM measurement m
INNER JOIN Results.CURE_ID_Cohort coh
	ON m.person_id = coh.person_id
	AND m.measurement_date BETWEEN DATEADD(day, -1, coh.visit_start_date) AND DATEADD(day, 1, coh.visit_end_date)
INNER JOIN concept con
	ON con.concept_id = m.measurement_concept_id
WHERE measurement_concept_id IN (
		703443, 3000285, 3000483, 3000905, 3000963, 3001122, 3001604, 3001657, 3002385, 3002888, 3002937, 
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
		46235106, 46235784, 46236949
		)
ORDER BY coh.person_id,
	m.measurement_datetime

--Load drug_exposure table
SELECT d.*
INTO results.CURE_ID_Drug_exposure
FROM drug_exposure d
INNER JOIN Results.CURE_ID_Cohort coh
	ON d.person_id = coh.person_id
	AND d.drug_exposure_start_date BETWEEN DATEADD(day, -1, coh.visit_start_date) AND DATEADD(day, 1, coh.visit_end_date)
INNER JOIN concept con
	ON con.concept_id = d.drug_concept_id
ORDER BY coh.person_id,
	d.drug_exposure_start_datetime

--Load Death table
SELECT death.*
INTO Results.CURE_ID_Death
FROM death
INNER JOIN Results.CURE_ID_Cohort coh
	ON death.person_id = coh.person_id

--Load Observation data
SELECT DISTINCT o.*
INTO results.CURE_ID_Observation
FROM observation o
INNER JOIN results.CURE_ID_Cohort coh
	ON o.person_id = coh.person_id
	AND o.observation_date BETWEEN DATEADD(YEAR, -1, coh.visit_start_date) AND DATEADD(YEAR, 1, coh.visit_end_date)
WHERE observation_concept_id IN (
		432507, 435148, 435174, 436228, 438331, 440925, 441139, 441200, 441413, 442289, 442329, 442338, 442605, 
		443280, 443281, 443695, 443882, 738834, 762498, 762499, 762986, 762990, 762991, 763382, 763383, 763384, 
		763386, 763387, 763388, 764068, 764069, 764103, 764104, 1314519, 1314522, 1314525, 1314528, 1314532, 
		2314035, 2787823, 2788019, 2788024, 3046853, 3185356, 3196459, 3197551, 3661882, 3661883, 4019847, 
		4023152, 4024541, 4027679, 4028784, 4028785, 4028786, 4030405, 4034158, 4039922, 4039924, 4041511, 
		4042037, 4042360, 4044775, 4044776, 4044777, 4044778, 4048142, 4049737, 4052029, 4052030, 4052866, 
		4052947, 4053707, 4055262, 4058136, 4058138, 4059646, 4059789, 4060687, 4061066, 4061268, 4062254, 
		4063309, 4065742, 4071603, 4073388, 4077917, 4079843, 4079844, 4097521, 4101391, 4102452, 4102691, 
		4118030, 4122053, 4129846, 4132309, 4132745, 4135942, 4141787, 4144273, 4145919, 4162707, 4164280, 
		4165535, 4167237, 4170711, 4170971, 4171902, 4171903, 4173168, 4177807, 4178604, 4178885, 4178886, 
		4179191, 4183699, 4187334, 4190316, 4191032, 4192271, 4193123, 4195245, 4195755, 4198985, 4204653, 
		4206035, 4209006, 4209585, 4210315, 4218686, 4218917, 4220022, 4221284, 4231144, 4233376, 4238527, 
		4239459, 4239540, 4244279, 4244718, 4246415, 4252573, 4252891, 4253661, 4253799, 4253807, 4259007, 
		4276526, 4276823, 4277188, 4277909, 4280210, 4282320, 4289171, 4296873, 4297089, 4298794, 4301926, 
		4302017, 4302158, 4302668, 4305323, 4306204, 4306655, 4307303, 4321590, 4337939, 4344630, 36715062, 
		36717396, 37395454, 37395455, 37395605, 40480476, 40485992, 40488414, 40492790, 40492796, 42538188, 
		44784548, 44784549, 46235215
		)

--Load Procedure Occurrence Table
SELECT p.*
INTO results.CURE_ID_Procedure_Occurrence
FROM procedure_occurrence p
INNER JOIN results.CURE_ID_Cohort coh
	ON p.person_id = coh.person_id
	AND p.procedure_date BETWEEN DATEADD(day, -1, coh.visit_start_date) AND DATEADD(day, 1, coh.visit_end_date)
WHERE procedure_concept_id IN (
		1524103, 1524104, 1524105, 1531630, 1531631, 1531632, 2213572, 2213573, 2745440, 2745444, 2745447, 
		3171077, 3655896, 3655950, 4052536, 4082249, 4119964, 4120120, 4146536, 4155151, 4162736, 4177224, 
		4201025, 4216695, 4230167, 4237460, 4324124, 37018292, 37206601, 37206602, 37206603, 40486624, 
		44790731
		)

--Load Condition Occurrence table
SELECT c.*
INTO results.CURE_ID_Condition_Occurrence
FROM condition_occurrence c
INNER JOIN Results.CURE_ID_Cohort coh
	ON c.person_id = coh.person_id
	AND (
	c.condition_start_date < coh.visit_end_date
	OR c.condition_end_date > coh.visit_start_date
	OR c.condition_end_date is NULL
	)
INNER JOIN concept con
	ON con.concept_id = c.condition_concept_id
WHERE condition_concept_id IN (
		23220, 24970, 24978, 26711, 26719, 132685, 132932, 134414, 134661, 134668, 135601, 136743, 136760, 137940
		, 139841, 141084, 141639, 192684, 192691, 193323, 194700, 195771, 196442, 197018, 197031, 197930, 198801, 
		199064, 200157, 200451, 201254, 201347, 201820, 201826, 201885, 201912, 252348, 252658, 255573, 255841, 
		256439, 256448, 257004, 257012, 257581, 257583, 257905, 258780, 259043, 259848, 260034, 261325, 261889, 
		261895, 312648, 312940, 312950, 313236, 314090, 314103, 314423, 314958, 314971, 315286, 315831, 316447, 
		316866, 317009, 317895, 317898, 318437, 319826, 320128, 320456, 321074, 321080, 321307, 321638, 432347, 
		432554, 433515, 433536, 434752, 436642, 436729, 437326, 438490, 439077, 439393, 439727, 439851, 440748, 
		441321, 441922, 443012, 443412, 443771, 443775, 443779, 443801, 444031, 506725, 507647, 759819, 760850, 
		760968, 761026, 761417, 761418, 761439, 761440, 761441, 761445, 761446, 761447, 761448, 761449, 761450, 
		761451, 761458, 761459, 761460, 761761, 761762, 761826, 761827, 761828, 761837, 761838, 761839, 761844, 
		762000, 762001, 762006, 762007, 762011, 762012, 762014, 762016, 762019, 762023, 762024, 762025, 762027, 
		762028, 762029, 762033, 762034, 762046, 762050, 762051, 762420, 762421, 762422, 762769, 762964, 762994, 
		763926, 764011, 764141, 764677, 764874, 764876, 764949, 765152, 765153, 765154, 765228, 765276, 765302, 
		765431, 765478, 765535, 765536, 765538, 765539, 765542, 765543, 765544, 765545, 765568, 765701, 765888, 
		1571918, 3059325, 3061906, 3062819, 3064929, 3073848, 3076799, 3080608, 3085904, 3085905, 3085906, 
		3086998, 3104717, 3104812, 3117249, 3117745, 3119895, 3119898, 3119899, 3119900, 3119901, 3119902, 
		3119905, 3119907, 3119908, 3120300, 3123108, 3124076, 3128469, 3129469, 3137519, 3137932, 3138676, 
		3138677, 3141512, 3144792, 3147223, 3150357, 3150359, 3150362, 3150537, 3153172, 3157521, 3159004, 
		3159012, 3159021, 3159025, 3159030, 3159061, 3159065, 3159073, 3159074, 3159076, 3159078, 3159089, 
		3159090, 3160078, 3160080, 3160830, 3161148, 3161378, 3161667, 3163408, 3163543, 3164111, 3164791, 
		3168925, 3169253, 3170656, 3171326, 3172355, 3172692, 3172731, 3173485, 3174315, 3174548, 3174804, 
		3175371, 3177314, 3177459, 3178184, 3178281, 3180298, 3180937, 3183244, 3183290, 3183498, 3184093, 
		3184237, 3185549, 3185960, 3186698, 3187037, 3187225, 3188190, 3189821, 3191208, 3191244, 3192256, 
		3192767, 3193274, 3194082, 3194119, 3194332, 3198118, 3214945, 3218191, 3218270, 3219751, 3223145, 
		3223992, 3225242, 3225388, 3231252, 3234561, 3239249, 3241356, 3242794, 3243114, 3245376, 3247348, 
		3250128, 3251351, 3251430, 3251914, 3251993, 3255245, 3257391, 3258439, 3264778, 3264851, 3265936, 
		3271403, 3271777, 3272016, 3274949, 3277888, 3283761, 3287246, 3288125, 3288613, 3288848, 3290051, 
		3291339, 3292505, 3294137, 3297618, 3298054, 3299920, 3305806, 3306205, 3307118, 3307132, 3312451, 
		3313627, 3313673, 3313745, 3314387, 3316961, 3318088, 3318510, 3323490, 3326029, 3327122, 3329162, 
		3331548, 3332687, 3332957, 3333046, 3335460, 3337143, 3340490, 3344652, 3345638, 3346584, 3346972, 
		3347672, 3348072, 3359198, 3359542, 3361151, 3365725, 3367281, 3368282, 3368677, 3371035, 3375156, 
		3376452, 3376778, 3377317, 3377833, 3378250, 3380238, 3380555, 3382655, 3384280, 3385376, 3385567, 
		3386670, 3387279, 3387442, 3390683, 3395210, 3397931, 3401337, 3401421, 3401956, 3406340, 3416922, 
		3419271, 3421968, 3424477, 3424852, 3425355, 3425363, 3434966, 3451574, 3456736, 3519572, 3520467, 
		3529048, 3654571, 3654682, 3654836, 3654837, 3654900, 3654950, 3655112, 3655113, 3655114, 3655115, 
		3656065, 3656115, 3661412, 4001578, 4006165, 4006325, 4006976, 4006979, 4008081, 4008576, 4009047, 
		4011629, 4012089, 4012559, 4012560, 4014159, 4022592, 4023318, 4024659, 4028244, 4028741, 4028951, 
		4030061, 4030066, 4031011, 4031512, 4032952, 4034031, 4034094, 4034095, 4034960, 4034962, 4034963, 
		4035655, 4040469, 4045981, 4046986, 4047624, 4047906, 4048033, 4048081, 4048184, 4048185, 4048188, 
		4048202, 4048212, 4048489, 4048501, 4049242, 4049243, 4049245, 4049259, 4049389, 4050732, 4050733, 
		4050734, 4050876, 4050877, 4050961, 4051466, 4051475, 4051486, 4051487, 4051488, 4051493, 4052552, 
		4052553, 4053008, 4056405, 4057952, 4057976, 4057978, 4057979, 4058243, 4058987, 4059463, 4059977, 
		4059981, 4059982, 4059983, 4059985, 4060126, 4060127, 4060231, 4060235, 4060237, 4061411, 4061415, 
		4061418, 4061420, 4061667, 4061672, 4061676, 4061683, 4061686, 4061784, 4061785, 4062117, 4062550, 
		4062685, 4062686, 4062687, 4062811, 4062906, 4063042, 4063043, 4063381, 4069849, 4070155, 4071202, 
		4075237, 4078695, 4079850, 4080325, 4080516, 4080601, 4080753, 4083351, 4083395, 4083723, 4084643, 
		4084689, 4084973, 4087603, 4087604, 4088332, 4089881, 4089882, 4092686, 4092687, 4092689, 4092690, 
		4093296, 4093297, 4093298, 4094374, 4096042, 4096670, 4096671, 4096917, 4097815, 4098133, 4099214, 
		4099215, 4099334, 4099651, 4099653, 4099741, 4102018, 4104506, 4108213, 4110027, 4110048, 4110051, 
		4110056, 4110362, 4110479, 4110489, 4110490, 4110492, 4110498, 4110635, 4110637, 4110947, 4110948, 
		4111455, 4112021, 4112365, 4112367, 4112497, 4112498, 4112499, 4112500, 4112508, 4112509, 4112518, 
		4112529, 4112530, 4112534, 4112737, 4112769, 4112826, 4112828, 4112836, 4115044, 4117862, 4117864, 
		4118910, 4119298, 4119300, 4119431, 4119447, 4119593, 4119595, 4119596, 4119942, 4120115, 4120261, 
		4122085, 4123253, 4124361, 4125022, 4126438, 4128060, 4129378, 4129516, 4129519, 4129524, 4129525, 
		4130162, 4130164, 4131907, 4132099, 4132100, 4132101, 4132562, 4132563, 4132564, 4132565, 4133030, 
		4133032, 4133033, 4133724, 4134586, 4136683, 4136889, 4137219, 4137382, 4137525, 4138760, 4138971, 
		4140134, 4140438, 4140808, 4141360, 4141827, 4141978, 4142738, 4143474, 4143529, 4143828, 4144107, 
		4144583, 4145356, 4145495, 4145496, 4145497, 4145827, 4146581, 4146627, 4146816, 4148124, 4148205, 
		4148257, 4151903, 4152913, 4155468, 4155469, 4155470, 4159755, 4161950, 4161973, 4162306, 4163687, 
		4163701, 4164289, 4164798, 4164920, 4166381, 4166508, 4166517, 4167358, 4167493, 4167920, 4168162, 
		4171124, 4171125, 4172009, 4172303, 4173466, 4174979, 4177862, 4177944, 4178312, 4178452, 4178622, 
		4178790, 4179379, 4179670, 4179673, 4180254, 4180283, 4181182, 4181738, 4185302, 4186898, 4188331, 
		4188598, 4191479, 4192358, 4192852, 4193588, 4193704, 4195892, 4196712, 4196809, 4198434, 4199306, 
		4199450, 4200851, 4201627, 4201941, 4202383, 4202809, 4203452, 4203625, 4206009, 4206340, 4208824, 
		4209097, 4209293, 4209301, 4211001, 4211530, 4211792, 4211990, 4212099, 4212496, 4212631, 4214249, 
		4214878, 4215640, 4217486, 4217558, 4217975, 4218088, 4219323, 4219464, 4221287, 4221767, 4221991, 
		4223573, 4223736, 4224409, 4225187, 4225193, 4225319, 4225553, 4225554, 4226120, 4226260, 4226925, 
		4227150, 4227200, 4227511, 4227531, 4227607, 4227821, 4227834, 4228274, 4228604, 4228776, 4229440, 
		4230254, 4230358, 4230641, 4231452, 4231507, 4232595, 4233784, 4235410, 4235735, 4236271, 4236860, 
		4237068, 4237443, 4239301, 4239722, 4240589, 4240899, 4241326, 4241524, 4241525, 4241526, 4241530, 
		4242036, 4242231, 4242878, 4243667, 4244339, 4244406, 4244660, 4245270, 4245292, 4245676, 4246105, 
		4247588, 4249016, 4250128, 4252384, 4253472, 4253928, 4254103, 4262182, 4262297, 4263067, 4263730, 
		4263902, 4264536, 4264740, 4267414, 4269358, 4271333, 4271703, 4273688, 4274468, 4275496, 4276511, 
		4277110, 4279525, 4280726, 4281815, 4283352, 4284562, 4284682, 4286497, 4288156, 4288592, 4289142, 
		4289844, 4289933, 4291606, 4291933, 4293711, 4294973, 4297463, 4297648, 4299361, 4299535, 4301938, 
		4302591, 4304377, 4304837, 4305599, 4307820, 4309350, 4309357, 4309833, 4311246, 4311437, 4312524, 
		4313767, 4314426, 4315386, 4316066, 4316067, 4316372, 4318560, 4320032, 4321603, 4321845, 4322638, 
		4322735, 4325525, 4326434, 4327471, 4327944, 4328679, 4330696, 4332085, 4333202, 4334649, 4340791, 
		4343930, 4345565, 4345926, 4347061, 4347288, 35205776, 35225089, 35609846, 35609847, 35615125, 
		35615340, 35616025, 35616026, 35622345, 35622370, 35622939, 35623289, 35624116, 35624277, 36674252, 
		36674253, 36674254, 36674977, 36675042, 36679002, 36684328, 36684335, 36684827, 36684864, 36684865, 
		36685758, 36687122, 36712779, 36712891, 36712971, 36713024, 36713275, 36714339, 36714681, 36715042, 
		36715051, 36715087, 36715408, 36715417, 36715476, 36716258, 36716524, 36716727, 36716978, 36717215, 
		36717599, 37016114, 37016726, 37016883, 37017071, 37017082, 37017092, 37017093, 37017094, 37017106, 
		37017108, 37017112, 37017124, 37017125, 37017126, 37017132, 37017209, 37017210, 37017243, 37017244, 
		37017246, 37017247, 37017248, 37017249, 37017254, 37017259, 37017260, 37017261, 37017262, 37017263, 
		37017265, 37017266, 37017276, 37017277, 37017278, 37017279, 37017282, 37017283, 37017284, 37017285, 
		37017294, 37017295, 37017296, 37017318, 37017319, 37017320, 37017424, 37017425, 37017442, 37017446, 
		37017453, 37017454, 37017455, 37017456, 37017457, 37017549, 37017550, 37017579, 37017580, 37017586, 
		37017595, 37017652, 37017655, 37018063, 37018345, 37018711, 37018714, 37018721, 37018755, 37018765, 
		37018878, 37018935, 37019034, 37019042, 37019052, 37019055, 37019058, 37108580, 37108581, 37109103, 
		37110041, 37110251, 37110292, 37110519, 37110890, 37116379, 37116455, 37116830, 37116831, 37116845, 
		37116960, 37118654, 37119072, 37204232, 37204277, 37204495, 37204512, 37204818, 37204863, 37206130, 
		37206717, 37208102, 37208172, 37208293, 37208352, 37209632, 37309625, 37310241, 37311329, 37312010, 
		37312199, 37396524, 37396824, 37397178, 40260457, 40263069, 40276914, 40276916, 40276917, 40287885, 
		40288730, 40319124, 40319628, 40345081, 40376592, 40380240, 40388362, 40390518, 40401213, 40403276, 
		40432812, 40443170, 40479192, 40479576, 40480082, 40480278, 40480602, 40481043, 40481763, 40481872, 
		40481896, 40482883, 40483397, 40483581, 40487286, 40487312, 40491089, 40491473, 40493243, 40517943, 
		40525124, 40532429, 40538664, 40539088, 40539091, 40539101, 40549354, 40599235, 40607606, 40611164, 
		40629865, 40636102, 40638817, 40641740, 42534820, 42535539, 42535716, 42536207, 42536208, 42536541, 
		42536590, 42536591, 42536592, 42536593, 42536594, 42536595, 42536596, 42536649, 42537681, 42538697, 
		42538744, 42538946, 42538959, 42538960, 42539031, 42539089, 42539549, 42709778, 42709779, 42873163, 
		43020424, 43020511, 43021830, 43021835, 43021836, 43021871, 43021940, 43530652, 43530693, 43530745, 
		43531006, 43531007, 43531008, 43531009, 43531010, 43531011, 43531012, 43531013, 43531014, 43531015, 
		43531016, 43531017, 43531018, 43531019, 43531020, 43531586, 43531640, 43531641, 43531642, 43531643, 
		43531644, 43531645, 44782655, 44782715, 44782719, 44782732, 44782733, 44782734, 44782735, 44782736, 
		44782737, 44782738, 44782739, 44782740, 44782741, 44782754, 44782755, 44782756, 44782759, 44782765, 
		44782819, 44782989, 44783643, 44783644, 44784282, 44784483, 44784484, 44784621, 44784637, 44784638, 
		44784639, 44784640, 44787902, 44791725, 44792134, 44793113, 44793114, 44794980, 44795102, 44795858, 
		44795859, 44795877, 44795981, 44796338, 44796986, 44797022, 44798219, 44798263, 44798365, 44801040, 
		44801397, 44807895, 44809026, 44809027, 44809548, 44809569, 44810117, 44811110, 44811932, 44811933, 
		44813431, 44824945, 44828699, 44829737, 45534320, 45539221, 45558346, 45561777, 45563193, 45572902, 
		45597051, 45606666, 45757063, 45757077, 45757079, 45757102, 45757119, 45757124, 45757129, 45757132, 
		45757137, 45757139, 45757356, 45757409, 45757444, 45757445, 45757446, 45757447, 45757474, 45757644, 
		45757674, 45757787, 45757788, 45757789, 45763750, 45765445, 45766050, 45766051, 45766052, 45766727, 
		45766728, 45767051, 45768449, 45768887, 45768910, 45768911, 45768912, 45768963, 45768964, 45768965, 
		45768981, 45768998, 45769350, 45769351, 45769352, 45769389, 45769438, 45769441, 45769442, 45769443, 
		45769839, 45769855, 45769856, 45769864, 45771016, 45771045, 45771051, 45771064, 45771067, 45772073, 
		45772937, 45773005, 45773072, 46269693, 46269701, 46269767, 46269770, 46269771, 46269776, 46269777, 
		46269784, 46269785, 46269801, 46269802, 46270028, 46270029, 46270030, 46270070, 46270074, 46270082, 
		46270157, 46270322, 46270340, 46270376, 46271475, 46271548, 46271900, 46272972, 46273452, 46273454, 
		46273462, 46273487, 46273635, 46274059, 46274062, 46274096, 46274124, 46284256
		)

--Load Visit Occurrence table
SELECT DISTINCT v.*
INTO results.CURE_ID_Visit_Occurrence
FROM visit_occurrence v
INNER JOIN Results.CURE_ID_Cohort coh
	ON v.person_id = coh.person_id
WHERE v.visit_start_date >= '2020-03-01'

--Load Device Exposure table
SELECT dev.*
INTO results.CURE_ID_Device_Exposure
FROM device_exposure dev
INNER JOIN Results.CURE_ID_Cohort coh
	ON dev.person_id = coh.person_id
	AND dev.device_exposure_start_date BETWEEN DATEADD(day, -1, coh.visit_start_date) AND DATEADD(day, 1, coh.visit_end_date)
WHERE device_concept_id IN (
		4137849, 4138487, 4138614, 4138748, 4139525, 4145528, 4145694, 4222966, 4224038, 4322904, 36676809, 
		36714464, 36715212, 36715213, 36715214, 45758195, 45759002, 45759146, 45759930, 45760053, 45760156, 
		45760219, 45760350, 45760386, 45760842, 45761109, 45761494, 45761768, 45763257, 45763336, 45764052, 
		45764072, 45764073, 45764253, 45764556, 45765048, 45765049, 45765050, 45767333, 45767334, 45767335, 
		45767336, 45767337, 45768197, 45768198, 45768199, 45768221, 45768222, 45771119, 45771595, 45772392, 
		45773303,4281167
		)