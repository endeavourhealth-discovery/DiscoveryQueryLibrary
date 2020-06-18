USE data_extracts;

DROP PROCEDURE IF EXISTS populateMedicationOrdersBP1;

DELIMITER //

CREATE PROCEDURE populateMedicationOrdersBP1(
    IN datasetTable VARCHAR(50), -- Table name of dataset
    IN filterType   INT, -- 0 earliest, 1 since date, 2 ever
    IN filterDate   DATE,
    IN snomedIds    VARCHAR(15000)
)

BEGIN

  CALL filterMedicationOrdersBP1(snomedIds, filterType, filterDate);

  -- Populate dataset table
  SET @sql = CONCAT('INSERT INTO ', datasetTable, " (pseudo_id, CodeName, CodeTerm, CodeDate, CodeValue, CodeUnit) SELECT DISTINCT f.group_by, f.dmd_id, substring(f.original_term,1,255), date_format(f.clinical_effective_date, '%d/%m/%Y'), f.quantity_value, f.quantity_unit FROM filteredMedicationsBP1 f");

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

END//

DELIMITER ;
