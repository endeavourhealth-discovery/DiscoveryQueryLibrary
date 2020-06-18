USE data_extracts;

-- ahui 6/2/2020

DROP PROCEDURE IF EXISTS createGH2Dataset2;

DELIMITER //
CREATE PROCEDURE createGH2Dataset2()
BEGIN

-- Diagnoses (2)

DROP TABLE IF EXISTS gh2_diagnoses2dataset;

CREATE TABLE gh2_diagnoses2dataset (
    Pseudo_id                                                       VARCHAR(255) NULL,
    Pseudo_NHSNumber                                                VARCHAR(255) NULL,
    AsthmaECode                                                     VARCHAR(50) NULL,
    AsthmaETerm                                                     VARCHAR(200) NULL,
    AsthmaEDate                                                     VARCHAR(50) NULL,
    AsthmaEmergeECode                                               VARCHAR(50) NULL,
    AsthmaEmergeETerm                                               VARCHAR(200) NULL,
    AsthmaEmergeEDate                                               VARCHAR(50) NULL,
    AsthmaResolvedECode                                             VARCHAR(50) NULL,
    AsthmaResolvedETerm                                             VARCHAR(200) NULL,
    AsthmaResolvedEDate                                             VARCHAR(50) NULL, 
    COPDECode                                                       VARCHAR(50) NULL,
    COPDETerm                                                       VARCHAR(200) NULL,
    COPDEDate                                                       VARCHAR(50) NULL,
    PulmonaryFibrosisECode                                          VARCHAR(50) NULL,
    PulmonaryFibrosisETerm                                          VARCHAR(200) NULL,
    PulmonaryFibrosisEDate                                          VARCHAR(50) NULL,
    InterstitialLungDiseaseECode                                    VARCHAR(50) NULL,
    InterstitialLungDiseaseETerm                                    VARCHAR(200) NULL,
    InterstitialLungDiseaseEDate                                    VARCHAR(50) NULL,
    AgeRelatedMuscularDegenerationECode                             VARCHAR(50) NULL,
    AgeRelatedMuscularDegenerationETerm                             VARCHAR(200) NULL,
    AgeRelatedMuscularDegenerationEDate                             VARCHAR(50) NULL,
    GlaucomaECode                                                   VARCHAR(50) NULL,
    GlaucomaETerm                                                   VARCHAR(200) NULL,
    GlaucomaEDate                                                   VARCHAR(50) NULL, 
    RheumatoidArthritisECode                                        VARCHAR(50) NULL,
    RheumatoidArthritisETerm                                        VARCHAR(200) NULL,
    RheumatoidArthritisEDate                                        VARCHAR(50) NULL,
    SystemicLupusECode                                              VARCHAR(50) NULL,
    SystemicLupusETerm                                              VARCHAR(200) NULL,
    SystemicLupusEDate                                              VARCHAR(50) NULL,
    InflammatoryBowelDiseaseECode                                   VARCHAR(50) NULL,
    InflammatoryBowelDiseaseETerm                                   VARCHAR(200) NULL,
    InflammatoryBowelDiseaseEDate                                   VARCHAR(50) NULL,
    CrohnsDiseaseECode                                              VARCHAR(50) NULL,
    CrohnsDiseaseETerm                                              VARCHAR(200) NULL,
    CrohnsDiseaseEDate                                              VARCHAR(50) NULL,
    UlcerativeColitisCodeECode                                      VARCHAR(50) NULL,
    UlcerativeColitisCodeETerm                                      VARCHAR(200) NULL,
    UlcerativeColitisCodeEDate                                      VARCHAR(50) NULL,
    AtopicDermatitisECode                                           VARCHAR(50) NULL,
    AtopicDermatitisETerm                                           VARCHAR(200) NULL,
    AtopicDermatitisEDate                                           VARCHAR(50) NULL,
    InheritedMucociliaryClearanceECode                              VARCHAR(50) NULL,
    InheritedMucociliaryClearanceETerm                              VARCHAR(200) NULL,
    InheritedMucociliaryClearanceEDate                              VARCHAR(50) NULL,
    PrimaryCiliaryDyskinesiaECode                                   VARCHAR(50) NULL,
    PrimaryCiliaryDyskinesiaETerm                                   VARCHAR(200) NULL,
    PrimaryCiliaryDyskinesiaEDate                                   VARCHAR(50) NULL,
    MelanomaECode                                                   VARCHAR(50) NULL,
    MelanomaETerm                                                   VARCHAR(200) NULL,
    MelanomaEDate                                                   VARCHAR(50) NULL,
    ProstateCancerECode                                             VARCHAR(50) NULL,
    ProstateCancerETerm                                             VARCHAR(200) NULL,
    ProstateCancerEDate                                             VARCHAR(50) NULL,
    LungCancerECode                                                 VARCHAR(50) NULL,
    LungCancerETerm                                                 VARCHAR(200) NULL,
    LungCancerEDate                                                 VARCHAR(50) NULL,
    SmallBowelCancerECode                                           VARCHAR(50) NULL,
    SmallBowelCancerETerm                                           VARCHAR(200) NULL,
    SmallBowelCancerEDate                                           VARCHAR(50) NULL,
    ColorectalCancerECode                                           VARCHAR(50) NULL,
    ColorectalCancerETerm                                           VARCHAR(200) NULL,
    ColorectalCancerEDate                                           VARCHAR(50) NULL,
    BreastCancerECode                                               VARCHAR(50) NULL,
    BreastCancerETerm                                               VARCHAR(200) NULL,
    BreastCancerEDate                                               VARCHAR(50) NULL,
    MiscarriageECode                                                VARCHAR(50) NULL,
    MiscarriageETerm                                                VARCHAR(200) NULL,
    MiscarriageEDate                                                VARCHAR(50) NULL
);

ALTER TABLE gh2_diagnoses2dataset ADD INDEX gh2d2_pseudoid_idx (pseudo_id);
INSERT INTO gh2_diagnoses2dataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

END//
DELIMITER ;