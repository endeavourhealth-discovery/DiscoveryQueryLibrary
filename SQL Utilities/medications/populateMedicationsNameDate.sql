drop procedure if exists populateMedicationsNameDate;

DELIMITER //
CREATE PROCEDURE populateMedicationsNameDate (
    IN col varchar(50), -- The root of the column name
    IN filterType bit, -- 1 latest, 0 earliest, 2 pivot
    IN datasetTable varchar(50), -- Table name of dataset
    IN reset bit, -- 1 reset, 0 no reset
    IN snomedIds varchar (15000)
)
BEGIN

call filterMedications( snomedIds, filterType );

-- Reset
if (reset = 1) then
	SET @reset_sql = CONCAT('UPDATE ', datasetTable, ' SET ',
	col, "Name = null, ",
	col, "Date = null");

	PREPARE resetStmt FROM @reset_sql;
	EXECUTE resetStmt;
	DEALLOCATE PREPARE resetStmt;
end if;


-- Update
SET @sql = CONCAT('UPDATE ', datasetTable, ' d join filteredMedications f ON d.pseudo_id = f.pseudo_id SET ',
col, "Name = f.original_term, ",
col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y')");

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


 END//
DELIMITER ;
