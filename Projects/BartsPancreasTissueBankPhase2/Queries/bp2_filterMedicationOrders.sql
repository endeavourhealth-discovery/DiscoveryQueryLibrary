USE data_extracts;

drop procedure if exists filterMedicationOrdersBP2;

DELIMITER //
CREATE PROCEDURE filterMedicationOrdersBP2 (
        IN snomedIds varchar (15000),
        IN filterType int, -- 0 earliest, 1 since filterDate
        IN filterDate date
)
BEGIN

     CALL createMedicationOrdersFromCohortBP2( snomedIds, filterType, filterDate );

     DROP TABLE IF EXISTS filteredMedicationsBP2;

     IF (filterType = 0) THEN
         -- earliest

         CREATE TABLE filteredMedicationsBP2 AS
         SELECT med.id,
                med.group_by,
                med.person_id,
                med.original_term,
                med.dmd_id,
                med.quantity_value,
                med.clinical_effective_date,
                med.quantity_unit,
                med.rnk
         FROM (SELECT mc.id,
                      mc.group_by,
                      mc.person_id,
                      mc.original_term,
                      mc.dmd_id,
                      mc.quantity_value,
                      mc.clinical_effective_date,
                      mc.quantity_unit,
                      @currank := IF(@curperson = mc.person_id, @currank + 1, 1) AS rnk,
                      @curperson := o.person_id AS cur_person
               FROM medicationsFromCohortBP2 mc, (SELECT @currank := 0, @curperson :=0) r
               ORDER BY mc.person_id, mc.clinical_effective_date ASC, mc.id ASC
               ) med
         WHERE med.rnk = 1;

     ELSE
          -- all
         CREATE TABLE filteredMedicationsBP2 AS
         SELECT 
                mc.id,
                mc.group_by,
                mc.person_id,
                mc.original_term,
                mc.quantity_value,
                mc.clinical_effective_date,
                mc.quantity_unit,
                mc.dmd_id
          FROM medicationsFromCohortBP2 mc;

     END IF;

END//

DELIMITER ;
