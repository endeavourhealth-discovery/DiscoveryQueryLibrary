USE data_extracts;

DROP PROCEDURE IF EXISTS createObservationsFromCohortBP2;

DELIMITER //

CREATE PROCEDURE createObservationsFromCohortBP2(
    IN cat_id INT,
    IN filterType INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 all since filterDate
    IN filterDate DATE,
    IN ignoreNullValues BIT -- 1 ignore, 0 include
)
BEGIN

-- SELECT CONVERT("2017-08-29", DATE);

DROP TABLE IF EXISTS observationsFromCohortBP2;

IF (filterType = 4) THEN

     -- allSince filterDate
     CREATE TABLE observationsFromCohortBP2 AS
     SELECT DISTINCT
            o.id,
            o.patient_id,
            o.group_by,
            o.person_id,
            o.clinical_effective_date,
            o.original_code,
            o.original_term,
            o.result_value,
            o.result_value_units
     FROM cohort_bp2_observations o JOIN code_set_codes_bp2 csc ON csc.code = o.original_code AND BINARY csc.code = o.original_code AND csc.cat_id = cat_id
     WHERE o.clinical_effective_date > filterDate;

ELSE
     -- latest or earliest or ever (so all observations)

   CREATE TABLE observationsFromCohortBP2 AS
     SELECT DISTINCT
            o.id,
            o.patient_id,
            o.group_by,
            o.person_id,
            o.clinical_effective_date,
            o.original_code,
            o.original_term,
            o.result_value,
            o.result_value_units
     FROM cohort_bp2_observations o JOIN code_set_codes_bp2 csc ON csc.code = o.original_code AND BINARY csc.code = o.original_code AND csc.cat_id = cat_id;

END IF;

IF (ignoreNullValues = 1) THEN

  DELETE FROM observationsFromCohortBP2 WHERE result_value_units IS NULL;

END IF;

ALTER TABLE observationsFromCohortBP2 ADD INDEX (patient_id);
ALTER TABLE observationsFromCohortBP2 ADD INDEX (group_by);
ALTER TABLE observationsFromCohortBP2 ADD INDEX (clinical_effective_date);

END//
DELIMITER ;