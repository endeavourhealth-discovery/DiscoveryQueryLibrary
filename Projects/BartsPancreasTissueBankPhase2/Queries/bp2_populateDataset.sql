USE data_extracts;

DROP PROCEDURE IF EXISTS populateDatasetBP2;

DELIMITER //

CREATE PROCEDURE populateDatasetBP2(
    IN datasetTable VARCHAR(50), -- Table name of dataset
    IN codesToAdd VARCHAR (5000),
    IN filterType INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 all since filterDate
    IN filterDate DATE,
    IN codesToRemove VARCHAR (5000),
    IN outputType INT
    -- 0 CodeName, CodeTerm, CodeDate, CodeValue
    -- 1 CodeName, CodeTerm, CodeDate
)
BEGIN

DELETE FROM code_set_codes_bp2 WHERE cat_id IN (1, 2);

DELETE FROM store WHERE id IN (1, 2);

-- get snomeds

    IF (codesToAdd IS NOT NULL) THEN
       CALL storeString (codesToAdd, 1);
       CALL addCodesToCodesetBP2 (1);
    END IF;
    
    IF (codesToRemove IS NOT NULL) THEN
        CALL storeString (codesToRemove, 2);
        CALL addCodesToCodesetBP2 (2);
    END IF;
    
    DROP TEMPORARY TABLE IF EXISTS code_tmp;
    
    CREATE TEMPORARY TABLE code_tmp AS
    SELECT cat_id, code
    FROM code_set_codes_bp2 
    WHERE cat_id IN (2);

    DELETE t1 FROM code_set_codes_bp2 t1 JOIN code_tmp t2 ON t1.code = t2.code
    WHERE t1.cat_id IN (1);

    DROP TEMPORARY TABLE IF EXISTS code_tmp;

-- Fill filteredObservations based on filterType

CALL filterObservationsBP2 (1, filterType, filterDate, 0);

-- Populate dataset table

DROP TEMPORARY TABLE IF EXISTS qry_tmp; 

CREATE TEMPORARY TABLE qry_tmp (
       row_id                          INT,
       group_by                        VARCHAR(255),
       original_code                   VARCHAR(20),
       original_term                   VARCHAR(1000),
       clinical_effective_date         DATE,
       result_value                    DOUBLE, 
       result_value_units              VARCHAR(50), PRIMARY KEY (row_id)
) AS
SELECT (@row_no := @row_no+1) AS row_id,
       f.group_by, 
       f.original_code, 
       f.original_term, 
       f.clinical_effective_date, 
       f.result_value,
       f.result_value_units 
FROM filteredObservationsBP2 f, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO


   SET @sql = CONCAT('INSERT INTO ', datasetTable, " (pseudo_id, Code, CodeTerm, CodeDate, CodeValue, CodeUnit) SELECT f.group_by, f.original_code, substring(f.original_term,1,255), DATE_FORMAT(f.clinical_effective_date, '%Y-%m-%d') codedate, f.result_value, f.result_value_units FROM qry_tmp f WHERE f.row_id > @row_id AND f.row_id <= @row_id + 1000 ");
   
   
   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;

   SET @row_id = @row_id + 1000;

END WHILE;

END//

DELIMITER ;


