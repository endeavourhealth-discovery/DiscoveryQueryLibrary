USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS filterObservationsV2;

DELIMITER //
CREATE PROCEDURE filterObservationsV2 (
	IN filterType INT, -- 0 earliest, 1 latest, 2 ever, 3 pivot around cohort.pivot_date (6 months), 4 allSince
       IN toCreate   INT, --  1 to createObservationsFromCohortv2
       IN ignorenulls VARCHAR(1) -- Y or N
  )
BEGIN

IF (toCreate = 1) THEN
    call createObservationsFromCohortv2 (filterType);
END IF;

DROP TABLE IF EXISTS filteredObservationsV2;

 IF (filterType = 0) THEN -- earliest

  IF (ignorenulls = 'Y') THEN 
    
  CREATE TABLE filteredObservationsV2 as
    SELECT 
           ob.id,
           ob.group_by,
           ob.patient_id,
           ob.person_id,
           ob.original_code,
           ob.original_term,
           ob.result_value,
           ob.clinical_effective_date,
           ob.result_value_units,
           ob.age_years,
           ob.rnk
    FROM (
           SELECT o.id,
                  o.group_by,
                  o.patient_id,
                  o.person_id,
                  o.original_code,
                  o.original_term,
                  o.result_value,
                  o.clinical_effective_date,
                  o.result_value_units,
                  o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM observationsFromCohortV2 o, (SELECT @currank := 0, @curperson := 0) r
           WHERE o.result_value IS NOT NULL
           ORDER BY o.person_id, o.clinical_effective_date ASC, o.id ASC              -- earliest
         ) ob
    WHERE ob.rnk = 1;

   ELSE

  CREATE TABLE filteredObservationsV2 as
    SELECT 
           ob.id,
           ob.group_by,
           ob.patient_id,
           ob.person_id,
           ob.original_code,
           ob.original_term,
           ob.result_value,
           ob.clinical_effective_date,
           ob.result_value_units,
           ob.age_years,
           ob.rnk
    FROM (
           SELECT o.id,
                  o.group_by,
                  o.patient_id,
                  o.person_id,
                  o.original_code,
                  o.original_term,
                  o.result_value,
                  o.clinical_effective_date,
                  o.result_value_units,
                  o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM observationsFromCohortV2 o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date ASC, o.id ASC              -- earliest
         ) ob
    WHERE ob.rnk = 1;

   END IF;


 ELSEIF (filterType = 2 OR filterType = 4) THEN -- ever or allSince
  
  IF (ignorenulls = 'Y') THEN

  CREATE TABLE filteredObservationsV2 AS
    SELECT DISTINCT
        -- mc.id,
           mc.group_by,
           mc.patient_id,
           mc.person_id,
           mc.original_code,
           mc.original_term,
           mc.result_value,
           mc.clinical_effective_date,
           mc.result_value_units,
           mc.age_years
    FROM observationsFromCohortV2 mc
    WHERE mc.result_value IS NOT NULL;
  
  ELSE

  CREATE TABLE filteredObservationsV2 AS
    SELECT DISTINCT
        -- mc.id,
           mc.group_by,
           mc.patient_id,
           mc.person_id,
           mc.original_code,
           mc.original_term,
           mc.result_value,
           mc.clinical_effective_date,
           mc.result_value_units,
           mc.age_years
    FROM observationsFromCohortV2 mc;

  END IF;


 ELSEIF (filterType = 1 or filterType = 3) THEN 	-- latest or pivot (pivot uses latest, but doesn't have to be so)

 IF (ignorenulls = 'Y') THEN

  CREATE TABLE filteredObservationsV2 as
    SELECT 
            ob.id,
            ob.group_by,
            ob.patient_id,
            ob.person_id,
            ob.original_code,
            ob.original_term,
            ob.result_value,
            ob.clinical_effective_date,
            ob.result_value_units,
            ob.age_years,
            ob.rnk
    FROM (
           SELECT o.id,
                  o.group_by,
                  o.patient_id,
                  o.person_id,
                  o.original_code,
                  o.original_term,
                  o.result_value,
                  o.clinical_effective_date,
                  o.result_value_units,
                  o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM observationsFromCohortV2 o, (SELECT @currank := 0, @curperson := 0) r
           WHERE o.result_value IS NOT NULL
           ORDER BY o.person_id, o.clinical_effective_date DESC, o.id DESC              -- latest
         ) ob
    WHERE ob.rnk = 1;

 ELSE

  CREATE TABLE filteredObservationsV2 as
    SELECT 
            ob.id,
            ob.group_by,
            ob.patient_id,
            ob.person_id,
            ob.original_code,
            ob.original_term,
            ob.result_value,
            ob.clinical_effective_date,
            ob.result_value_units,
            ob.age_years,
            ob.rnk
    FROM (
           SELECT o.id,
                  o.group_by,
                  o.patient_id,
                  o.person_id,
                  o.original_code,
                  o.original_term,
                  o.result_value,
                  o.clinical_effective_date,
                  o.result_value_units,
                  o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM observationsFromCohortV2 o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date DESC, o.id DESC              -- latest
         ) ob
    WHERE ob.rnk = 1;

 END IF;


 ELSE
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'filterType not recognised';
 END IF;

END//
DELIMITER ;