USE data_extracts;

-- -- ahui 5/2/2020

DROP PROCEDURE IF EXISTS populateCaseControlV2;

DELIMITER //

CREATE PROCEDURE populateCaseControlV2 (
    IN col              VARCHAR(100),    -- the root of the column name
    IN datasetTable     VARCHAR(100),    -- table name of dataset
    IN codesToAdd1      VARCHAR(5000),   -- all parents and their children
    IN codesToAdd2      VARCHAR(5000),   -- parents only
    IN codesToRemove3   VARCHAR(5000),   -- parents and their children to be excluded
    IN codesToRemove4   VARCHAR(5000),    -- just parents to be excluded
    IN filterType       INT              -- 1 for observation, 2 for medication
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



IF (filterType = 1) THEN

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
      row_id     INT,
      group_by   VARCHAR(255), PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id,
       o.group_by 
FROM cohort_gh2_observations o, (SELECT @row_no := 0) t 
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = o.original_code);

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

    SET @sql = CONCAT("UPDATE ", datasetTable, " d JOIN qry_tmp oc ON oc.group_by = d.pseudo_id SET d.", col,  " = '1' WHERE oc.row_id > @row_id AND oc.row_id <= @row_id + 1000");

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @row_id = @row_id + 1000; 

END WHILE;


END IF;


IF (filterType = 2) THEN

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
     row_id      INT,
     group_by    VARCHAR(255), PRIMARY KEY(row_id)
) AS
SELECT (@row_no := @row_no + 1) AS row_id,
       m.group_by 
FROM cohort_gh2_medications m, (SELECT @row_no := 0) t
WHERE EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.cat_id IN (1, 2) AND s.snomed_id = m.original_code);

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

    SET @sql = CONCAT("UPDATE ", datasetTable, " d JOIN qry_tmp mc ON mc.group_by = d.pseudo_id SET d.", col,  " = '1' WHERE mc.row_id > @row_id AND mc.row_id <= @row_id + 1000");

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @row_id = @row_id + 1000; 

END WHILE;

END IF;

END//
DELIMITER ;


 