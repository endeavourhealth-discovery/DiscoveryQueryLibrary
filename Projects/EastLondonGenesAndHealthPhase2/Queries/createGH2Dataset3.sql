USE data_extracts;

-- ahui 6/2/2020

DROP PROCEDURE IF EXISTS createGH2Dataset3;

DELIMITER //
CREATE PROCEDURE createGH2Dataset3()
BEGIN

-- Brain_Consortium_Diagnoses

DROP TABLE IF EXISTS gh2_braindataset;

CREATE TABLE gh2_braindataset (
    Pseudo_id                                                            VARCHAR(255) NULL,  
    Pseudo_NHSNumber                                                     VARCHAR(255) NULL,
    BrainTumoursECode                                                    VARCHAR(50) NULL, 
    BrainTumoursETerm                                                    VARCHAR(200) NULL,
    BrainTumoursEDate                                                    VARCHAR(50) NULL, 
    BenignBrainTumoursECode                                              VARCHAR(50) NULL, 
    BenignBrainTumoursETerm                                              VARCHAR(200) NULL,
    BenignBrainTumoursEDate                                              VARCHAR(50) NULL, 
    MalignantBrainTumoursECode                                           VARCHAR(50) NULL, 
    MalignantBrainTumoursETerm                                           VARCHAR(200) NULL,
    MalignantBrainTumoursEDate                                           VARCHAR(50) NULL, 
    CongenitalBrainDamageECode                                           VARCHAR(50) NULL, 
    CongenitalBrainDamageETerm                                           VARCHAR(200) NULL,
    CongenitalBrainDamageEDate                                           VARCHAR(50) NULL, 
    ChromosomalAnomaliesECode                                            VARCHAR(50) NULL, 
    ChromosomalAnomaliesETerm                                            VARCHAR(200) NULL,
    ChromosomalAnomaliesEDate                                            VARCHAR(50) NULL, 
    EpilepsyECode                                                        VARCHAR(50) NULL, 
    EpilepsyETerm                                                        VARCHAR(200) NULL,
    EpilepsyEDate                                                        VARCHAR(50) NULL, 
    MotorNeuroneDiseaseECode                                             VARCHAR(50) NULL, 
    MotorNeuroneDiseaseETerm                                             VARCHAR(200) NULL,
    MotorNeuroneDiseaseEDate                                             VARCHAR(50) NULL, 
    MultipleSclerosisECode                                               VARCHAR(50) NULL, 
    MultipleSclerosisETerm                                               VARCHAR(200) NULL,
    MultipleSclerosisEDate                                               VARCHAR(50) NULL, 
    ParkinsonsDiseaseECode                                               VARCHAR(50) NULL, 
    ParkinsonsDiseaseETerm                                               VARCHAR(200) NULL,
    ParkinsonsDiseaseEDate                                               VARCHAR(50) NULL, 
    AlcoholismECode                                                      VARCHAR(50) NULL, 
    AlcoholismETerm                                                      VARCHAR(200) NULL,
    AlcoholismEDate                                                      VARCHAR(50) NULL, 
    AlcoholRelatedBrainDamageECode                                       VARCHAR(50) NULL, 
    AlcoholRelatedBrainDamageETerm                                       VARCHAR(200) NULL,
    AlcoholRelatedBrainDamageEDate                                       VARCHAR(50) NULL, 
    AlcoholRelatedDementiaECode                                          VARCHAR(50) NULL, 
    AlcoholRelatedDementiaETerm                                          VARCHAR(200) NULL,
    AlcoholRelatedDementiaEDate                                          VARCHAR(50) NULL, 
    KorsakoffsPsychosisECode                                             VARCHAR(50) NULL, 
    KorsakoffsPsychosisETerm                                             VARCHAR(200) NULL,
    KorsakoffsPsychosisEDate                                             VARCHAR(50) NULL, 
    WernickeEnchephalopathyECode                                         VARCHAR(50) NULL, 
    WernickeEnchephalopathyETerm                                         VARCHAR(200) NULL,
    WernickeEnchephalopathyEDate                                         VARCHAR(50) NULL, 
    DementiaAllECode                                                     VARCHAR(50) NULL, 
    DementiaAllETerm                                                     VARCHAR(200) NULL,
    DementiaAllEDate                                                     VARCHAR(50) NULL, 
    DementiaAllLCode                                                     VARCHAR(50) NULL, 
    DementiaAllLTerm                                                     VARCHAR(200) NULL, 
    DementiaAllLDate                                                     VARCHAR(50) NULL, 
    VascularDementiaECode                                                VARCHAR(50) NULL, 
    VascularDementiaETerm                                                VARCHAR(200) NULL,
    VascularDementiaEDate                                                VARCHAR(50) NULL, 
    AlzheimersDiseaseECode                                               VARCHAR(50) NULL, 
    AlzheimersDiseaseETerm                                               VARCHAR(200) NULL,
    AlzheimersDiseaseEDate                                               VARCHAR(50) NULL, 
    MultiInfarctDementiaECode                                            VARCHAR(50) NULL, 
    MultiInfarctDementiaETerm                                            VARCHAR(200) NULL,
    MultiInfarctDementiaEDate                                            VARCHAR(50) NULL, 
    SubcorticalDementiaECode                                             VARCHAR(50) NULL, 
    SubcorticalDementiaETerm                                             VARCHAR(200) NULL,
    SubcorticalDementiaEDate                                             VARCHAR(50) NULL, 
    MixedDementiaECode                                                   VARCHAR(50) NULL, 
    MixedDementiaETerm                                                   VARCHAR(200) NULL,
    MixedDementiaEDate                                                   VARCHAR(50) NULL,
    FrontotemporalDementiaECode                                          VARCHAR(50) NULL, 
    FrontotemporalDementiaETerm                                          VARCHAR(200) NULL,
    FrontotemporalDementiaEDate                                          VARCHAR(50) NULL, 
    PrimaryProgressiveAphasiaECode                                       VARCHAR(50) NULL, 
    PrimaryProgressiveAphasiaETerm                                       VARCHAR(200) NULL,
    PrimaryProgressiveAphasiaEDate                                       VARCHAR(50) NULL, 
    SemanticDementiaECode                                                VARCHAR(50) NULL, 
    SemanticDementiaETerm                                                VARCHAR(200) NULL,
    SemanticDementiaEDate                                                VARCHAR(50) NULL, 
    ProgressiveAgrammaticNFAphasiaECode                                  VARCHAR(50) NULL, 
    ProgressiveAgrammaticNFAphasiaETerm                                  VARCHAR(200) NULL,
    ProgressiveAgrammaticNFAphasiaEDate                                  VARCHAR(50) NULL, 
    PicksDiseaseECode                                                    VARCHAR(50) NULL, 
    PicksDiseaseETerm                                                    VARCHAR(200) NULL,
    PicksDiseaseEDate                                                    VARCHAR(50) NULL, 
    CreutzfeldtJakobDiseaseECode                                         VARCHAR(50) NULL, 
    CreutzfeldtJakobDiseaseETerm                                         VARCHAR(200) NULL,
    CreutzfeldtJakobDiseaseEDate                                         VARCHAR(50) NULL, 
    HuntingtonsDiseaseECode                                              VARCHAR(50) NULL, 
    HuntingtonsDiseaseETerm                                              VARCHAR(200) NULL,
    HuntingtonsDiseaseEDate                                              VARCHAR(50) NULL, 
    DementiaInHivECode                                                   VARCHAR(50) NULL, 
    DementiaInHivETerm                                                   VARCHAR(200) NULL,
    DementiaInHivEDate                                                   VARCHAR(50) NULL, 
    DeleriumECode                                                        VARCHAR(50) NULL, 
    DeleriumETerm                                                        VARCHAR(200) NULL,
    DeleriumEDate                                                        VARCHAR(50) NULL, 
    AmnesicSyndromeECode                                                 VARCHAR(50) NULL, 
    AmnesicSyndromeETerm                                                 VARCHAR(200) NULL,
    AmnesicSyndromeEDate                                                 VARCHAR(50) NULL, 
    MildCognitiveDisorderECode                                           VARCHAR(50) NULL, 
    MildCognitiveDisorderETerm                                           VARCHAR(200) NULL,
    MildCognitiveDisorderEDate                                           VARCHAR(50) NULL, 
    CognitiveDeclineECode                                                VARCHAR(50) NULL, 
    CognitiveDeclineETerm                                                VARCHAR(200) NULL,
    CognitiveDeclineEDate                                                VARCHAR(50) NULL, 
    MemoryDisordersECode                                                 VARCHAR(50) NULL, 
    MemoryDisordersETerm                                                 VARCHAR(200) NULL,
    MemoryDisordersEDate                                                 VARCHAR(50) NULL, 
    PsychoticDisordersECode                                              VARCHAR(50) NULL, 
    PsychoticDisordersETerm                                              VARCHAR(200) NULL,
    PsychoticDisordersEDate                                              VARCHAR(50) NULL,
    SchizophrenicDisordersECode                                          VARCHAR(50) NULL, 
    SchizophrenicDisordersETerm                                          VARCHAR(200) NULL,
    SchizophrenicDisordersEDate                                          VARCHAR(50) NULL, 
    SchizophreniaECode                                                   VARCHAR(50) NULL, 
    SchizophreniaETerm                                                   VARCHAR(200) NULL,
    SchizophreniaEDate                                                   VARCHAR(50) NULL,
    AcuteSchizophreniaPsychoticDisorderECode                             VARCHAR(50) NULL, 
    AcuteSchizophreniaPsychoticDisorderETerm                             VARCHAR(200) NULL,
    AcuteSchizophreniaPsychoticDisorderEDate                             VARCHAR(50) NULL, 
    DelusionalDisorderECode                                              VARCHAR(50) NULL, 
    DelusionalDisorderETerm                                              VARCHAR(200) NULL,
    DelusionalDisorderEDate                                              VARCHAR(50) NULL,
    ClusterAPersonalityDisorderECode                                     VARCHAR(50) NULL, 
    ClusterAPersonalityDisorderETerm                                     VARCHAR(200) NULL,
    ClusterAPersonalityDisorderEDate                                     VARCHAR(50) NULL,
    ParanoidPersonalityDisorderECode                                     VARCHAR(50) NULL, 
    ParanoidPersonalityDisorderETerm                                     VARCHAR(200) NULL,
    ParanoidPersonalityDisorderEDate                                     VARCHAR(50) NULL,
    SchizotypalPersonalityDisorderECode                                  VARCHAR(50) NULL, 
    SchizotypalPersonalityDisorderETerm                                  VARCHAR(200) NULL,
    SchizotypalPersonalityDisorderEDate                                  VARCHAR(50) NULL, 
    SchizoaffectiveDisorderECode                                         VARCHAR(50) NULL, 
    SchizoaffectiveDisorderETerm                                         VARCHAR(200) NULL,
    SchizoaffectiveDisorderEDate                                         VARCHAR(50) NULL, 
    SchizoidPersonalityDisorderECode                                     VARCHAR(50) NULL, 
    SchizoidPersonalityDisorderETerm                                     VARCHAR(200) NULL,
    SchizoidPersonalityDisorderEDate                                     VARCHAR(50) NULL
);
    
ALTER TABLE gh2_braindataset ADD INDEX gh2d3_pseudoid_idx (pseudo_id);
    
INSERT INTO gh2_braindataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;
    
END//
DELIMITER ;
   