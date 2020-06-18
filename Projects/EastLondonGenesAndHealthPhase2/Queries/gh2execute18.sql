USE data_extracts;

-- ahui 12/2/2020

DROP PROCEDURE IF EXISTS gh2execute18;

DELIMITER //
CREATE PROCEDURE gh2execute18()
BEGIN

-- Atopic Dermatitis CaseControl

DROP TABLE IF EXISTS gh2_AtopicDermDataset;

CREATE TABLE gh2_AtopicDermDataset (
   pseudo_id                                           VARCHAR(255),
   pseudo_nhsnumber                                    VARCHAR(255),
   AtopicDermEmergeCaseInclusionCodes                  VARCHAR(1) DEFAULT '0',
   AtopicDermEmergeCaseInclusionCodeCount              INT DEFAULT 0,
   AtopicDermEmergeCaseExclusionCodes                  VARCHAR(1) DEFAULT '0',
   AtopicDermEmergeCaseMedicationsGtrEq2               VARCHAR(1) DEFAULT '0',
   AtopicDermEmergeCaseMedications                     VARCHAR(1) DEFAULT '0',
   AtopicDermEmergeControlExclusionCodes               VARCHAR(1) DEFAULT '0', 
   AtopicDermEmergeControlPast5YearsF2FEncounterCount  INT DEFAULT 0,
   AtopicDermEmergeControlExclusionMedications         VARCHAR(1) DEFAULT '0', 
   AtopicDermEmergeCases                               VARCHAR(1) DEFAULT '0', 
   AtopicDermEmergeControls                            VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_AtopicDermDataset ADD INDEX AtopicDerm_pseudo_idx(pseudo_id);

INSERT INTO gh2_AtopicDermDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('AtopicDermEmergeCaseInclusionCodes','gh2_AtopicDermDataset','24079001',null,null,null,1);

-- AtopicDermEmergeCaseInclusionCodeCount  starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('24079001', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp(
       row_id        INT,
       group_by      VARCHAR(255),
       includeCount  INT, PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.includeCount
FROM (SELECT o.group_by, 
             COUNT(DISTINCT o.clinical_effective_date) includeCount
      FROM cohort_gh2_observations o
      WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code) 
      AND o.clinical_effective_date IS NOT NULL
GROUP BY o.group_by) a, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

    UPDATE gh2_AtopicDermDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by
    SET AtopicDermEmergeCaseInclusionCodeCount = q.includeCount;   -- inclusion code count

    SET @row_id = @row_id + 1000; 

END WHILE;

-- AtopicDermEmergeCaseInclusionCodeCount ends

CALL populateCaseControlV2('AtopicDermEmergeCaseExclusionCodes','gh2_AtopicDermDataset','62752005,36070007,191306005,13059002,409709004',null,null,null,1);

-- AtopicDermEmergeCaseMedicationsGtrEq2 starts
-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('349355002,116576003,764616008,116589009,71455005,120624004,420859004,29058003,81457006,350465005,349355002,350438003,407754007,430519004,769209000,413870009,415158006,120623005,48279009,80165005,430971000,767990008,26462003,349964000,108655000,108652002,108650005,320830000,134506008,350448001,10312003,349354003,350449009,350396002,350463003,430167004,136113003,439257008,111165009,68887009,109131004', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
      row_id       INT,
      group_by     VARCHAR(255),
      prescribed   VARCHAR(1), PRIMARY KEY(row_id)
) AS
SELECT  (@row_no := @row_no + 1) AS row_id,
        a.group_by,
        a.prescribed
FROM (SELECT ocr.group_by,
             IF(SUM(ocr.noPrescribed) > 0, '1', '0') prescribed
      FROM (SELECT m.group_by, 
                   m.original_code, 
                   IF(COUNT(DISTINCT m.clinical_effective_date) >=2, 1, 0) noPrescribed
            FROM cohort_gh2_medications m 
            WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code)
            AND m.clinical_effective_date IS NOT NULL
            GROUP BY m.group_by, m.original_code) ocr 
      GROUP BY ocr.group_by
      HAVING IF(SUM(ocr.noPrescribed) > 0, '1', '0') = '1') a, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

     UPDATE gh2_AtopicDermDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by
     SET AtopicDermEmergeCaseMedicationsGtrEq2 = '1' WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;

     SET @row_id = @row_id + 1000; 

END WHILE;

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('82350007', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
      row_id       INT,
      group_by     VARCHAR(255),
      prescribed   VARCHAR(1), PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.prescribed
FROM (SELECT ocr.group_by,
             IF(SUM(ocr.noPrescribed) > 0, '1', '0') prescribed
      FROM (SELECT o.group_by, 
                   o.original_code, 
                   IF(COUNT(DISTINCT o.clinical_effective_date) >=2, 1, 0) noPrescribed
            FROM cohort_gh2_observations o 
            WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code)
            AND o.clinical_effective_date IS NOT NULL
            GROUP BY o.group_by, o.original_code) ocr
      GROUP BY ocr.group_by
      HAVING IF(SUM(ocr.noPrescribed) > 0, '1', '0') = '1') a, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

     UPDATE gh2_AtopicDermDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by
     SET AtopicDermEmergeCaseMedicationsGtrEq2 = '1' WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;
     
     SET @row_id = @row_id + 1000; 

END WHILE;

-- AtopicDermEmergeCaseMedicationsGtrEq2 end

-- CALL populateCaseControlV2('AtopicDermEmergeCaseMedications','gh2_AtopicDermDataset','349355002,116576003,764616008,116589009,71455005,120624004,420859004,29058003,81457006,350465005,349355002,350438003,407754007,430519004,769209000,413870009,415158006,120623005,48279009,80165005,430971000,767990008,26462003,349964000,108655000,108652002,108650005,320830000,134506008,350448001,10312003,349354003,350449009,350396002,82350007,350463003,82350007,430167004,136113003,439257008,111165009,68887009,109131004',null,null,null,2);

CALL populateCaseControlV2('AtopicDermEmergeCaseMedications','gh2_AtopicDermDataset','349355002,116576003,764616008,116589009,71455005,120624004,420859004,29058003,81457006,350465005,349355002,350438003,407754007,430519004,769209000,413870009,415158006,120623005,48279009,80165005,430971000,767990008,26462003,349964000,108655000,108652002,108650005,320830000,134506008,350448001',null,null,null,2);
CALL populateCaseControlV2('AtopicDermEmergeCaseMedications','gh2_AtopicDermDataset','10312003,349354003,350449009,350396002,82350007,350463003,82350007,430167004,136113003,439257008,111165009,68887009,109131004',null,null,null,2);

-- CALL populateCaseControlV2('AtopicDermEmergeControlExclusionCodes','gh2_AtopicDermDataset','54792008,40275004,13582007,7231009,86735004,9014002,88996004,279333002,91487003,62752005,414029004,70241007,372130007,92749008,191306005,267543009,195967001,26045000,61582004,48277006,126485001,271807003,62014003,609328004,13059002,409709004,80659006,735933002,161611007,161432005,429050006',null,null,null,1);
CALL populateCaseControlV2('AtopicDermEmergeControlExclusionCodes','gh2_AtopicDermDataset','54792008,40275004,13582007,7231009,86735004,9014002,88996004,279333002,91487003,62752005,414029004,70241007,372130007,92749008,191306005,267543009,195967001,26045000,61582004,48277006',null,null,null,1);
CALL populateCaseControlV2('AtopicDermEmergeControlExclusionCodes','gh2_AtopicDermDataset','126485001,271807003,62014003,609328004,13059002,409709004,80659006,735933002,161611007,161432005,429050006',null,null,null,1);

-- -- F2F visits

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
      row_id       INT,
      group_by     VARCHAR(255),
      visits       INT, PRIMARY KEY(row_id)
) AS 
SELECT (@row_no := @row_no + 1) AS row_id,
       a.group_by,
       a.visits
FROM (SELECT cr.group_by AS group_by, 
             COUNT(DISTINCT e.clinical_effective_date) AS visits
      FROM cohort_gh2_encounter_raw e JOIN cohort_gh2 cr ON e.person_id = cr.person_id 
      WHERE EXISTS (SELECT 'x' FROM gh2_f2fEncounters s WHERE s.term = e.fhir_original_term) 
      AND e.clinical_effective_date IS NOT NULL
      AND e.fhir_original_term IS NOT NULL 
      AND e.clinical_effective_date > DATE_SUB(now(), INTERVAL 60 MONTH)  -- last 5 yrs
      GROUP BY cr.group_by
      HAVING COUNT(DISTINCT e.clinical_effective_date) >=2) a, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

     UPDATE gh2_AtopicDermDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by 
     SET d.AtopicDermEmergeControlPast5YearsF2FEncounterCount = q.visits WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;

     SET @row_id = @row_id + 1000; 

END WHILE;

-- -- F2F visits ends

CALL populateCaseControlV2('AtopicDermEmergeControlExclusionMedications','gh2_AtopicDermDataset','349355002,116576003,764616008,116589009,71455005,120624004,420859004,29058003,81457006,350465005,349355002,350438003,407754007,430519004,769209000,413870009,415158006,120623005,48279009,350448001,10312003,349354003,350449009,350396002,350463003,430167004,136113003,439257008,111165009,68887009,109131004',null,null,null,2);
CALL populateCaseControlV2('AtopicDermEmergeControlExclusionMedications','gh2_AtopicDermDataset','82350007',null,null,null,1);

UPDATE gh2_AtopicDermDataset
SET AtopicDermEmergeCases = '1'
WHERE AtopicDermEmergeCaseInclusionCodes = '1'
AND AtopicDermEmergeCaseInclusionCodeCount >= 2
AND AtopicDermEmergeCaseMedicationsGtrEq2 = '1'
AND AtopicDermEmergeCaseExclusionCodes = '0';

UPDATE gh2_AtopicDermDataset
SET AtopicDermEmergeControls = '1'
WHERE  AtopicDermEmergeCaseInclusionCodes = '0'
AND AtopicDermEmergeControlPast5YearsF2FEncounterCount >=2
AND AtopicDermEmergeControlExclusionMedications = '0'
AND AtopicDermEmergeControlExclusionCodes = '0';                         


END //
DELIMITER ;