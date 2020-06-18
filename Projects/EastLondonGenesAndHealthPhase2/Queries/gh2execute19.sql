USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute19;

DELIMITER //
CREATE PROCEDURE gh2execute19()
BEGIN

-- Depression CaseControl

DROP TABLE IF EXISTS gh2_DepressionDataset;

CREATE TABLE gh2_DepressionDataset (
   pseudo_id                                         VARCHAR(255),
   pseudo_nhsnumber                                  VARCHAR(255),
   DepressionCaseInclusionCodes                      VARCHAR(1) DEFAULT '0',
   DepressionControlExclusionCodes                   VARCHAR(1) DEFAULT '0',
   DepressionControlExclusionMedications             VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_DepressionDataset ADD INDEX depression_pseudo_idx(pseudo_id);

INSERT INTO gh2_DepressionDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('DepressionCaseInclusionCodes','gh2_DepressionDataset','35489007,76105009',null,'191627008,442057004,231542000,231504006,231485007,84760002',null,1);
CALL populateCaseControlV2('DepressionControlExclusionCodes','gh2_DepressionDataset','46206005',null,null,null,1);
CALL populateCaseControlV2('DepressionControlExclusionCodes','gh2_DepressionDataset','768611005,7336002,96200003,108430001,767562003,96199001,349854005,29877002,321911007,9500005,89092006,96220002,41365009,321995004,349857003,96199001,321391002,47331002,26574002,96220002,41365009,10756001,89029005,59270007,321467007,41147003,108438008,79129001,108438008,44658005,321506004,33588000,71699007,429346008,321636003,406785006,443374004,763607001,96221003,715585000,108441004,425483000,108443001,108386000,349884002,321603004,40820003,96195007,40556005,13965000,415159003,768698000,349883008,349879008,51073002,46709004',null,null,null,2);

END //
DELIMITER ;