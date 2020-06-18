USE data_extracts;

-- ahui 6/2/2020

DROP PROCEDURE IF EXISTS createGH2Dataset2a;

DELIMITER //
CREATE PROCEDURE createGH2Dataset2a()
BEGIN

-- Diagnoses (2a)

DROP TABLE IF EXISTS gh2_diagnoses2adataset;

CREATE TABLE gh2_diagnoses2adataset (
    Pseudo_id                                                       VARCHAR(255) NULL,
    Pseudo_NHSNumber                                                VARCHAR(255) NULL,
    StillbirthECode                                                 VARCHAR(50) NULL,
    StillbirthETerm                                                 VARCHAR(200) NULL,
    StillbirthEDate                                                 VARCHAR(50) NULL,
    PregnancyInducedHypertensionECode                               VARCHAR(50) NULL,
    PregnancyInducedHypertensionETerm                               VARCHAR(200) NULL,
    PregnancyInducedHypertensionEDate                               VARCHAR(50) NULL,
    PreEclampsiaECode                                               VARCHAR(50) NULL,
    PreEclampsiaETerm                                               VARCHAR(200) NULL,
    PreEclampsiaEDate                                               VARCHAR(50) NULL,
    CholestasisECode                                                VARCHAR(50) NULL,
    CholestasisETerm                                                VARCHAR(200) NULL,
    CholestasisEDate                                                VARCHAR(50) NULL,
    GallstonesECode                                                 VARCHAR(50) NULL,
    GallstonesETerm                                                 VARCHAR(200) NULL,
    GallstonesEDate                                                 VARCHAR(50) NULL,
    GoutECode                                                       VARCHAR(50) NULL,
    GoutETerm                                                       VARCHAR(200) NULL,
    GoutEDate                                                       VARCHAR(50) NULL,
    AnkylosingSpondylitisECode                                      VARCHAR(50) NULL,
    AnkylosingSpondylitisETerm                                      VARCHAR(200) NULL,
    AnkylosingSpondylitisEDate                                      VARCHAR(50) NULL,  
    JaundiceECode                                                   VARCHAR(50) NULL,
    JaundiceETerm                                                   VARCHAR(200) NULL,
    JaundiceEDate                                                   VARCHAR(50) NULL,
    PsoriasisECode                                                  VARCHAR(50) NULL,
    PsoriasisETerm                                                  VARCHAR(200) NULL,
    PsoriasisEDate                                                  VARCHAR(50) NULL,
    DeafnessECode                                                   VARCHAR(50) NULL,
    DeafnessETerm                                                   VARCHAR(200) NULL,
    DeafnessEDate                                                   VARCHAR(50) NULL, 
    HearingAidECode                                                 VARCHAR(50) NULL,
    HearingAidETerm                                                 VARCHAR(200) NULL,
    HearingAidEDate                                                 VARCHAR(50) NULL,    
    TinnitusECode                                                   VARCHAR(50) NULL,
    TinnitusETerm                                                   VARCHAR(200) NULL,
    TinnitusEDate                                                   VARCHAR(50) NULL,    
    AssisstedFertilisationECode                                     VARCHAR(50) NULL,
    AssisstedFertilisationETerm                                     VARCHAR(200) NULL,
    AssisstedFertilisationEDate                                     VARCHAR(50) NULL,
    IVFEECode                                                       VARCHAR(50) NULL,
    IVFEETerm                                                       VARCHAR(200) NULL,
    IVFEEDate                                                       VARCHAR(50) NULL, 
    AppendicitisECode                                               VARCHAR(50) NULL,
    AppendicitisETerm                                               VARCHAR(200) NULL,
    AppendicitisEDate                                               VARCHAR(50) NULL, 
    FemoralHerniaECode                                              VARCHAR(50) NULL,
    FemoralHerniaETerm                                              VARCHAR(200) NULL,
    FemoralHerniaEDate                                              VARCHAR(50) NULL, 
    InguinalHerniaECode                                             VARCHAR(50) NULL,
    InguinalHerniaETerm                                             VARCHAR(200) NULL,
    InguinalHerniaEDate                                             VARCHAR(50) NULL,    
    UmbilicalHerniaECode                                            VARCHAR(50) NULL,
    UmbilicalHerniaETerm                                            VARCHAR(200) NULL,
    UmbilicalHerniaEDate                                            VARCHAR(50) NULL,
    AbdominalHerniaECode                                            VARCHAR(50) NULL,
    AbdominalHerniaETerm                                            VARCHAR(200) NULL,
    AbdominalHerniaEDate                                            VARCHAR(50) NULL, 
    XanthomatosisECode                                              VARCHAR(50) NULL,
    XanthomatosisETerm                                              VARCHAR(200) NULL,
    XanthomatosisEDate                                              VARCHAR(50) NULL, 
    TendinousXanthomaECode                                          VARCHAR(50) NULL,
    TendinousXanthomaETerm                                          VARCHAR(200) NULL,
    TendinousXanthomaEDate                                          VARCHAR(50) NULL,
    CornealArcusECode                                               VARCHAR(50) NULL,
    CornealArcusETerm                                               VARCHAR(200) NULL,
    CornealArcusEDate                                               VARCHAR(50) NULL,
    GastricUlcerECode                                               VARCHAR(50) NULL,
    GastricUlcerETerm                                               VARCHAR(200) NULL,
    GastricUlcerEDate                                               VARCHAR(50) NULL,
    DuodenalUlcerECode                                              VARCHAR(50) NULL,
    DuodenalUlcerETerm                                              VARCHAR(200) NULL,
    DuodenalUlcerEDate                                              VARCHAR(50) NULL,
    GastricCancerECode                                              VARCHAR(50) NULL,
    GastricCancerETerm                                              VARCHAR(200) NULL,
    GastricCancerEDate                                              VARCHAR(50) NULL,
    PrematureMenopauseECode                                         VARCHAR(50) NULL,
    PrematureMenopauseETerm                                         VARCHAR(200) NULL,
    PrematureMenopauseEDate                                         VARCHAR(50) NULL,
    EndometriosisECode                                              VARCHAR(50) NULL,
    EndometriosisETerm                                              VARCHAR(200) NULL,
    EndometriosisEDate                                              VARCHAR(50) NULL,
    AlopeciaAllECode                                                VARCHAR(50) NULL,
    AlopeciaAllETerm                                                VARCHAR(200) NULL,
    AlopeciaAllEDate                                                VARCHAR(50) NULL,
    MalePatternAlopeciaECode                                        VARCHAR(50) NULL, 
    MalePatternAlopeciaETerm                                        VARCHAR(200) NULL,
    MalePatternAlopeciaEDate                                        VARCHAR(50) NULL,
    HirsuitismECode                                                 VARCHAR(50) NULL,
    HirsuitismETerm                                                 VARCHAR(200) NULL,
    HirsuitismEDate                                                 VARCHAR(50) NULL,
    AmenorrhoeaOligomeorrhoeaIrregularMensesAnovulationECode        VARCHAR(50) NULL,
    AmenorrhoeaOligomeorrhoeaIrregularMensesAnovulationETerm        VARCHAR(200) NULL,
    AmenorrhoeaOligomeorrhoeaIrregularMensesAnovulationEDate        VARCHAR(50) NULL
);

ALTER TABLE gh2_diagnoses2adataset ADD INDEX gh2d2a_pseudoid_idx (pseudo_id);
INSERT INTO gh2_diagnoses2adataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

END//
DELIMITER ;

