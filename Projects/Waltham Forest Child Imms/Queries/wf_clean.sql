use data_extracts;

drop procedure if exists cleanWFChildImms;

DELIMITER //
CREATE PROCEDURE cleanWFChildImms ()
BEGIN

  alter table dataset_wf drop column patient_id;
  alter table dataset_wf drop column id;
  alter table dataset_wf drop column hash;

END//
DELIMITER ;
