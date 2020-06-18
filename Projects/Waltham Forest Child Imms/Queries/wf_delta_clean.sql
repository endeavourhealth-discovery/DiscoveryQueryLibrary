use data_extracts;

drop procedure if exists cleanWFDelta;

DELIMITER //
CREATE PROCEDURE cleanWFDelta ()
BEGIN

alter table dataset_wf_delta drop column patient_id;

 END//
 DELIMITER ;
