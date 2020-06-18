USE data_extracts;

-- -- ahui 5/2/2020

DROP PROCEDURE IF EXISTS populateCodeDateValueUnitWithObservationAlreadyPopulatedV2;

DELIMITER //
CREATE PROCEDURE populateCodeDateValueUnitWithObservationAlreadyPopulatedV2 (
    IN col             VARCHAR(50),
    IN datasetTable    VARCHAR(50),
    IN reset bit -- 1 reset, 0 no reset
)
BEGIN

-- reset columns

IF (reset = 1) THEN

   SET @reset_sql = CONCAT('UPDATE ', datasetTable, ' SET ',
   col, "Code = null, ",
   col, "Term = null, ",
   col, "Unit = null, ",
   col, "Value = null, ",
   col, "Date = null" );

   PREPARE resetStmt FROM @reset_sql;
   EXECUTE resetStmt;
   DEALLOCATE PREPARE resetStmt;

END IF;

  DROP TEMPORARY TABLE IF EXISTS qry_tmp;

  CREATE TEMPORARY TABLE qry_tmp (
       row_id                  INT,
       group_by                VARCHAR(255),
       original_code           VARCHAR(20),
       original_term           VARCHAR(200),
       result_value_units      VARCHAR(50),
       result_value            DOUBLE,
       clinical_effective_date DATE, PRIMARY KEY(row_id)
  ) AS
  SELECT (@row_no := @row_no+1) AS row_id,
          f.group_by,
          f.original_code,
          f.original_term,
          f.result_value_units,
          f.result_value,
          f.clinical_effective_date 
  FROM  filteredObservationsV2 f, (SELECT @row_no := 0) t;

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

   SET @sql = CONCAT('UPDATE ', datasetTable, ' d JOIN qry_tmp f ON d.pseudo_id = f.group_by SET ',
   col, "Code = f.original_code, ",
   col, "Term = f.original_term, ",
   col, "Unit = f.result_value_units, ",
   col, "Value = f.result_value, ",
   col, "Date = date_format(f.clinical_effective_date, '%d/%m/%Y') WHERE f.row_id > @row_id AND f.row_id <= @row_id + 1000");

   PREPARE stmt FROM @sql;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;

   SET @row_id = @row_id + 1000;

END WHILE;

END//
DELIMITER ;