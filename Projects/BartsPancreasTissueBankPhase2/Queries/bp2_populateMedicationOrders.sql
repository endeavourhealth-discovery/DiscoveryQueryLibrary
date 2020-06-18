USE data_extracts;

DROP PROCEDURE IF EXISTS populateMedicationOrdersBP2;

DELIMITER //

CREATE PROCEDURE populateMedicationOrdersBP2(
    IN datasetTable varchar(50), -- Table name of dataset
    IN filterType int, -- 0 earliest, 1 since date, 2 ever
    IN filterDate date,
    IN snomedIds varchar (15000)
)

BEGIN

  CALL filterMedicationOrdersBP2(snomedIds, filterType, filterDate);

  DROP TEMPORARY TABLE IF EXISTS qry_tmp;

  CREATE TEMPORARY TABLE qry_tmp (
       row_id                   INT,
       group_by                 VARCHAR(255),
       dmd_id                   VARCHAR(20),
       original_term            VARCHAR(1000),
       quantity_value           DOUBLE, 
       quantity_unit            VARCHAR(255),
       clinical_effective_date  DATE, PRIMARY KEY (row_id)
  ) AS
  SELECT (@row_no := @row_no+1) AS row_id,
         f.group_by, 
         f.dmd_id, 
         f.original_term, 
         f.quantity_value,
         f.quantity_unit,
         f.clinical_effective_date
  FROM filteredMedicationsBP2 f, (SELECT @row_no := 0) t;

  -- Populate dataset table

  SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

  SET @sql = CONCAT('INSERT INTO ', datasetTable, " (pseudo_id, Code, CodeTerm, CodeDate, CodeValue, CodeUnit) SELECT f.group_by, f.dmd_id, substring(f.original_term,1,255), DATE_FORMAT(f.clinical_effective_date, '%Y-%m-%d'),f.quantity_value,f.quantity_unit FROM qry_tmp f WHERE f.row_id > @row_id AND f.row_id <= @row_id + 1000 ");

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  SET @row_id = @row_id + 1000;

END WHILE;



END//

DELIMITER ;
