USE data_extracts;

DROP PROCEDURE IF EXISTS populateDatasetBP1;

DELIMITER //

CREATE PROCEDURE populateDatasetBP1(
    IN datasetTable VARCHAR(50), -- Table name of dataset
    IN codesToAdd VARCHAR (5000),
    IN filterType INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 all since filterDate
    IN filterDate DATE,
    IN codesToRemove VARCHAR(5000),
    IN outputType INT
    -- 0 CodeName, CodeTerm, CodeDate, CodeValue
    -- 1 CodeName, CodeTerm, CodeDate
)
BEGIN

-- create temporary code set using code_set_id 212
CALL addCodesToCodesetBP1(212, codesToAdd, codesToRemove);

-- Fill filteredObservations based on filterType
CALL filterObservationsBP1(212, filterType, filterDate, 0);

-- Populate dataset table
IF (outputType = 0) THEN
-- used by barts pancreas
   SET @sql = CONCAT('INSERT INTO ', datasetTable, " (pseudo_id, CodeName, CodeTerm, CodeDate, CodeValue, CodeUnit) SELECT DISTINCT f.group_by, f.original_code, substring(f.original_term,1,255), date_format(f.clinical_effective_date, '%d/%m/%Y'), f.result_value, f.result_value_units FROM filteredObservationsBP1 f");
END IF;

-- Clean
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END//
DELIMITER ;
