USE data_extracts;

-- ahui 8/2/2020

DROP PROCEDURE IF EXISTS populateMedicationsV2;

DELIMITER //
CREATE PROCEDURE populateMedicationsV2 (
    IN category         VARCHAR(100), 
    IN subCategory      VARCHAR(100), 
    IN class            VARCHAR(100), 
    IN datasetTable     VARCHAR(100),    -- table name of dataset
    IN codesToAdd1      VARCHAR(5000),   -- all parents and their children
    IN codesToAdd2      VARCHAR(5000),   -- parents only
    IN codesToRemove3   VARCHAR(5000),   -- parents and their children to be excluded
    IN codesToRemove4   VARCHAR(5000)    -- just parents to be excluded
)
BEGIN

-- clear out gh2_snomeds table
DELETE FROM gh2_snomeds WHERE cat_id IN (1, 2, 3, 4);
-- clear out gh2_store table
DELETE FROM gh2_store WHERE id IN (1, 2, 3, 4);

-- get snomeds

    IF codesToAdd1 IS NOT NULL THEN
       CALL storeSnomedString (codesToAdd1, 1);
       CALL getAllSnomedsFromSnomedString (1);
    END IF;

    IF codesToAdd2 IS NOT NULL THEN
       CALL storeSnomedString (codesToAdd2, 2);
       CALL getAllSnomedsFromSnomedString (2);
    END IF;

    IF codesToRemove3 IS NOT NULL THEN
       CALL storeSnomedString (codesToRemove3, 3);
       CALL getAllSnomedsFromSnomedString (3);
    END IF;

    IF codesToRemove4 IS NOT NULL THEN
       CALL storeSnomedString (codesToRemove4, 4);
       CALL getAllSnomedsFromSnomedString (4);
    END IF;

-- create medication cohort
CALL createMedicationsFromCohortV2;

-- populate dataset table
SET @sql = CONCAT('INSERT INTO ', datasetTable, '(pseudo_id, category, subcategory, class, code, binary_4month_ind, med_id) 
SELECT DISTINCT m.group_by,"',category,'" ,"', subcategory,'" ,"', class,'" , m.original_code, "0", m.id from medicationsFromCohortV2 m');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- earliest_issue_date
CALL filterMedicationsV2(0);
-- populate dataset table
SET @sql1 = CONCAT('UPDATE ', datasetTable, ' d JOIN filterMedicationsV2 m ON d.pseudo_id = m.group_by AND d.code = m.original_code AND d.med_id = m.id 
SET d.earliest_issue_date = m.clinical_effective_date, 
    d.term = m.original_term');

PREPARE stmt FROM @sql1;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- latest_issue_date
CALL filterMedicationsV2(1);
-- populate dataset table
SET @sql2 = CONCAT('UPDATE ', datasetTable, ' d JOIN filterMedicationsV2 m ON d.pseudo_id = m.group_by AND d.code = m.original_code AND d.med_id = m.id 
SET d.latest_issue_date = m.clinical_effective_date');

PREPARE stmt FROM @sql2;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- discontinued_date
CALL filterMedicationsV2(5);
-- populate dataset table
SET @sql3 = CONCAT('UPDATE ', datasetTable, ' d JOIN filterMedicationsV2 m ON d.pseudo_id = m.group_by AND d.code = m.original_code AND d.med_id = m.id 
SET d.discontinued_date = m.cancellation_date');

PREPARE stmt FROM @sql3;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- binary_4month_ind 
-- CALL filterMedicationsV2(2);
-- populate dataset table
SET @sql4 = CONCAT('UPDATE ', datasetTable, " d JOIN filterMedicationsV2 m ON d.pseudo_id = m.group_by AND d.code = m.original_code AND d.med_id = m.id 
SET d.binary_4month_ind = IF(DATE_SUB(now(), INTERVAL 4 MONTH) BETWEEN d.earliest_issue_date AND d.latest_issue_date,'1','0')");

PREPARE stmt FROM @sql4;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END//
DELIMITER ;
