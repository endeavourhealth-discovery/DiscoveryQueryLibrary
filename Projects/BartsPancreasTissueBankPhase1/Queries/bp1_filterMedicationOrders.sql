USE data_extracts;

DROP PROCEDURE IF EXISTS filterMedicationOrdersBP1;

DELIMITER //

CREATE PROCEDURE filterMedicationOrdersBP1 (
         IN snomedIds  VARCHAR(15000),
         IN filterType INT,             -- 0 earliest, 1 since filterDate
         IN filterDate DATE
)
BEGIN

        CALL createMedicationOrdersFromCohortBP1(snomedIds, filterType, filterDate );

        DROP TABLE IF EXISTS filteredMedicationsBP1;

        IF (filterType = 0) THEN
        
         -- earliest
          CREATE TABLE filteredMedicationsBP1 AS
          SELECT DISTINCT
                 mc.id,
                 mc.group_by,
                 mc.original_term,
                 mc.quantity_value,
                 mc.clinical_effective_date,
                 mc.quantity_unit,
                 mc.dmd_id
          FROM medicationsFromCohortBP1 mc
             LEFT JOIN medicationsFromCohortBP1 mcoo ON mcoo.group_by = mc.group_by
          AND (mc.clinical_effective_date > mcoo.clinical_effective_date
          OR (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))
          WHERE mcoo.group_by IS NULL;
          
        ELSE
          -- all
          
          CREATE TABLE filteredMedicationsBP1 AS
          SELECT DISTINCT
                 mc.id,
                 mc.group_by,
                 mc.original_term,
                 mc.quantity_value,
                 mc.clinical_effective_date,
                 mc.quantity_unit,
                 mc.dmd_id
          FROM medicationsFromCohortBP1 mc;

        END IF;

END//

DELIMITER ;
