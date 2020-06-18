drop procedure if exists populateCodeDateEye;

DELIMITER //
CREATE PROCEDURE populateCodeDateEye (
    IN filterType int, -- 1 latest, 0 earliest, 2 pivot
    IN col varchar(50), -- The root of the column name
    IN datasetTable varchar(50), -- Table name of dataset
    IN ignoreNullValues bit, -- 1 reset, 0 no reset
    IN codesToAdd varchar (5000),
    IN columns int, -- 0 Code/Date, 1 Code/Date/Value, 2 Code/Date/Value/Unit
    IN codesToRemove varchar (5000)
)
BEGIN

-- create temporary code set using code_set_id 212
call addCodesToCodeset (212, codesToAdd, codesToRemove);

-- Fill filteredObservations based on filterType
call filterObservations(212, filterType, null, ignoreNullValues);


-- Create code column
SET @createSql = CONCAT('ALTER TABLE ', datasetTable, ' ADD COLUMN ', col, "Code VARCHAR(100) ");
PREPARE stmt FROM @createSql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Create date column
SET @createDateSql = CONCAT('ALTER TABLE ', datasetTable, ' ADD COLUMN ', col, "Date VARCHAR(25)");
PREPARE stmt FROM @createDateSql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Unit/Value
if (columns > 0) then
  SET @createValueSql = CONCAT('ALTER TABLE ', datasetTable, ' ADD COLUMN ', col, "Value VARCHAR(25)");
  PREPARE stmt FROM @createValueSql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
end if;

if (columns > 1) then
  SET @createUnitSql = CONCAT('ALTER TABLE ', datasetTable, ' ADD COLUMN ', col, "Unit VARCHAR(25)");
  PREPARE stmt FROM @createUnitSql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
end if;


-- Update
if (columns = 0) then
  SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservations f ON d.pseudo_id = f.group_by SET ',
  col, "Code = f.original_code, ",
  col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");
end if;

if (columns =  1) then
  SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservations f ON d.pseudo_id = f.group_by SET ',
  col, "Code = f.original_code, ",
  col, "Value = f.result_value, ",
  col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");
end if;

if (columns = 2) then
  SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservations f ON d.pseudo_id = f.group_by SET ',
  col, "Code = f.original_code, ",
  col, "Value = f.result_value, ",
  col, "Unit = f.result_value_units, ",
  col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");
end if;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

 END//
DELIMITER ;
