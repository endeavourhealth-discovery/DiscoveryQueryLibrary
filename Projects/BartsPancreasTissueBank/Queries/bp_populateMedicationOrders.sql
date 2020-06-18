use data_extracts;

drop procedure if exists populateMedicationOrders;

DELIMITER //

CREATE PROCEDURE populateMedicationOrders (
    IN datasetTable varchar(50), -- Table name of dataset
    IN filterType int, -- 0 earliest, 1 since date, 2 ever
    IN filterDate date,
    IN snomedIds varchar (15000)
)

BEGIN

  call filterMedicationOrders( snomedIds, filterType, filterDate );

  -- Populate dataset table
  SET @sql = CONCAT('insert into ', datasetTable, " (id, pseudo_id, CodeName, CodeTerm, CodeDate) select f.id, f.group_by, f.dmd_id, f.original_term, date_format(f.clinical_effective_date, '%d/%m/%Y') from filteredMedications f");

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

END//

DELIMITER ;
