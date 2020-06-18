USE data_extracts;

-- ahui 7/2/2020

DROP PROCEDURE IF EXISTS gh2execute3;

DELIMITER //
CREATE PROCEDURE gh2execute3()
BEGIN

-- Brain_Consortium_Diagnoses
-- 1 = latest
-- 0 = earliest

-- gh2_braindataset

CALL populateCodeDateV2(0, 'BrainTumoursE', 'gh2_braindataset', 0, '126952004', null, null, null,'N');
CALL populateCodeDateV2(0, 'BenignBrainTumoursE', 'gh2_braindataset', 0, '92030004', null, null, null,'N');
CALL populateCodeDateV2(0, 'MalignantBrainTumoursE', 'gh2_braindataset', 0, '428061005', null, null, null,'N');
CALL populateCodeDateV2(0, 'CongenitalBrainDamageE', 'gh2_braindataset', 0, '95610008', null, null, null,'N');
CALL populateCodeDateV2(0, 'ChromosomalAnomaliesE', 'gh2_braindataset', 0, '409709004', null, null, null,'N');
CALL populateCodeDateV2(0, 'EpilepsyE', 'gh2_braindataset', 0, '84757009', null, null, null,'N');
CALL populateCodeDateV2(0, 'MotorNeuroneDiseaseE', 'gh2_braindataset', 0, '37340000', null, null, null,'N');
CALL populateCodeDateV2(0, 'MultipleSclerosisE', 'gh2_braindataset', 0, '24700007', null, null, null,'N');
CALL populateCodeDateV2(0, 'ParkinsonsDiseaseE', 'gh2_braindataset', 0, '49049000', null, null, null,'N');
CALL populateCodeDateV2(0, 'AlcoholismE', 'gh2_braindataset', 0, '7200002', null, null, null,'N');
CALL populateCodeDateV2(0, 'AlcoholRelatedBrainDamageE', 'gh2_braindataset', 0, '133301000119102,191475009', null, null, null,'N');
CALL populateCodeDateV2(0, 'AlcoholRelatedDementiaE', 'gh2_braindataset', 0, '281004', null, null, null,'N');
CALL populateCodeDateV2(0, 'KorsakoffsPsychosisE', 'gh2_braindataset', 0, '69482004', null, null, null,'N');
CALL populateCodeDateV2(0, 'WernickeEnchephalopathyE', 'gh2_braindataset', 0, '21007002', null, null, null,'N');
CALL populateCodeDateV2(0, 'DementiaAllE', 'gh2_braindataset', 0, '52448006,20484008,418143002,52522001', null, null, null,'N');
CALL populateCodeDateV2(1, 'DementiaAllL', 'gh2_braindataset', 0, '52448006,20484008,418143002,52522001', null, null, null,'N');
CALL populateCodeDateV2(0, 'VascularDementiaE', 'gh2_braindataset', 0, '429998004', null, null, null,'N');
CALL populateCodeDateV2(0, 'AlzheimersDiseaseE', 'gh2_braindataset', 0, '26929004', null, null, null,'N');
CALL populateCodeDateV2(0, 'MultiInfarctDementiaE', 'gh2_braindataset', 0, '56267009', null, null, null,'N');
CALL populateCodeDateV2(0, 'SubcorticalDementiaE', 'gh2_braindataset', 0, '762707000', null, null, null,'N');
CALL populateCodeDateV2(0, 'MixedDementiaE', 'gh2_braindataset', 0, '79341000119107', null, null, null,'N');
CALL populateCodeDateV2(0, 'FrontotemporalDementiaE', 'gh2_braindataset', 0, '230270009,702426001', null, null, null,'N');
CALL populateCodeDateV2(0, 'PrimaryProgressiveAphasiaE', 'gh2_braindataset', 0, '230278002', null, null, null,'N');
CALL populateCodeDateV2(0, 'SemanticDementiaE', 'gh2_braindataset', 0, '230288001', null, null, null,'N');
CALL populateCodeDateV2(0, 'ProgressiveAgrammaticNFAphasiaE', 'gh2_braindataset', 0, '716281000', null, null, null,'N');
CALL populateCodeDateV2(0, 'PicksDiseaseE', 'gh2_braindataset', 0, '13092008,702429008', null, null, null,'N');
CALL populateCodeDateV2(0, 'CreutzfeldtJakobDiseaseE', 'gh2_braindataset', 0, '792004,304603007', null, null, null,'N');
CALL populateCodeDateV2(0, 'HuntingtonsDiseaseE', 'gh2_braindataset', 0, '58756001', null, null, null,'N');
CALL populateCodeDateV2(0, 'DementiaInHivE', 'gh2_braindataset', 0, '713844000,421529006', null, null, null,'N');
CALL populateCodeDateV2(0, 'DeleriumE', 'gh2_braindataset', 0, '2776000', null, null, null,'N');
CALL populateCodeDateV2(0, 'AmnesicSyndromeE', 'gh2_braindataset', 0, '3298001', null, null, null,'N');
CALL populateCodeDateV2(0, 'MildCognitiveDisorderE', 'gh2_braindataset', 0, '386805003,1047041000000108', null, null, null,'N');
CALL populateCodeDateV2(0, 'CognitiveDeclineE', 'gh2_braindataset', 0, '386806002,386805003', null, null, null,'N');
CALL populateCodeDateV2(0, 'MemoryDisordersE', 'gh2_braindataset', 0, '55533009,386807006,415276009,432806004,192072002', null, null, null,'N');
CALL populateCodeDateV2(0, 'PsychoticDisordersE', 'gh2_braindataset', 0, '69322001,417601000000102,48500005,191613003,191604000,726772006,755321000000106,755331000000108,765176007', null, null, null,'N');
CALL populateCodeDateV2(0, 'SchizophrenicDisordersE', 'gh2_braindataset', 0, '58214004,278853003,48500005,16805009,68890003,68890003', null, null, null,'N');
CALL populateCodeDateV2(0, 'SchizophreniaE', 'gh2_braindataset', 0, '58214004', null, null, null,'N');
CALL populateCodeDateV2(0, 'AcuteSchizophreniaPsychoticDisorderE', 'gh2_braindataset', 0, '278853003', null, null, null,'N');
CALL populateCodeDateV2(0, 'DelusionalDisorderE', 'gh2_braindataset', 0, '48500005', null, null, null,'N');
CALL populateCodeDateV2(0, 'ClusterAPersonalityDisorderE', 'gh2_braindataset', 0, '16805009', null, null, null,'N');
CALL populateCodeDateV2(0, 'ParanoidPersonalityDisorderE', 'gh2_braindataset', 0, '13601005', null, null, null,'N');
CALL populateCodeDateV2(0, 'SchizotypalPersonalityDisorderE', 'gh2_braindataset', 0, '31027006', null, null, null,'N');
CALL populateCodeDateV2(0, 'SchizoaffectiveDisorderE', 'gh2_braindataset', 0, '68890003', null, null, null,'N');
CALL populateCodeDateV2(0, 'SchizoidPersonalityDisorderE', 'gh2_braindataset', 0, '52954000', null, null, null,'N');

-- gh2_brain2dataset

CALL populateCodeDateV2(0, 'NeurolepticMalignantSyndromeE', 'gh2_brain2dataset', 0, '15244003', null, null, null,'N');
CALL populateCodeDateV2(0, 'ManiaManicEpisodeE', 'gh2_brain2dataset', 0, '231494001', null, null, null,'N');
CALL populateCodeDateV2(0, 'BipolarAffectiveDisorderE', 'gh2_brain2dataset', 0, '13746004', null, null, null,'N');

CALL populateCodeDateV2(0, 'DepressionAsPerIcdE', 'gh2_brain2dataset', 0, '35489007', null, '191627008,442057004,231542000,231504006,231485007,84760002', null,'N');

CALL populateCodeDateV2(0, 'DepressiveDisorderE', 'gh2_brain2dataset', 0, '35489007', null, null, null,'N');
CALL populateCodeDateV2(0, 'DepressiveEpisodeE', 'gh2_brain2dataset', 0, '36923009', null, null, null,'N');
CALL populateCodeDateV2(0, 'RecurrentDepressionE', 'gh2_brain2dataset', 0, '191616006', null, null, null,'N');
CALL populateCodeDateV2(0, 'DysthmiaE', 'gh2_brain2dataset', 0, '78667006', null, null, null,'N');
CALL populateCodeDateV2(0, 'CyclothymiaE', 'gh2_brain2dataset', 0, '76105009', null, null, null,'N');
CALL populateCodeDateV2(0, 'SeasonalAffectiveDisorderE', 'gh2_brain2dataset', 0, '247803002', null, null, null,'N');
CALL populateCodeDateV2(0, 'NeuroticDisordersE', 'gh2_brain2dataset', 0, '111475002', null, null, null,'N');
CALL populateCodeDateV2(0, 'PostpartumNatalDepressionE', 'gh2_brain2dataset', 0, '58703003,1038261000000100,311611000000104', null, null, null,'N');
CALL populateCodeDateV2(0, 'PeurperalPsychosisE', 'gh2_brain2dataset', 0, '18260003', null, null, null,'N');
CALL populateCodeDateV2(0, 'AnxietyE', 'gh2_brain2dataset', 0, '48694002', null, '225624000,371631005,386808001', '79823003','N');
CALL populateCodeDateV2(0, 'AcuteStressDisorderE', 'gh2_brain2dataset', 0, '67195008', null, null, null,'N');
CALL populateCodeDateV2(0, 'GeneralisedAnxietyDisorderE', 'gh2_brain2dataset', 0, '21897009', null, null, null,'N');
CALL populateCodeDateV2(0, 'MixedAnxietyDepressionE', 'gh2_brain2dataset', 0, '231504006', null, null, null,'N');
CALL populateCodeDateV2(0, 'PtsdE', 'gh2_brain2dataset', 0, '47505003', null, null, null,'N');
CALL populateCodeDateV2(0, 'OcdE', 'gh2_brain2dataset', 0, '191736004', null, null, null,'N');
CALL populateCodeDateV2(0, 'PanicDisorderPanicAttackE', 'gh2_brain2dataset', 0, '79823003,371631005', null, null, null,'N');
CALL populateCodeDateV2(0, 'SocialAnxietyDisorderChildhoodE', 'gh2_brain2dataset', 0, '64165008', null, null, null,'N');
CALL populateCodeDateV2(0, 'AnxietyDisorderChildhoodE', 'gh2_brain2dataset', 0, '192108001', null, null, null,'N');
CALL populateCodeDateV2(0, 'PhobiasE', 'gh2_brain2dataset', 0, '386808001', null, null, null,'N');
CALL populateCodeDateV2(0, 'PhobicDisordersE', 'gh2_brain2dataset', 0, '386810004', null, null, null,'N');
CALL populateCodeDateV2(0, 'SpecificPhobiasE', 'gh2_brain2dataset', 0, '386808001', null, null, null,'N');
CALL populateCodeDateV2(0, 'SocialPhobiasE', 'gh2_brain2dataset', 0, '25501002', null, null, null,'N');
CALL populateCodeDateV2(0, 'AgoraphobiaE', 'gh2_brain2dataset', 0, '70691001', null, null, null,'N');
CALL populateCodeDateV2(0, 'DissociativeDisorderConversionDisorderE', 'gh2_brain2dataset', 0, '44376007,36480000', null, null, null,'N');
CALL populateCodeDateV2(0, 'AdjustmentDisorderIncludesAcuteStressReactionE', 'gh2_brain2dataset', 0, '17226007', null, null, null,'N');
CALL populateCodeDateV2(0, 'SomatoformDisorderE', 'gh2_brain2dataset', 0, '31297008', null, null, null,'N');
CALL populateCodeDateV2(0, 'SomatizationDisorderE', 'gh2_brain2dataset', 0, '397923000', null, null, null,'N');
CALL populateCodeDateV2(0, 'HypochonriacalDisorderE', 'gh2_brain2dataset', 0, '18193002', null, null, null,'N');
CALL populateCodeDateV2(0, 'PsychogenicFatigueE', 'gh2_brain2dataset', 0, '442099003', null, null, null,'N');
CALL populateCodeDateV2(0, 'MultiplePersonalityDisorderE', 'gh2_brain2dataset', 0, '31611000', null, null, null,'N');
CALL populateCodeDateV2(0, 'GansersDisorderE', 'gh2_brain2dataset', 0, '76129002', null, null, null,'N');
CALL populateCodeDateV2(0, 'EatingDisordersE', 'gh2_brain2dataset', 0, '72366004,897261000000108,407666007', null, null, null,'N');
CALL populateCodeDateV2(0, 'BulimiaE', 'gh2_brain2dataset', 0, '78004001', null, null, null,'N');
CALL populateCodeDateV2(0, 'AnorexiaNervosaE', 'gh2_brain2dataset', 0, '56882008', null, null, null,'N');
CALL populateCodeDateV2(0, 'SubstanceAbuseE', 'gh2_brain2dataset', 0, '66214007,191816009,415658005,161467005,371422002,741063003,228388006,228366006,424626006,191939002,268727002', null, '712542001,707848009', null,'N');
CALL populateCodeDateV2(0, 'AdhdAddE', 'gh2_brain2dataset', 0, '406506008,444613000,464511000000105', null, null, null,'N');
CALL populateCodeDateV2(0, 'PersonalityDisorderE', 'gh2_brain2dataset', 0, '33449004', null, null, null,'N');
CALL populateCodeDateV2(0, 'HabitAndImpulseDisordersE', 'gh2_brain2dataset', 0, '66347000', null, null, null,'N');
CALL populateCodeDateV2(0, 'LearningDisabilitiesE', 'gh2_brain2dataset', 0, '1855002,416075005,106138009,718440004', null, '54407007', null,'N');
CALL populateCodeDateV2(0, 'IntellectualDisabilitiesE', 'gh2_brain2dataset', 0, '110359009', null, null, null,'N');
CALL populateCodeDateV2(0, 'RettsSyndromeE', 'gh2_brain2dataset', 0, '68618008', null, null, null,'N');
CALL populateCodeDateV2(0, 'AutismAspergersE', 'gh2_brain2dataset', 0, '35919005', null, null, null,'N');
CALL populateCodeDateV2(0, 'SpeechLanguageDisorderE', 'gh2_brain2dataset', 0, '231543005,268672004', null, null, null,'N');
CALL populateCodeDateV2(0, 'ConductDisorderE', 'gh2_brain2dataset', 0, '430909002', null, null, null,'N');
CALL populateCodeDateV2(0, 'TicDisorderE', 'gh2_brain2dataset', 0, '568005', null, null, null,'N');
CALL populateCodeDateV2(0, 'TourettesSyndromeE', 'gh2_brain2dataset', 0, '5158005', null, null, null,'N');
CALL populateCodeDateV2(0, 'GenderIdentityDisordersE', 'gh2_brain2dataset', 0, '87991007,1066981000000107,407374003,407375002,12271241000119109,12271241000119109', null, null, null,'N');

END //
DELIMITER ;
