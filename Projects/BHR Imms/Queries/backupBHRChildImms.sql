use data_extracts;

drop procedure if exists backupBHRChildImms;

DELIMITER //
CREATE PROCEDURE backupBHRChildImms()
BEGIN

  drop table if exists bhr_codes_previous_backup;
  create table bhr_codes_previous_backup like bhr_codes_previous;
  insert into bhr_codes_previous_backup select * from bhr_codes_previous;

END//
DELIMITER ;
