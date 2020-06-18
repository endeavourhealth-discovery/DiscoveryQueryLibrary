USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS createGH2DemographicsDataset;

DELIMITER //
CREATE PROCEDURE createGH2DemographicsDataset()
BEGIN

-- Demographics
-- Diagnoses (1)

DROP TABLE IF EXISTS gh2_demographicsDataset;

CREATE TABLE gh2_demographicsDataset (
    ExtractDate                                            DATETIME     NULL,
    Pseudo_id                                              VARCHAR(255) NULL,
    Pseudo_NHSNumber                                       VARCHAR(255) NULL,
    Gender                                                 VARCHAR(50)  NULL,
    Age                                                    VARCHAR(50)  NULL,
    DateOfBirth                                            DATE         NULL,
    EthnicityLCode                                         VARCHAR(50)  NULL,
    EthnicityLTerm                                         VARCHAR(200)  NULL,
    BirthCountryLCode                                      VARCHAR(50)  NULL,
    BirthCountryLTerm                                      VARCHAR(200)  NULL,
    RegistrationStart                                      DATE  NULL,
    RegistrationEnd                                        DATE  NULL,
    IMD2010                                                VARCHAR(50)  NULL,
    LSOA2011                                               VARCHAR(50)  NULL,
    PracticeODSCode                                        VARCHAR(50)  NULL,
    PracticeODSName                                        VARCHAR(255)  NULL,
    CCGName                                                VARCHAR(100) NULL,
    YearOfDeath                                            INT(4)  NULL,
    F2fVisits_Total                                        INT(11) DEFAULT 0,
    F2fVisits_1year                                        INT(11) DEFAULT 0,
    F2fVisits_5years                                       INT(11) DEFAULT 0
);
  
ALTER TABLE gh2_demographicsDataset ADD INDEX gh2Demo_pseudoid_idx (pseudo_id);
INSERT INTO gh2_demographicsDataset (pseudo_id, extractdate) SELECT DISTINCT group_by, now() FROM cohort_gh2;
  
END//
DELIMITER ;