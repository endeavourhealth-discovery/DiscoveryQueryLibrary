USE data_extracts;

-- -- ahui 02/03/2020

DROP PROCEDURE IF EXISTS populateLBHSCValueDateUnitDataset;

DELIMITER //

CREATE PROCEDURE populateLBHSCValueDateUnitDataset (
    IN filterType       INT,             -- 0 earliest, 1 latest
    IN col              VARCHAR(100),    -- the root of the column name
    IN datasetTable     VARCHAR(100),    -- table name of dataset
    IN codesToAdd1      VARCHAR(5000),   -- all parents and their children
    IN codesToAdd2      VARCHAR(5000),   -- parents only
    IN codesToRemove3   VARCHAR(5000),   -- parents and their children to be excluded
    IN codesToRemove4   VARCHAR(5000),   -- just parents to be excluded
    IN includeDate      VARCHAR(1),      -- Y include date, N exclude date
    IN includeValue     VARCHAR(1),      -- Y include value, N exclude value
    IN includeUnit      VARCHAR(1),      -- Y include unit, N exclude unit
    IN includeTerm      VARCHAR(1),      -- Y include term, N exclude term
    IN resetSnomed      VARCHAR(1)       -- Y to reset snomed tables
)

BEGIN

IF (resetSnomed = 'Y') THEN

  DELETE FROM snomeds WHERE cat_id IN (1, 2, 3, 4);
  DELETE FROM store WHERE id IN (1, 2, 3, 4);


-- populate snomeds

    IF codesToAdd1 IS NOT NULL THEN
       CALL storeString (codesToAdd1, 1);
       CALL getAllSnomeds (1);
    END IF;

    IF codesToAdd2 IS NOT NULL THEN
       CALL storeString (codesToAdd2, 2);
       CALL getAllSnomeds (2);
    END IF;

    IF codesToRemove3 IS NOT NULL THEN
       CALL storeString (codesToRemove3, 3);
       CALL getAllSnomeds (3);
    END IF;

    IF codesToRemove4 IS NOT NULL THEN
       CALL storeString (codesToRemove4, 4);
       CALL getAllSnomeds (4);
    END IF;

    CREATE TEMPORARY TABLE snomeds_tmp AS
    SELECT cat_id, snomed_id
    FROM snomeds 
    WHERE cat_id IN (3,4);

    DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
    WHERE t1.cat_id IN (1,2);

    DELETE FROM snomeds WHERE cat_id IN (3,4);

    DROP TEMPORARY TABLE snomeds_tmp;

END IF;

-- create filtered observations table

CALL filterObservationsforLBHSC(filterType,'N');

-- update dataset columns

    IF (includeTerm = 'Y' AND includeDate = 'N' AND includeValue = 'N' AND includeUnit = 'N') THEN

       SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN filterObservationsforLBHSC f ON d.pseudo_id = f.group_by SET ',
       col, "Term = f.original_term");

    END IF;

    IF (includeTerm = 'N' AND includeDate = 'N' AND includeValue = 'Y' AND includeUnit = 'N') THEN

       SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN filterObservationsforLBHSC f ON d.pseudo_id = f.group_by SET ',
       col, "Value = f.result_value");

    END IF;

    IF (includeTerm = 'N' AND includeDate = 'Y' AND includeValue = 'Y' AND includeUnit = 'N') THEN

       SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN filterObservationsforLBHSC f ON d.pseudo_id = f.group_by SET ',
       col, "Value = f.result_value, ", 
       col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");
   
    END IF;

    IF (includeTerm = 'N' AND includeDate = 'Y' AND includeValue = 'Y' AND includeUnit = 'Y') THEN

       SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN filterObservationsforLBHSC f ON d.pseudo_id = f.group_by SET ',
       col, "Value = f.result_value, ", 
       col, "Unit = f.result_value_units, ", 
       col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");
   
    END IF;

   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;





END//
DELIMITER ;


 