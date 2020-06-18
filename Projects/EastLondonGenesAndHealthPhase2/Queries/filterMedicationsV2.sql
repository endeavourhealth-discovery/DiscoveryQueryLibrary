USE data_extracts;

-- ahui 9/2/2020

DROP PROCEDURE IF EXISTS filterMedicationsV2;

DELIMITER //
CREATE PROCEDURE filterMedicationsV2 (
    IN filterType INT  -- 0 earliest, 1 latest, 2 in past 4 months, 5 discontinued
  )
BEGIN


DROP TABLE IF EXISTS filterMedicationsV2;

 IF (filterType = 0) THEN -- earliest
    
    CREATE TABLE filterMedicationsV2 as
     SELECT
              m.id,
              m.original_code,
              m.person_id,
              m.patient_id,
              m.group_by,
              m.original_term,
              m.clinical_effective_date,
              m.rnk
      FROM  (
             SELECT med.id,
                  med.group_by,
                  med.person_id,
                  med.patient_id,
                  med.original_code,
                  med.original_term,
                  med.clinical_effective_date,
                  @currank := IF(@curperson = med.person_id AND @curdmd = med.original_code AND @curmedid = med.id, @currank + 1, 1) AS rnk,    -- per each medication
                  @curperson := med.person_id AS cur_person,
                  @curdmd := med.original_code AS cur_original_code,
                  @curmedid := med.id AS cur_med_id
             FROM medicationsFromCohortV2 med, (SELECT @currank := 0, @curperson := 0, @curdmd := 0, @curmedid := 0) r
             ORDER BY med.person_id, med.original_code, med.id ASC, med.clinical_effective_date ASC 
             ) m
     WHERE m.rnk = 1;

 ELSEIF (filterType = 1 ) THEN 	-- latest 

    CREATE TABLE filterMedicationsV2 as
     SELECT
              m.id,
              m.original_code,
              m.person_id,
              m.patient_id,
              m.group_by,
              m.original_term,
              m.clinical_effective_date,
              m.cancellation_date, -- discontinued date 
              m.rnk
      FROM  (
             SELECT med.id,
                  med.group_by,
                  med.person_id,
                  med.patient_id,
                  med.original_code,
                  med.original_term,
                  med.clinical_effective_date,
                  med.cancellation_date,
                  @currank := IF(@curperson = med.person_id AND @curdmd = med.original_code AND @curmedid = med.id, @currank + 1, 1) AS rnk,    -- per each medication
                  @curperson := med.person_id AS cur_person,
                  @curdmd := med.original_code AS cur_original_code,
                  @curmedid := med.id AS cur_med_id
             FROM medicationsFromCohortV2 med, (SELECT @currank := 0, @curperson := 0, @curdmd := 0, @curmedid := 0) r
             ORDER BY med.person_id, med.original_code, med.id DESC, med.clinical_effective_date DESC  
             ) m
     WHERE m.rnk = 1;

 ELSEIF (filterType = 5 ) THEN 	-- latest 

    CREATE TABLE filterMedicationsV2 as
     SELECT
              m.id,
              m.original_code,
              m.person_id,
              m.patient_id,
              m.group_by,
              m.original_term,
              m.clinical_effective_date,
              m.cancellation_date, -- discontinued date 
              m.rnk
      FROM  (
             SELECT med.id,
                  med.group_by,
                  med.person_id,
                  med.patient_id,
                  med.original_code,
                  med.original_term,
                  med.clinical_effective_date,
                  med.cancellation_date,
                  @currank := IF(@curperson = med.person_id AND @curdmd = med.original_code AND @curmedid = med.id, @currank + 1, 1) AS rnk,    -- per each medication
                  @curperson := med.person_id AS cur_person,
                  @curdmd := med.original_code AS cur_original_code,
                  @curmedid := med.id AS cur_med_id
             FROM medicationsFromCohortV2 med, (SELECT @currank := 0, @curperson := 0, @curdmd := 0, @curmedid := 0) r
             ORDER BY med.person_id, med.original_code, med.id DESC, med.cancellation_date IS NULL DESC, med.cancellation_date DESC    
             ) m
     WHERE m.rnk = 1;

 ELSE

  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'filterType not recognised';
  
 END IF;

END//
DELIMITER ;