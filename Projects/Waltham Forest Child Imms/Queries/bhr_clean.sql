use data_extracts;

drop procedure if exists cleanBHRChildImmsBulk;

DELIMITER //
CREATE PROCEDURE cleanBHRChildImmsBulk ()
BEGIN

  alter table dataset_bhr drop column patient_id;
  alter table dataset_bhr drop column id;
  alter table dataset_bhr drop column hash;

END//
DELIMITER ;
