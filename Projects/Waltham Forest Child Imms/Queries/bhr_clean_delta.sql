use data_extracts;

drop procedure if exists cleanBHRDelta;

DELIMITER //
CREATE PROCEDURE cleanBHRDelta ()
BEGIN

  alter table dataset_bhr_delta drop column patient_id;
  alter table dataset_bhr_delta drop column id;

END//
DELIMITER ;
