USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute17;

DELIMITER //
CREATE PROCEDURE gh2execute17()
BEGIN

-- Hypothyroidism CaseControl

DROP TABLE IF EXISTS gh2_HypothyroidismDataset;

CREATE TABLE gh2_HypothyroidismDataset (
   pseudo_id                                           VARCHAR(255),
   pseudo_nhsnumber                                    VARCHAR(255),
   HypothyroidismEmergeCaseInclusionCodes              VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeCaseExclusionCodes              VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeMedications                     VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeMedicationsPrescribed2Times     VARCHAR(1) DEFAULT '0',    
   HypothyroidismEmergeThyroidAlteringMedications      VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeControlExclusionCodes           VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeTshTested                       VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeTshAllNormal                    VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeTshAnyAbnormal                  VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeFt4Tested                       VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeFt4AllNormal                    VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeFt4AnyAbnormal                  VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeCases                           VARCHAR(1) DEFAULT '0',
   HypothyroidismEmergeControls                        VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_HypothyroidismDataset ADD INDEX Hypothyroidism_pseudo_idx(pseudo_id);

INSERT INTO gh2_HypothyroidismDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('HypothyroidismEmergeCaseInclusionCodes','gh2_HypothyroidismDataset','66944004,237519003','111566002',null,null,1);

CALL populateCaseControlV2('HypothyroidismEmergeCaseExclusionCodes','gh2_HypothyroidismDataset','27059002,190279008,237528002,190277005,88273006,190284002,63115005,30229009,39444001,49830003,367631000119105,26692000,2917005,54823002,82598004,428165003,10809101000119109,237555006,190268003,199235001,14304000,15463004,91637004,108290001',null,'66944004,237519003','111566002',1);
CALL populateCaseControlV2('HypothyroidismEmergeCaseExclusionCodes','gh2_HypothyroidismDataset','40556005,69236009,321719003,404864000,3814009',null,null,null,2);

CALL populateCaseControlV2('HypothyroidismEmergeMedications','gh2_HypothyroidismDataset','61020000',null,null,null,2);

-- HypothyroidismEmergeMedicationsPrescribed2Times starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('61020000', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp;

CREATE TEMPORARY TABLE hypo_tmp AS
SELECT ocr.group_by,
       IF(SUM(ocr.noPrescribed) > 0, '1', '0') prescribed
FROM (SELECT m.group_by, 
             m.original_code, 
             IF(COUNT(DISTINCT m.clinical_effective_date) >=2, 1, 0) noPrescribed
      FROM cohort_gh2_medications m 
      WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
      AND m.clinical_effective_date IS NOT NULL
      GROUP BY m.group_by, m.original_code
      ) ocr
GROUP BY ocr.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp ocr2 ON d.pseudo_id = ocr2.group_by
SET d.HypothyroidismEmergeMedicationsPrescribed2Times = ocr2.prescribed
WHERE ocr2.prescribed = '1';

-- HypothyroidismEmergeMedicationsPrescribed2Times  ends

CALL populateCaseControlV2('HypothyroidismEmergeThyroidAlteringMedications','gh2_HypothyroidismDataset','40556005,69236009,321719003,404864000,3814009',null,null,null,2);

CALL populateCaseControlV2('HypothyroidismEmergeControlExclusionCodes','gh2_HypothyroidismDataset','14304000,91637004,15463004,108290001',null,null,null,1);
CALL populateCaseControlV2('HypothyroidismEmergeControlExclusionCodes','gh2_HypothyroidismDataset','61020000,40556005,69236009,321719003,404864000,3814009',null,null,null,2);

-- HypothyroidismEmergeTshTested starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1027151000000105', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp;

CREATE TEMPORARY TABLE hypo_tmp AS
SELECT o.group_by                                           --  at least 1 valid result
FROM cohort_gh2_observations o
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
AND o.result_value IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.HypothyroidismEmergeTshTested = '1';

-- HypothyroidismEmergeTshTested ends

-- HypothyroidismEmergeTshAllNormal starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1027151000000105', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp1;
DROP TEMPORARY TABLE IF EXISTS hypo_tmp2;

CREATE TEMPORARY TABLE hypo_tmp1 AS
SELECT o.group_by, COUNT(o.original_code)  noOfSnomeds    --  number of snomeds
FROM cohort_gh2_observations o
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
GROUP BY o.group_by;

CREATE TEMPORARY TABLE hypo_tmp2 AS
SELECT o.group_by, COUNT(o.result_value)  noOfResults    --  number of results
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND o.result_value BETWEEN 0.5 AND 5
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp1 ocr ON d.pseudo_id = ocr.group_by
JOIN hypo_tmp2 ocr2 ON d.pseudo_id = ocr2.group_by
SET d.HypothyroidismEmergeTshAllNormal = '1'
WHERE ocr.noOfSnomeds = ocr2.noOfResults;    -- ALL normal

-- HypothyroidismEmergeTshAllNormal ends

-- HypothyroidismEmergeTshAnyAbnormal starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1027151000000105', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp;

CREATE TEMPORARY TABLE hypo_tmp AS
SELECT o.group_by                                   -- any result greater than 5
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND o.result_value > 5
AND o.result_value IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.HypothyroidismEmergeTshAnyAbnormal = '1';    -- Any abnormal

-- HypothyroidismEmergeTshAnyAbnormal ends

-- HypothyroidismEmergeFt4Tested starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1030801000000101', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp;

CREATE TEMPORARY TABLE hypo_tmp AS
SELECT o.group_by                         --  at least 1 valid result
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND o.result_value IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.HypothyroidismEmergeFt4Tested = '1';

-- HypothyroidismEmergeFt4Tested ends

-- HypothyroidismEmergeFt4AllNormal starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1030801000000101', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp1;
DROP TEMPORARY TABLE IF EXISTS hypo_tmp2;

CREATE TEMPORARY TABLE hypo_tmp1 AS
SELECT o.group_by, COUNT(o.original_code)  noOfSnomeds    --  number of snomeds
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
GROUP BY o.group_by;

CREATE TEMPORARY TABLE hypo_tmp2 AS
SELECT o.group_by, COUNT(o.result_value)  noOfResults    --  number of results
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND o.result_value BETWEEN 0.5 AND 1.2
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp1 ocr ON d.pseudo_id = ocr.group_by
JOIN hypo_tmp2 ocr2 ON d.pseudo_id = ocr2.group_by
SET d.HypothyroidismEmergeFt4AllNormal = '1'
WHERE ocr.noOfSnomeds = ocr2.noOfResults;    -- ALL normal

-- HypothyroidismEmergeFt4AllNormal ends

-- HypothyroidismEmergeFt4AnyAbnormal starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('1030801000000101', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS hypo_tmp;

CREATE TEMPORARY TABLE hypo_tmp AS
SELECT o.group_by                                     -- any result less than 0.5
FROM cohort_gh2_observations o
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND o.result_value < 0.5
AND o.result_value IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_HypothyroidismDataset d 
JOIN hypo_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.HypothyroidismEmergeFt4AnyAbnormal = '1';    -- Any abnormal

-- HypothyroidismEmergeFt4AnyAbnormal ends

-- HypothyroidismEmergeCases starts

UPDATE gh2_HypothyroidismDataset  
SET  HypothyroidismEmergeCases = '1'
WHERE HypothyroidismEmergeCaseInclusionCodes = '1'
AND HypothyroidismEmergeCaseExclusionCodes = '0'
AND HypothyroidismEmergeMedicationsPrescribed2Times = '1'
AND HypothyroidismEmergeTshAnyAbnormal = '1';

-- HypothyroidismEmergeCases ends

-- HypothyroidismEmergeControls starts

UPDATE gh2_HypothyroidismDataset  
SET HypothyroidismEmergeControls = '1'
WHERE HypothyroidismEmergeCaseInclusionCodes = '0'
AND HypothyroidismEmergeCaseExclusionCodes = '0'
AND HypothyroidismEmergeTshAllNormal = '1';

-- HypothyroidismEmergeControls ends


END //
DELIMITER ;