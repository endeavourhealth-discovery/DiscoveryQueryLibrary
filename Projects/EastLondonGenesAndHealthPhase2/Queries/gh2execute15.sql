USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute15;

DELIMITER //
CREATE PROCEDURE gh2execute15()
BEGIN

-- T2D emerge CaseControl

DROP TABLE IF EXISTS gh2_t2dEmergeDataset;

CREATE TABLE gh2_t2dEmergeDataset (
   pseudo_id                                         VARCHAR(255),
   pseudo_nhsnumber                                  VARCHAR(255),
   T2DEmergeCaseInclusionCodes	                  VARCHAR(1)  DEFAULT '0',
   T2DEmergeCaseInclusionCodeCount                   INT  DEFAULT 0,
   T1DEmergeCodes                                    VARCHAR(1)  DEFAULT '0',
   DiabetesResolvedCode                              VARCHAR(1)  DEFAULT '0',
   T2DEmergeMedications                              VARCHAR(1)  DEFAULT '0',
   T2DEmergeMedicationsEarliestDate                  VARCHAR(20) DEFAULT NULL,
   T1DEmergeMedications                              VARCHAR(1)  DEFAULT '0',
   T1DEmergeMedicationsEarliestDate                  VARCHAR(20) DEFAULT NULL,
   T2DEmergeControlExclusionCodes                    VARCHAR(1)  DEFAULT '0',
   DiabetesEmergeSupplies                            VARCHAR(1)  DEFAULT '0',
   T2DEmergeLabs                                     VARCHAR(1)  DEFAULT '0',
   T2DEmergeAbnormalLabsCases                        VARCHAR(1)  DEFAULT '0',
   T2DEmergeAbnormalLabsControls                     VARCHAR(1)  DEFAULT '0',
   Gteq2Encounters                                   VARCHAR(1)  DEFAULT '0',
   T2DEmergeCase1                                    VARCHAR(1)  DEFAULT '0',
   T2DEmergeCase2                                    VARCHAR(1)  DEFAULT '0',
   T2DEmergeCase3                                    VARCHAR(1)  DEFAULT '0',
   T2DEmergeCase4                                    VARCHAR(1)  DEFAULT '0',
   T2DEmergeCase5                                    VARCHAR(1)  DEFAULT '0',
   T2DBespokeCase6SF                                 VARCHAR(1)  DEFAULT '0',
   T2DEmergeControls                                 VARCHAR(1)  DEFAULT '0'
);

ALTER TABLE gh2_t2dEmergeDataset ADD INDEX t2dEmerge_pseudo_idx(pseudo_id);

INSERT INTO gh2_t2dEmergeDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('T2DEmergeCaseInclusionCodes','gh2_t2dEmergeDataset','44054006',null,null,null,1);

-- T2DEmergeCaseInclusionCodeCount starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('44054006', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS
SELECT o.group_by, 
       COUNT(DISTINCT o.clinical_effective_date) includeCount
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
AND o.clinical_effective_date IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.T2DEmergeCaseInclusionCodeCount = ocr.includeCount;

-- T2DEmergeCaseInclusionCodeCount end

CALL populateCaseControlV2('T1DEmergeCodes','gh2_t2dEmergeDataset','46635009',null,null,null,1);

CALL populateCaseControlV2('DiabetesResolvedCode','gh2_t2dEmergeDataset','315051004',null,null,null,1);

CALL populateCaseControlV2('T2DEmergeMedications','gh2_t2dEmergeDataset','34012005,109081006,762432004,422403005,416636000,109074004,134604002,109075003,703677008,764135009',null,null,null,2);

-- T2DEmergeMedicationsEarliestDate starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('34012005,109081006,762432004,422403005,416636000,109074004,134604002,109075003,703677008,764135009', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS
SELECT m.group_by, 
       MIN(DISTINCT m.clinical_effective_date) AS EarliestDate, 
       COUNT(DISTINCT m.clinical_effective_date) AS medCount
FROM cohort_gh2_medications m 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
AND m.clinical_effective_date IS NOT NULL
GROUP BY m.group_by
HAVING COUNT(DISTINCT m.clinical_effective_date) >= 5; 

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp med ON d.pseudo_id = med.group_by
SET d.T2DEmergeMedicationsEarliestDate = date_format(med.EarliestDate, '%d/%m/%Y');

-- T2DEmergeMedicationsEarliestDate end

-- T1DEmergeMedications starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('39487003', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS 
SELECT m.group_by
FROM cohort_gh2_medications m 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
GROUP BY m.group_by;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp med ON d.pseudo_id = med.group_by
SET d.T1DEmergeMedications = '1';

-- T1DEmergeMedications end

-- T1DEmergeMedicationsEarliestDate starts

-- using the same snomed set as above

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS
SELECT m.group_by, 
       MIN(DISTINCT m.clinical_effective_date) AS EarliestDate, 
       COUNT(DISTINCT m.clinical_effective_date) AS medCount
FROM cohort_gh2_medications m 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
AND m.clinical_effective_date IS NOT NULL
GROUP BY m.group_by
HAVING COUNT(DISTINCT m.clinical_effective_date) >= 5;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp med ON d.pseudo_id = med.group_by
SET d.T1DEmergeMedicationsEarliestDate = date_format(med.EarliestDate, '%d/%m/%Y');


-- T1DEmergeMedicationsEarliestDate end

CALL populateCaseControlV2('T2DEmergeControlExclusionCodes','gh2_t2dEmergeDataset','73211009,390951007,274858002,166927002,11687002,45154002,267430007,237602007,354068006,337388004,34408811000001106,413671005,69805005,450657002,443263006',null,null,null,1);

CALL populateCaseControlV2('DiabetesEmergeSupplies','gh2_t2dEmergeDataset','354068006,337388004,34408811000001106,413671005,462662009,462552008,336919003,717306001,69805005,450657002,443263006',null,null,null,1);

-- T2DEmergeLabs starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('997681000000108,1003131000000101,1003141000000105,1028881000000105,1089381000000101,1031331000000106,1003671000000109,443911005', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS 
SELECT o.group_by      -- at least 1 valid result
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
AND o.result_value IS NOT NULL
GROUP BY o.group_by;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.T2DEmergeLabs = '1';

-- T2DEmergeLabs ends

-- T2DEmergeAbnormalLabsCases starts
-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('997681000000108,1003131000000101,1003141000000105,1028881000000105,1089381000000101,1031331000000106,371981000000106,313835008', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS
SELECT o.group_by      -- at least 1 valid result
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
AND (o.original_code = 371981000000106 AND o.result_value >= 48 OR
     o.original_code = 313835008 AND o.result_value >= 6.5 OR
     o.original_code = 997681000000108 AND o.result_value >= 7 OR
     o.original_code = 1003131000000101 AND o.result_value >= 7 OR
     o.original_code = 1003141000000105 AND o.result_value >= 7 OR 
     o.original_code = 1028881000000105 AND o.result_value > 11.1 OR 
     o.original_code = 1089381000000101 AND o.result_value > 11.1 OR 
     o.original_code = 1031331000000106 AND o.result_value > 11.1)   
GROUP BY o.group_by;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.T2DEmergeAbnormalLabsCases = '1';

-- T2DEmergeAbnormalLabsCases ends

-- using the same set of snomeds for T2DEmergeAbnormalLabsControls - therefore no need to re-populate

-- starts

DROP TEMPORARY TABLE IF EXISTS t2_tmp;

CREATE TEMPORARY TABLE t2_tmp AS
SELECT o.group_by      -- at least 1 valid result
FROM cohort_gh2_observations o 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
AND (o.original_code = 371981000000106 AND o.result_value >= 42 OR
     o.original_code = 313835008 AND o.result_value >= 6 OR
     o.original_code = 997681000000108 AND o.result_value >= 6.1 OR
     o.original_code = 1003131000000101 AND o.result_value >= 6.1 OR
     o.original_code = 1003141000000105 AND o.result_value >= 6.1 OR 
     o.original_code = 1028881000000105 AND o.result_value > 6.1 OR 
     o.original_code = 1089381000000101 AND o.result_value > 6.1 OR 
     o.original_code = 1031331000000106 AND o.result_value > 6.1)   
GROUP BY o.group_by;

UPDATE gh2_t2dEmergeDataset d 
JOIN t2_tmp ocr ON d.pseudo_id = ocr.group_by
SET d.T2DEmergeAbnormalLabsControls = '1';

-- ends

--  Gteq2Encounters starts

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
     row_id          INT,
     group_by        VARCHAR(255), 
     noOfEncounters  INT, PRIMARY KEY(row_id)      
) AS
SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.noOfEncounters
FROM (SELECT cr.group_by, 
             COUNT(DISTINCT e.clinical_effective_date) noOfEncounters
      FROM cohort_gh2_encounter_raw e JOIN cohort_gh2 cr ON e.person_id = cr.person_id 
      WHERE EXISTS (SELECT 'x' FROM gh2_f2fEncounters s WHERE s.term = e.fhir_original_term) 
      AND e.clinical_effective_date IS NOT NULL
      GROUP BY cr.group_by
      HAVING COUNT(DISTINCT e.clinical_effective_date) >= 2) a, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

      UPDATE gh2_t2dEmergeDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by
      SET d.Gteq2Encounters = '1' WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;

      SET @row_id = @row_id + 1000; 

END WHILE;

-- ends

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeCase1 = '1'
WHERE T2DEmergeCaseInclusionCodes = '1'
AND T1DEmergeCodes = '0'
AND T1DEmergeMedications = '1'
AND T2DEmergeMedications = '1'
AND str_to_date(T2DEmergeMedicationsEarliestDate, '%d/%m/%Y') < str_to_date(T1DEmergeMedicationsEarliestDate, '%d/%m/%Y');

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeCase2 = '1'
WHERE T2DEmergeCaseInclusionCodes = '1'
AND T1DEmergeCodes = '0'
AND T1DEmergeMedications = '0'
AND T2DEmergeMedications = '1';

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeCase3 = '1'
WHERE T2DEmergeCaseInclusionCodes = '1'
AND T1DEmergeCodes = '0'
AND T1DEmergeMedications = '0'
AND T2DEmergeMedications = '0'
AND T2DEmergeAbnormalLabsCases = '1';

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeCase4 = '1'
WHERE T2DEmergeCaseInclusionCodes = '0'
AND T1DEmergeCodes = '0'
AND T2DEmergeMedications = '1'
AND T2DEmergeAbnormalLabsCases = '1';

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeCase5 = '1'
WHERE T2DEmergeCaseInclusionCodes = '1'
AND T1DEmergeCodes = '0'
AND T1DEmergeMedications = '1'
AND T2DEmergeMedications ='0'
AND T2DEmergeCaseInclusionCodeCount >= 2;

UPDATE gh2_t2dEmergeDataset
SET T2DBespokeCase6SF = '1'
WHERE T2DEmergeCaseInclusionCodes = '1'
AND T1DEmergeCodes = '0'
AND T1DEmergeMedications ='1'
AND T2DEmergeMedications = '1'
AND str_to_date(T1DEmergeMedicationsEarliestDate, '%d/%m/%Y') < str_to_date(T2DEmergeMedicationsEarliestDate, '%d/%m/%Y')
AND T2DEmergeCaseInclusionCodeCount >= 2;

UPDATE gh2_t2dEmergeDataset
SET T2DEmergeControls = '1'
WHERE T2DEmergeControlExclusionCodes = '0'
AND T1DEmergeMedications = '0'
AND T2DEmergeMedications = '0'
AND DiabetesEmergeSupplies = '0'
AND Gteq2Encounters = '1'
AND T2DEmergeLabs = '1'
AND T2DEmergeAbnormalLabsControls = '0';


END //
DELIMITER ;
