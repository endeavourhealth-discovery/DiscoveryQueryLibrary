USE data_extracts;

DROP PROCEDURE IF EXISTS filterObservationsBP1;

DELIMITER //
CREATE PROCEDURE filterObservationsBP1 (
        IN codeSetId int,
        IN filterType int, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 allSince
        IN filterDate date,
        IN ignoreNullValues bit -- 1 ignore, 0 include
)
BEGIN

CALL createObservationsFromCohortBP1( codeSetId, filterType, filterDate, ignoreNullValues );

DROP TABLE IF EXISTS filteredObservationsBP1;

IF (filterType = 0) THEN
    -- earliest
   CREATE TABLE filteredObservationsBP1 AS
   SELECT DISTINCT
          mc.id,
          mc.group_by,
          mc.original_code,
          mc.original_term,
          mc.result_value,
          mc.clinical_effective_date,
          mc.result_value_units
   FROM observationsFromcohortBP1 mc
        LEFT JOIN observationsFromcohortBP1 mcoo on mcoo.group_by = mc.group_by
        AND (mc.clinical_effective_date > mcoo.clinical_effective_date
        OR (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))
   WHERE mcoo.group_by IS NULL;
   
ELSEIF (filterType = 2 or filterType = 4) THEN
  -- ever or allSince
  
    CREATE TABLE filteredObservationsBP1 AS
    SELECT DISTINCT
           mc.id,
           mc.group_by,
           mc.original_code,
           mc.original_term,
           mc.result_value,
           mc.clinical_effective_date,
           mc.result_value_units
    FROM observationsFromcohortBP1 mc;

ELSEIF (filterType = 1 or filterType = 3) THEN
  -- latest or pivot (pivot uses latest, but doesn't have to be so)
        CREATE TABLE filteredObservationsBP1 AS
        SELECT DISTINCT
               mc.id,
               mc.group_by,
               mc.original_code,
               mc.original_term,
               mc.result_value,
               mc.clinical_effective_date,
               mc.result_value_units
        FROM observationsFromcohortBP1 mc
            LEFT JOIN observationsFromcohortBP1 mcoo on mcoo.group_by = mc.group_by
        AND (mc.clinical_effective_date < mcoo.clinical_effective_date
        OR (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id < mcoo.id))
        WHERE mcoo.group_by is null;

ELSE
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'filterType not recognised';
END IF;

END//
DELIMITER ;
