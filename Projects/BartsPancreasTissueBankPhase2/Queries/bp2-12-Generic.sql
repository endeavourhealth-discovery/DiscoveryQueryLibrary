use data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas12GenericBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas12GenericBP2()
BEGIN

-- Generic

-- group 1

INSERT INTO bp2_genericgrp1dataset (pseudo_id, nhsnumber, gender, ethnicity, birthdate, dateofdeath)
SELECT DISTINCT group_by, NHSNumber, Gender, Ethnicity, BirthDate, DateOfDeath      
FROM cohort_bp2;

-- group 2

INSERT INTO bp2_genericgrp2dataset (pseudo_id, nhsnumber, appointmentdate, appointmentstatus)
SELECT DISTINCT 
       c.group_by,
       c.NHSNumber,
       a.start_date,
       a.value
FROM cohort_bp2 c 
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

