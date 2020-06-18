use data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas12GenericBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas12GenericBP1()
BEGIN

-- Generic

-- group 1

INSERT INTO bp1_genericgrp1dataset (pseudo_id, nhsnumber, gender, birthdate, dateofdeath, doner_id)
SELECT DISTINCT group_by, NHSNumber, Gender, BirthDate, DateOfDeath, doner_id FROM cohort_bp1;


-- Ethnicity  

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp AS
SELECT c.group_by, 
       e.ethnic_name
FROM enterprise_pseudo.patient p 
      JOIN enterprise_pseudo.ethnicity_lookup e ON p.ethnic_code = e.ethnic_code
      JOIN cohort_bp1 c ON p.pseudo_id = c.group_by;

UPDATE bp1_genericgrp1dataset c JOIN qry_tmp eth ON c.pseudo_id = eth.group_by
SET c.Ethnicity = eth.ethnic_name;

DROP TEMPORARY TABLE IF EXISTS qry_tmp;


-- group 2

INSERT INTO bp1_genericgrp2dataset (pseudo_id, nhsnumber, appointmentdate, appointmentstatus)
SELECT DISTINCT 
       c.group_by,
       c.NHSNumber,
       a.start_date,
       a.value
FROM cohort_bp1 c 
JOIN enterprise_pseudo.patient p ON p.pseudo_id = c.group_by
JOIN enterprise_pseudo.organization org ON p.organization_id = org.id
JOIN (SELECT apt.patient_id, 
             apt.organization_id,
             apt.start_date, 
             apts.value
      FROM enterprise_pseudo.appointment apt 
            JOIN enterprise_pseudo.appointment_status apts 
            ON apt.appointment_status_id = apts.id) a ON c.patient_id = a.patient_id AND p.organization_id = a.organization_id;


END//
DELIMITER ;