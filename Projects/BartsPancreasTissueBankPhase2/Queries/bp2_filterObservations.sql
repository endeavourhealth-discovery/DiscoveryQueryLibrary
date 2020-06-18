USE data_extracts;

DROP PROCEDURE IF EXISTS filterObservationsBP2;

DELIMITER //
CREATE PROCEDURE filterObservationsBP2(
       IN cat_id     INT,
       IN filterType INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 allSince
       IN filterDate DATE,
       IN ignoreNullValues BIT -- 1 ignore, 0 include
)
BEGIN

CALL createObservationsFromCohortBP2(cat_id, filterType, filterDate, ignoreNullValues );

DROP TABLE IF EXISTS filteredObservationsBP2;

IF (filterType = 0) THEN

    -- earliest

    CREATE TABLE filteredObservationsBP2 AS
    SELECT ob.id,
           ob.group_by,
           ob.person_id,
           ob.original_code,
           ob.original_term,
           ob.result_value,
           ob.clinical_effective_date,
           ob.result_value_units,
           ob.rnk
     FROM (
            SELECT o.id,
                   o.group_by,
                   o.person_id,
                   o.original_code,
                   o.original_term,
                   o.result_value,
                   o.clinical_effective_date,
                   o.result_value_units,
                   @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                   @curperson := o.person_id AS cur_person
            FROM observationsFromCohortBP2 o, (SELECT @currank := 0, @curperson := 0) r
            ORDER BY o.person_id, o.clinical_effective_date ASC, o.id ASC 
            ) ob
     WHERE ob.rnk = 1;
    
ELSEIF (filterType = 2 or filterType = 4) THEN

    -- ever or allSince
    CREATE TABLE filteredObservationsBP2 AS
    select DISTINCT
           -- o.id,
           o.group_by,
           o.person_id,
           o.original_code,
           o.original_term,
           o.result_value,
           o.clinical_effective_date,
           o.result_value_units
    FROM observationsFromCohortBP2 o;

ELSEIF (filterType = 1 or filterType = 3) THEN

    -- latest or pivot (pivot uses latest, but doesn't have to be so)

    CREATE TABLE filteredObservationsBP2 AS
    SELECT ob.id,
           ob.group_by,
           ob.person_id,
           ob.original_code,
           ob.original_term,
           ob.result_value,
           ob.clinical_effective_date,
           ob.result_value_units,
           ob.rnk
     FROM (
            SELECT o.id,
                   o.group_by,
                   o.person_id,
                   o.original_code,
                   o.original_term,
                   o.result_value,
                   o.clinical_effective_date,
                   o.result_value_units,
                   @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                   @curperson := o.person_id AS cur_person
            FROM observationsFromCohortBP2 o, (SELECT @currank := 0, @curperson := 0) r
            ORDER BY o.person_id, o.clinical_effective_date DESC, o.id DESC 
            ) ob
     WHERE ob.rnk = 1;
        
ELSE

  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'filterType not recognised';
 
END IF;


END//
DELIMITER ;
