drop procedure if exists populateCodeDateValueUnit;

DELIMITER //
CREATE PROCEDURE populateCodeDateValueUnit (
    IN filterType int, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 allSince
    IN col varchar(50),
    IN datasetTable varchar(50),
    IN reset bit, -- 1 reset, 0 no reset
    IN codesToAdd varchar (5000),
    IN ignoreNullValues bit, -- 1 ignore, 0 include
    IN codesToRemove varchar (5000)
)
BEGIN

-- create temporary code set using unused code_set_id 201
delete from code_set_codes where code_set_id = 201;
call addCodesToCodesetFinal(201, codesToAdd);
call removeCodesFromCodesetFinal(201, codesToRemove);

-- Fill filteredObservations based on filterType
call filterObservations( 201, filterType, null, ignoreNullValues);

-- Reset
if (reset = 1) then
	SET @reset_sql = CONCAT('UPDATE ', datasetTable, ' SET ',
	col, "Code = null, ",
	col, "Unit = null, ",
	col, "Value = null, ",
	col, "Date = null");

	PREPARE resetStmt FROM @reset_sql;
	EXECUTE resetStmt;
	DEALLOCATE PREPARE resetStmt;
end if;

-- Update
SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservations f ON d.pseudo_id = f.group_by SET ',
	col, "Code = f.original_code, ",
	col, "Unit = f.result_value_units, ",
	col, "Value = f.result_value, ",
	col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

 END//
DELIMITER ;
