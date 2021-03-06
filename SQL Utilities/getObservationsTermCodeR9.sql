drop procedure if exists populateTermCode;

DELIMITER //
CREATE PROCEDURE populateTermCode (
    IN filterType int, -- 1 latest, 0 earliest, 2 pivot
    IN col varchar(50), -- The root of the column name
    IN datasetTable varchar(50), -- Table name of dataset
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
	col, "Term = null");

	PREPARE resetStmt FROM @reset_sql;
	EXECUTE resetStmt;
	DEALLOCATE PREPARE resetStmt;
end if;


-- Update
SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredObservationsPseudo f ON d.pseudo_id = f.pseudo_id SET ',
col, "Code = f.original_code, ",
col, "Term = f.original_term");

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


 END//
DELIMITER ;
