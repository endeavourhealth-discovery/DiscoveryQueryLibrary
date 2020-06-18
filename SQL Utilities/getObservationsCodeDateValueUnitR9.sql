drop procedure if exists getObservationsCodeDateValueUnitR9;

DELIMITER //
CREATE PROCEDURE getObservationsCodeDateValueUnitR9 (
    IN filterType int, -- 1 latest, 0 earliest, 2 pivot
    IN col varchar(50),
    IN datasetTable varchar(50),
    IN reset bit, -- 1 reset, 0 no reset
    IN codesToAdd varchar (5000),
    IN codesToRemove varchar (5000)
)
BEGIN

-- codeset
call addCodesToCodeset(201, codesToAdd);
call removeCodesFromCodeset(201, codesToRemove);

call getObservationsPseudo( 201, filterType );

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
SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservationsPseudo f ON d.pseudo_id = f.pseudo_id SET ',
	col, "Code = f.original_code, ",
	col, "Unit = f.result_value_units, ",
	col, "Value = f.result_value, ",
	col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

 END//
DELIMITER ;
