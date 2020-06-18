USE data_extracts;

-- ahui 5/2/2020

DROP PROCEDURE IF EXISTS filterObservationsforLBHSC;

DELIMITER //
CREATE PROCEDURE filterObservationsforLBHSC (
	IN filterType INT, -- 0 earliest, 1 latest
       IN getResolved VARCHAR(1) -- Y to include
)

BEGIN

CALL createObservationsFromLBHSCCohort (filterType);

 DROP TABLE IF EXISTS filterResolvedObservationsforLBHSC;
 DROP TABLE IF EXISTS filterObservationsforLBHSC;

IF (getResolved = 'Y' AND filterType = 0 ) THEN

  CREATE TABLE filterResolvedObservationsforLBHSC as
    SELECT 
            ob.id,
            ob.group_by,
            ob.original_code,
            ob.clinical_effective_date,
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
                  -- o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM ObservationsFromLBHSCCohort o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date DESC, o.id DESC              -- latest
         ) ob
    WHERE ob.rnk = 1
    AND EXISTS (SELECT 'x' FROM gh2_snomeds s WHERE s.snomed_id = ob.original_code AND s.cat_id IN (3, 4));

  ALTER TABLE filterResolvedObservationsforLBHSC ADD INDEX grp_by_idx(group_by);

  CREATE TABLE filterObservationsforLBHSC as
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
           -- ob.age_years,
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
                  -- o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM ObservationsFromLBHSCCohort o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date ASC, o.id ASC              -- earliest
         ) ob
    WHERE ob.rnk = 1
    AND NOT EXISTS (SELECT 'x' FROM filterResolvedObservationsforLBHSC f WHERE f.group_by = ob.group_by);

    ALTER TABLE filterObservationsforLBHSC ADD INDEX grp_by_idx(group_by);

 ELSEIF (getResolved = 'N' AND filterType = 0) THEN -- earliest
    
  CREATE TABLE filterObservationsforLBHSC as
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
           -- ob.age_years,
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
                  -- o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM ObservationsFromLBHSCCohort o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date ASC, o.id ASC              -- earliest
         ) ob
    WHERE ob.rnk = 1;

 ELSEIF (getResolved = 'N' AND filterType = 1) THEN 	-- latest 

  CREATE TABLE filterObservationsforLBHSC as
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
                  -- o.age_years,
                  @currank := IF(@curperson = o.person_id, @currank + 1, 1) AS rnk,
                  @curperson := o.person_id AS cur_person
           FROM ObservationsFromLBHSCCohort o, (SELECT @currank := 0, @curperson := 0) r
           ORDER BY o.person_id, o.clinical_effective_date DESC, o.id DESC              -- latest
         ) ob
    WHERE ob.rnk = 1;

 ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'filterType not recognised';
 END IF;

END//
DELIMITER ;