use data_extracts;

drop procedure if exists backupBHRChildImmsWeeklyBulk;

DELIMITER //
CREATE PROCEDURE backupBHRChildImmsWeeklyBulk()
BEGIN

  drop table if exists bhr_codes_weekly_backup;
  create table bhr_codes_weekly_backup like bhr_codes_previous;
  insert into bhr_codes_weekly_backup select * from bhr_codes_previous;

END//
DELIMITER ;
