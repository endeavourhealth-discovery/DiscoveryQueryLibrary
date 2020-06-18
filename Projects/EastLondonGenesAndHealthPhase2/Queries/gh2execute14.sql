USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute14;

DELIMITER //
CREATE PROCEDURE gh2execute14()
BEGIN

-- Hypertension emerge CaseControl

DROP TABLE IF EXISTS gh2_hypertensionEmergeDataset;

CREATE TABLE gh2_hypertensionEmergeDataset (
   pseudo_id                                         VARCHAR(255),
   pseudo_nhsnumber                                  VARCHAR(255),
   HypertensionBroadCaseInclusionCodes               VARCHAR(1) DEFAULT '0',
   HypertensionEmergeCaseInclusionCodes              VARCHAR(1) DEFAULT '0',
   ResistantHypertensionEmergCaseInclusionCodes      VARCHAR(1) DEFAULT '0',
   HypertensionResolvedCode                          VARCHAR(1) DEFAULT '0',
   HypertensionEmergeMedications                     VARCHAR(1) DEFAULT '0',
   HypertensionCaseExclusionCodes                    VARCHAR(1) DEFAULT '0',
   HypertensionControlExclusionCodes                 VARCHAR(1) DEFAULT '0',
   HypertensionEmergeCases                           VARCHAR(1) DEFAULT '0',
   HypertensionEmergeControls                        VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_hypertensionEmergeDataset ADD INDEX hypertensionEmerge_pseudo_idx(pseudo_id);

INSERT INTO gh2_hypertensionEmergeDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('HypertensionBroadCaseInclusionCodes','gh2_hypertensionEmergeDataset','38341003',null,null,null,1);

CALL populateCaseControlV2('HypertensionEmergeCaseInclusionCodes','gh2_hypertensionEmergeDataset','38341003',null,'71701000119105,71421000119105,198941007,367390009,118781000119108,48194001,31992008',null,1);

CALL populateCaseControlV2('ResistantHypertensionEmergCaseInclusionCodes','gh2_hypertensionEmergeDataset','845891000000103',null,null,null,1);

CALL populateCaseControlV2('HypertensionResolvedCode','gh2_hypertensionEmergeDataset','162659009',null,null,null,1);

CALL populateCaseControlV2('HypertensionEmergeMedications','gh2_hypertensionEmergeDataset','41549009,96308008,33252009,48698004,768616000,74213004,22198003,317968004,57893000,400606007,429462003,81609008,318034005,86647004,81947000,318031002,64029000,346312000,87395005,12512008,409434000,22696000,108556006,76058001,129484001,84078002,318706009,62782004,67440007,108478001,426230004',null,'319407007,317730008,16109611000001108,9315411000001108,18161111000001107,9056111000001102,22702711000001103,18153411000001105,20353011000001109,36774711000001102,15774611000001105,15648511000001108,9055911000001106',null,2);

CALL populateCaseControlV2('HypertensionCaseExclusionCodes','gh2_hypertensionEmergeDataset','363355002,91967007,30171000,31992008,87837008,52254009,20917003,268174004,7305005',null,null,null,1);

CALL populateCaseControlV2('HypertensionControlExclusionCodes','gh2_hypertensionEmergeDataset','38341003,363355002,91967007,30171000,31992008,87837008,52254009,20917003,268174004,7305005',null,null,null,1);

UPDATE gh2_hypertensionEmergeDataset 
SET HypertensionEmergeCases = '1'
WHERE HypertensionEmergeCaseInclusionCodes = '1'
AND HypertensionEmergeMedications = '1'
AND HypertensionCaseExclusionCodes = '0';

UPDATE gh2_hypertensionEmergeDataset
SET HypertensionEmergeControls = '1'
WHERE HypertensionEmergeCaseInclusionCodes = '0'
AND HypertensionEmergeMedications = '0'
AND HypertensionControlExclusionCodes = '0';


END //
DELIMITER ;