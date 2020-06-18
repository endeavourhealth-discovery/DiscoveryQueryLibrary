USE data_extracts;

-- ahui 11/2/2020

DROP PROCEDURE IF EXISTS gh2execute13;

DELIMITER //
CREATE PROCEDURE gh2execute13()
BEGIN

-- Asthma emerge CaseControl

DROP TABLE IF EXISTS gh2_asthmaEmergeDataset;

CREATE TABLE gh2_asthmaEmergeDataset (
   pseudo_id                                 VARCHAR(255),
   pseudo_nhsnumber                          VARCHAR(255),
   AsthmaEmergeCASEInclusionCodes            VARCHAR(1) DEFAULT '0',
   AsthmaEmergeCASEInclusionCodeCOUNT        INT DEFAULT 0,
   AsthmaResolvedCode                        VARCHAR(1) DEFAULT '0',
   AsthmaEmergeMedications                   VARCHAR(1) DEFAULT '0',
   AsthmaEmergeCASEExclusionCodes            VARCHAR(1) DEFAULT '0',
   AsthmaEmergeCASEStratificationCodesAtopy  VARCHAR(1) DEFAULT '0',
   AsthmaEmergeCONTROLExclusionCodes         VARCHAR(1) DEFAULT '0',
   AsthmaEmergeCases                         VARCHAR(1) DEFAULT '0',
   AsthmaEmergeControls                      VARCHAR(1) DEFAULT '0'
);

ALTER TABLE gh2_asthmaEmergeDataset ADD INDEX asthmaEmerge_pseudo_idx(pseudo_id);

INSERT INTO gh2_asthmaEmergeDataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_gh2;

CALL populateCaseControlV2('AsthmaEmergeCASEInclusionCodes','gh2_asthmaEmergeDataset','195967001',null,'57607007',null,1);

-- AsthmaEmergeCASEInclusionCodeCOUNT  starts

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds
CALL storeSnomedString ('195967001', 1);   -- snomed to include
CALL getAllSnomedsFromSnomedString (1);

CALL storeSnomedString ('57607007', 3);   -- snomed to exclude
CALL getAllSnomedsFromSnomedString (3);

DROP TEMPORARY TABLE IF EXISTS gh2_snomeds_tmp;

CREATE TEMPORARY TABLE gh2_snomeds_tmp AS
SELECT cat_id, snomed_id
FROM gh2_snomeds 
WHERE cat_id IN (3, 4);

DELETE t1 FROM gh2_snomeds t1 JOIN gh2_snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1, 2);

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
     row_id          INT,
     group_by        VARCHAR(255),
     includeCount    INT, PRIMARY KEY (row_id)
) AS
SELECT  (@row_no := @row_no + 1) AS row_id,
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

   UPDATE gh2_asthmaEmergeDataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by
   SET d.AsthmaEmergeCASEInclusionCodeCOUNT = q.includeCount WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000;

   SET @row_id = @row_id + 1000;

END WHILE;

-- AsthmaEmergeCASEInclusionCodeCOUNT  ends

CALL populateCaseControlV2('AsthmaResolvedCode','gh2_asthmaEmergeDataset','162660004',null,null,null,1);

CALL populateCaseControlV2('AsthmaEmergeMedications','gh2_asthmaEmergeDataset','10312003,349354003,1389007,108632003,75203002,416739001,91143003,45311002,108605008,386171009,349923005,66493003,55867006,320883008,108627004,4161311000001109,35926611000001105,35926711000001101,13801911000001104,407730002,763652003,406442003,31201911000001104,33999711000001105,108614003,386180009',null,'349361004,432681009,350386006,11880411000001105,13229101000001104,34855311000001107,20121811000001105,16072611000001102,22053511000001109,29731511000001103,350438003,350437008,13229401000001105,13229501000001109,21991211000001107,34955711000001102,407754007,407753001,13229701000001103,32695711000001104,32695811000001107,32695811000001107,18525411000001101,424048001,421685007,135640007,13159601000001109,35937011000001102,28279711000001100,35916011000001108,349928001,28367211000001102,34855311000001107,763710002,430684006',null,2);

CALL populateCaseControlV2('AsthmaEmergeCASEExclusionCodes','gh2_asthmaEmergeDataset','30188007,190905008,274096000,134290008,306959001,12295008,13645005,196026004,63480004,10625791000119100,54410000,37471005,69896004,80825009,66489009,253745002 ,67782005,254290004,429054002,313039003',null,null,null,1);

CALL populateCaseControlV2('AsthmaEmergeCASEStratificationCodesAtopy','gh2_asthmaEmergeDataset','389145006,609328004,160469004,61582004,191306005,26045000,37471005,24079001,40178009',null,null,null,1);

CALL populateCaseControlV2('AsthmaEmergeCONTROLExclusionCodes','gh2_asthmaEmergeDataset','195967001,92196005,92038006,254290004,30188007,190905008,29094004,17602002,11380006,80231000119105,75934005,133791000119107,85828009,61261009,111407006,191306005,26045000,274096000,83291003,697897003,59282003,26650005,29608009,5505005,86094006,47841006,232420002,195797002,83271005,61582004,36669007,23166004,84889008,18099001,2129002,60100005,302912005,75547007,126485001,201060008,233604007,55604004,442438000,13645005,196026004,63480004,10625791000119100,54410000,12295008,86157004,50963007,415126001,286964001,271503005,105901000119108,83270006,36118008,40527005,700250006,129451001,277844007,417152008,719218000,7436001,7548000,196133001,77690003,37981002,733054008,308689002,409622000,427359005,68033004,98641000119100,47597000,49483002,195708003,448739000,56689002,64766004,235714007,408335007,40178009,69896004,87119009,66489009,77480004,67782005,609328004,160469004,313039003,429054002',null,null,null,1);

UPDATE gh2_asthmaEmergeDataset  
SET   AsthmaEmergeCases = '1'
WHERE AsthmaEmergeCASEInclusionCodes = '1' 
AND   AsthmaEmergeCASEInclusionCodeCOUNT >= 2 
AND   AsthmaEmergeMedications = '1'
AND   AsthmaEmergeCASEExclusionCodes = '0';

UPDATE gh2_asthmaEmergeDataset  
SET AsthmaEmergeControls = '1' 
WHERE AsthmaEmergeCASEInclusionCodes = '0' 
AND AsthmaEmergeCONTROLExclusionCodes = '0' 
AND AsthmaEmergeMedications = '0';


END //
DELIMITER ;
