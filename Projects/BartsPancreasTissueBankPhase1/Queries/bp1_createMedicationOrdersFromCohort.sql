USE data_extracts;

DROP PROCEDURE IF EXISTS createMedicationOrdersFromCohortBP1;

DELIMITER //
CREATE PROCEDURE createMedicationOrdersFromCohortBP1(
    IN snomedIds    VARCHAR(15000),
    IN filterType   INT,
    IN filterDate   DATE
)
BEGIN

/* DROP TEMPORARY TABLE IF EXISTS tmp_snomedIds;

CREATE TEMPORARY TABLE tmp_snomedIds (
    snomedId bigint(20)
);
INSERT INTO tmp_snomedIds (snomedId) SELECT s.subtypeId	from rf2.sct2_transitiveclosure s WHERE find_in_set(s.supertypeId, snomedIds);
*/

DELETE FROM snomeds WHERE cat_id = 1;
DELETE FROM store WHERE id = 1;

CALL storeString (snomedIds, 1);  
CALL getAllBp1Snomeds (1);

DROP TABLE IF EXISTS medicationsFromCohortBP1;

IF (filterType = 0) THEN
     -- earliest
   CREATE TABLE medicationsFromCohortBP1 AS
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
   FROM cohort_bp1_medications m JOIN snomeds tmp ON tmp.snomed_id = m.dmd_id;
        
ELSEIF (filterType = 1) THEN
    -- Since filterDate
       
       CREATE TABLE medicationsFromCohortBP1 AS
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
       FROM cohort_bp1_medications m JOIN snomeds tmp ON tmp.snomed_id = m.dmd_id
       WHERE m.clinical_effective_date > filterDate;
END IF;


ALTER TABLE medicationsFromCohortBP1 ADD INDEX bp1_medpersonid_idx (person_id);
ALTER TABLE medicationsFromCohortBP1 ADD INDEX bp1_medgrpby_idx (group_by);
-- alter table medicationsFromCohort add index (clinical_effective_date);

END//
DELIMITER ;
