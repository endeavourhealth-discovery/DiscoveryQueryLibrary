USE data_extracts;

DROP PROCEDURE IF EXISTS createMedicationOrdersFromCohortBP2;

DELIMITER //
CREATE PROCEDURE createMedicationOrdersFromCohortBP2 (
    IN snomedIds VARCHAR (15000),
    IN filterType INT,
    IN filterDate DATE
)
BEGIN

DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
DELETE FROM store WHERE id IN (1,2,3,4);

CALL storeString (snomedIds, 1);   
CALL getAllBp2Snomeds (1);


DROP TABLE IF EXISTS medicationsFromCohortBP2;

IF (filterType = 0) THEN
        -- earliest
        CREATE TABLE medicationsFromCohortBP2 AS
        SELECT
               m.id,
               m.dmd_id,
               m.patient_id,
               m.group_by,
               m.person_id,
               m.original_term,
               m.clinical_effective_date,
               m.quantity_unit,
               m.quantity_value
        FROM cohort_bp2_medications m JOIN snomeds tmp ON tmp.snomed_id = m.dmd_id;

ELSEIF (filterType = 1) THEN
        -- Since filterDate
        CREATE TABLE medicationsFromCohortBP2 AS
        SELECT
                m.id,
                m.dmd_id,
                m.patient_id,
                m.group_by,
                m.person_id,
                m.original_term,
                m.clinical_effective_date,
                m.quantity_unit,
                m.quantity_value
        FROM cohort_bp2_medications m JOIN snomeds tmp ON tmp.snomed_id = m.dmd_id
        WHERE m.clinical_effective_date > filterDate;

END IF;


ALTER TABLE medicationsFromCohortBP2 ADD INDEX bp2_medpersonid_idx (person_id);
-- alter table medicationsFromCohortBP2 ADD INDEX (clinical_effective_date);

END//
DELIMITER ;
