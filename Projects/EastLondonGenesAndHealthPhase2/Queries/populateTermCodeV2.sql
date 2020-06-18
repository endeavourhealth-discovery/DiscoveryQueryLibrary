USE data_extracts;

-- ahui 8/2/2020

DROP PROCEDURE IF EXISTS populateTermCodeV2;

DELIMITER //

CREATE PROCEDURE populateTermCodeV2 (
    IN filterType       INT,             -- 1 latest, 0 earliest, 2 ever, 3 pivot
    IN col              VARCHAR(100),    -- the root of the column name
    IN datasetTable     VARCHAR(100),    -- table name of dataset
    IN reset            BIT,             -- 1 reset, 0 no reset
    IN codesToAdd1      VARCHAR(5000),   -- all parents and their children
    IN codesToAdd2      VARCHAR(5000),   -- parents only
    IN codesToRemove3   VARCHAR(5000),   -- parents and their children to be excluded
    IN codesToRemove4   VARCHAR(5000),    -- just parents to be excluded
    IN ignorenulls      VARCHAR(1)
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

CALL filterObservationsV2(filterType,1,ignorenulls);

-- reset columns

IF (reset = 1) THEN

   SET @reset_sql = CONCAT('UPDATE ', datasetTable, ' SET ', 
   col, "Code = null, ", 
   col, "Term = null" );

   PREPARE resetStmt FROM @reset_sql;
   EXECUTE resetStmt;
   DEALLOCATE PREPARE resetStmt;

END IF;

  DROP TEMPORARY TABLE IF EXISTS qry_tmp;

  CREATE TEMPORARY TABLE qry_tmp (
       row_id             INT,
       group_by           VARCHAR(255),
       original_code      VARCHAR(20),
       original_term      VARCHAR(1000), PRIMARY KEY(row_id)
  ) AS
  SELECT (@row_no := @row_no+1) AS row_id,
          f.group_by,
          f.original_code,
          f.original_term 
  FROM  filteredObservationsV2 f, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

   SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN qry_tmp f ON d.pseudo_id = f.group_by SET ',
   col, "Code = f.original_code, ", 
   col, "Term = f.original_term WHERE f.row_id > @row_id AND f.row_id <= @row_id + 1000");

   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;

   SET @row_id = @row_id + 1000;

END WHILE;

END//
DELIMITER ;
