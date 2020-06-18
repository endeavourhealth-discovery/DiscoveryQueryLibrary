use data_extracts;

drop procedure if exists cleanEye;

DELIMITER //
CREATE PROCEDURE cleanEye ()
BEGIN

  alter table dataset_eye drop column pseudo_id;

END//
DELIMITER ;
