USE data_extracts;

DROP PROCEDURE IF EXISTS createObservationsFromcohortBP1;

DELIMITER //

CREATE PROCEDURE createObservationsFromcohortBP1(
    IN codeSetId        INT,
    IN filterType       INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort_bp1.pivot_date (6 months), 4 all since filterDate
    IN filterDate       DATE,
    IN ignoreNullValues BIT -- 1 ignore, 0 include
)
BEGIN

-- SELECT CONVERT("2017-08-29", DATE);
DROP TABLE IF EXISTS observationsFromcohortBP1;



IF (filterType = 3) THEN  -- pivot over 6 months from pivot date (already set in cohort)

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
    FROM cohort_bp1_observations o
    JOIN (SELECT DISTINCT read2_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId
          UNION
          SELECT DISTINCT ctv3_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId) csc ON BINARY csc.mixed_codes = o.original_code
    WHERE o.clinical_effective_date BETWEEN DATE_SUB(cr.pivot_date, INTERVAL 6 MONTH) AND DATE_SUB(cr.pivot_date, INTERVAL -6 MONTH);

ELSEIF (filterType = 4) THEN

-- allSince filterDate
   CREATE TABLE observationsFromcohortBP1 AS
   SELECT DISTINCT
          o.id,
          o.patient_id,
          o.group_by,
          o.clinical_effective_date,
          o.original_code,
          o.original_term,
          o.result_value,
          o.result_value_units
   FROM cohort_bp1_observations o
        JOIN (SELECT DISTINCT read2_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId
              UNION
              SELECT DISTINCT ctv3_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId) csc ON BINARY csc.mixed_codes = o.original_code
   WHERE o.clinical_effective_date > filterDate;
   
ELSE
-- latest or earliest or ever (so all observations)

   CREATE TABLE observationsFromcohortBP1 AS
   SELECT DISTINCT
          o.id,
          o.patient_id,
          o.group_by,
          o.clinical_effective_date,
          o.original_code,
          o.original_term,
          o.result_value,
          o.result_value_units
   FROM cohort_bp1_observations o
     JOIN (SELECT DISTINCT read2_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId
           UNION
           SELECT DISTINCT ctv3_concept_id AS mixed_codes FROM code_set_codes csc WHERE csc.code_set_id = codeSetId) csc ON BINARY csc.mixed_codes = o.original_code;
END IF;

IF (ignoreNullValues = 1) THEN
  DELETE FROM observationsFromcohortBP1 where result_value_units IS NULL;
END IF;

ALTER TABLE observationsFromcohortBP1 ADD INDEX obs_pat_idx (patient_id);
ALTER TABLE observationsFromcohortBP1 ADD INDEX obs_grpby_idx (group_by);
-- ALTER TABLE observationsFromcohortBP1 ADD PRIMARY KEY (id);
ALTER TABLE observationsFromcohortBP1 ADD INDEX obs_cdate_idx (clinical_effective_date);

END//
DELIMITER ;
