use data_extracts;

drop procedure if exists backupEye;

DELIMITER //
CREATE PROCEDURE backupEye ()
BEGIN

  drop table if exists dataset_eye_backup;

  create table dataset_eye_backup like dataset_eye;
  insert into dataset_eye_backup select * from dataset_eye;

END//
DELIMITER ;
