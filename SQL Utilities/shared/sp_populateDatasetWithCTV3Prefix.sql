use data_extracts;

drop procedure if exists populateDatasetWithCTV3Prefix;

DELIMITER //

CREATE PROCEDURE populateDatasetWithCTV3Prefix (
    IN datasetTable varchar(50), -- Table name of dataset
    IN codesToAdd varchar (10000),
    IN filterType int, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 all since filterDate
    IN filterDate date,
    IN codesToRemove varchar (10000),
    IN outputType int
    -- 0 CodeName, CodeTerm, CodeDate, CodeValue
    -- 1 CodeName, CodeTerm, CodeDate
)
BEGIN

-- create temporary code set using code_set_id 212
call addCodesToCodesetCTVPrefix (212, codesToAdd, codesToRemove);

-- Fill filteredObservations based on filterType
call filterObservations(212, filterType, filterDate, 0);

-- Populate dataset table
if (outputType = 0) then
-- used by barts pancreas
	SET @sql = CONCAT('insert into ', datasetTable, " (id, pseudo_id, CodeName, CodeTerm, CodeDate, CodeValue) select f.id, f.group_by, f.original_code, f.original_term, date_format(f.clinical_effective_date, '%d/%m/%Y'), f.result_value from filteredObservations f");
else
-- used by waltham forest child imms
	SET @sql = CONCAT('insert into ', datasetTable, " (id, patient_id, CodeName, CodeTerm, CodeDate) select f.id, f.group_by, f.original_code, f.original_term, date_format(f.clinical_effective_date, '%d/%m/%Y') from filteredObservations f");
end if;

-- Clean
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

 END//
DELIMITER ;
