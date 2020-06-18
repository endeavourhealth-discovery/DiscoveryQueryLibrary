USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute16;

DELIMITER //
CREATE PROCEDURE gh2execute16()
BEGIN

-- CAD CaseControl

DROP TABLE IF EXISTS gh2_cadDataset;

CREATE TABLE gh2_cadDataset (
   pseudo_id                        VARCHAR(255),
   pseudo_nhsnumber                 VARCHAR(255),
   CadHardCasesInclusionCodes       VARCHAR(1) DEFAULT '0',
   CadAllCasesInclusionCodes        VARCHAR(1) DEFAULT '0',
   CadControlExclusionCodes         VARCHAR(1) DEFAULT '0',
   CadControls                      VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_cadDataset ADD INDEX cad_pseudo_idx(pseudo_id);

INSERT INTO gh2_cadDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('CadHardCasesInclusionCodes','gh2_cadDataset','22298006,399211009,41339005,232717009,399261000',null,null,null,1);
CALL populateCaseControlV2('CadAllCasesInclusionCodes','gh2_cadDataset','53741008,67682002,398274000,233970002,414545008,63739005',null,null,null,1);
CALL populateCaseControlV2('CadControlExclusionCodes','gh2_cadDataset','56265001',null,null,null,1);

UPDATE gh2_cadDataset
SET CadControls = '1'
WHERE CadControlExclusionCodes = '0';

END //
DELIMITER ;