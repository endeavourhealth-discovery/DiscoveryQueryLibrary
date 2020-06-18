USE data_extracts;

-- ahui 7/2/2020

DROP PROCEDURE IF EXISTS createGH2Dataset5;

DELIMITER //
CREATE PROCEDURE createGH2Dataset5()
BEGIN

-- Measurements

DROP TABLE IF EXISTS gh2_measuresdataset;

CREATE TABLE gh2_measuresdataset (
     Pseudo_id                                                VARCHAR(255) NULL,
     Pseudo_NHSNumber                                         VARCHAR(255) NULL,
     SmokingStatusLCode                                       VARCHAR(50) NULL,
     SmokingStatusLTerm                                       VARCHAR(200) NULL,
     SmokingStatusLDate                                       VARCHAR(50) NULL,
     WeightECode                                              VARCHAR(50) NULL,
     WeightETerm                                              VARCHAR(200) NULL,
     WeightEValue                                             VARCHAR(50) NULL,
     WeightEUnit                                              VARCHAR(50) NULL,
     WeightEDate                                              VARCHAR(50) NULL,
     WeightEAge                                               VARCHAR(50) NULL,
     WeightLCode                                              VARCHAR(50) NULL,
     WeightLTerm                                              VARCHAR(200) NULL,
     WeightLValue                                             VARCHAR(50) NULL,
     WeightLUnit                                              VARCHAR(50) NULL,
     WeightLDate                                              VARCHAR(50) NULL,
     WeightLAge                                               VARCHAR(50) NULL,
     Weight6Code                                              VARCHAR(50) NULL,
     Weight6Term                                              VARCHAR(200) NULL,
     Weight6Value                                             VARCHAR(50) NULL,
     Weight6Unit                                              VARCHAR(50) NULL,
     Weight6Date                                              VARCHAR(50) NULL,
     Weight6Age                                               VARCHAR(50) NULL,
     HeightECode                                              VARCHAR(50) NULL,
     HeightETerm                                              VARCHAR(200) NULL,
     HeightEValue                                             VARCHAR(50) NULL,
     HeightEUnit                                              VARCHAR(50) NULL,
     HeightEDate                                              VARCHAR(50) NULL,
     HeightEAge                                               VARCHAR(50) NULL,
     HeightLCode                                              VARCHAR(50) NULL,
     HeightLTerm                                              VARCHAR(200) NULL,
     HeightLValue                                             VARCHAR(50) NULL,
     HeightLUnit                                              VARCHAR(50) NULL,
     HeightLDate                                              VARCHAR(50) NULL,
     HeightLAge                                               VARCHAR(50) NULL,
     Height6Code                                              VARCHAR(50) NULL,
     Height6Term                                              VARCHAR(200) NULL,
     Height6Value                                             VARCHAR(50) NULL,
     Height6Unit                                              VARCHAR(50) NULL,
     Height6Date                                              VARCHAR(50) NULL,
     Height6Age                                               VARCHAR(50) NULL,
     BMIECode                                                 VARCHAR(50) NULL,
     BMIETerm                                                 VARCHAR(200) NULL,
     BMIEValue                                                VARCHAR(50) NULL,
     BMIEUnit                                                 VARCHAR(50) NULL,
     BMIEDate                                                 VARCHAR(50) NULL,
     BMIEAge                                                  VARCHAR(50) NULL,
     BMILCode                                                 VARCHAR(50) NULL,
     BMILTerm                                                 VARCHAR(200) NULL,
     BMILValue                                                VARCHAR(50) NULL,
     BMILUnit                                                 VARCHAR(50) NULL,
     BMILDate                                                 VARCHAR(50) NULL,
     BMILAge                                                  VARCHAR(50) NULL,
     BMI6Code                                                 VARCHAR(50) NULL,
     BMI6Term                                                 VARCHAR(200) NULL,
     BMI6Value                                                VARCHAR(50) NULL,
     BMI6Unit                                                 VARCHAR(50) NULL,
     BMI6Date                                                 VARCHAR(50) NULL,
     BMI6Age                                                  VARCHAR(50) NULL,
     SystolicBloodPressureECode                               VARCHAR(50) NULL,
     SystolicBloodPressureETerm                               VARCHAR(200) NULL,
     SystolicBloodPressureEValue                              VARCHAR(50) NULL,
     SystolicBloodPressureEUnit                               VARCHAR(50) NULL,
     SystolicBloodPressureEDate                               VARCHAR(50) NULL,
     SystolicBloodPressureEAge                                VARCHAR(50) NULL,
     SystolicBloodPressureLCode                               VARCHAR(50) NULL,
     SystolicBloodPressureLTerm                               VARCHAR(200) NULL,
     SystolicBloodPressureLValue                              VARCHAR(50) NULL,
     SystolicBloodPressureLUnit                               VARCHAR(50) NULL,
     SystolicBloodPressureLDate                               VARCHAR(50) NULL,
     SystolicBloodPressureLAge                                VARCHAR(50) NULL,
     DiastolicBloodPressureECode                              VARCHAR(50) NULL,
     DiastolicBloodPressureETerm                              VARCHAR(200) NULL,
     DiastolicBloodPressureEValue                             VARCHAR(50) NULL,
     DiastolicBloodPressureEUnit                              VARCHAR(50) NULL,
     DiastolicBloodPressureEDate                              VARCHAR(50) NULL,
     DiastolicBloodPressureEAge                               VARCHAR(50) NULL,
     DiastolicBloodPressureLCode                              VARCHAR(50) NULL,
     DiastolicBloodPressureLTerm                              VARCHAR(200) NULL,
     DiastolicBloodPressureLValue                             VARCHAR(50) NULL,
     DiastolicBloodPressureLUnit                              VARCHAR(50) NULL,
     DiastolicBloodPressureLDate                              VARCHAR(50) NULL,
     DiastolicBloodPressureLAge                               VARCHAR(50) NULL
);  

ALTER TABLE gh2_measuresdataset ADD INDEX gh2d5_pseudoId_idx(Pseudo_id);
INSERT INTO gh2_measuresdataset (Pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;
    
END//
DELIMITER ;
