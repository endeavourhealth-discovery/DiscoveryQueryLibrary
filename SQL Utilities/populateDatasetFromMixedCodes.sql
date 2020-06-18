drop procedure if exists populateDatasetFromMixedCodes;

DELIMITER //
CREATE PROCEDURE populateDatasetFromMixedCodes (
    IN filterType int, -- 0 earliest, 1 latest, 2 ever
    IN datasetTable varchar(50), -- Table name of dataset
    IN mixedCodes varchar (5000)
)
BEGIN

-- create temporary code set using unused code_set_id 212
delete from rf2.code_set_codes where code_set_id = 212;
call addMixedCodesToCodeSet (212,  mixedCodes);

-- Fill filteredObservations based on filterType
call getObservations( 212, filterType );

-- Populate dataset table
SET @sql = CONCAT('insert into ', datasetTable, " (patient_id, CodeName, CodeTerm, CodeDate) select f.patient_id, f.original_code, f.original_term, date_format(f.clinical_effective_date, '%d/%m/%Y') from filteredObservations f");

-- Clean
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

 END//
DELIMITER ;
