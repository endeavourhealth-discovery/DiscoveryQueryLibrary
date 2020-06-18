use data_extracts;

drop procedure if exists backupBHRChildImmsBulk;

DELIMITER //
CREATE PROCEDURE backupBHRChildImmsBulk()
BEGIN

  drop table if exists dataset_bhr_previous_backup;

  create table dataset_bhr_previous_backup like dataset_bhr_previous;
  insert into dataset_bhr_previous_backup select * from dataset_bhr_previous;

END//
DELIMITER ;
