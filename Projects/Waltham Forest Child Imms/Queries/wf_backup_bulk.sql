use data_extracts;

drop procedure if exists backupWFChildImmsBulk;

DELIMITER //
CREATE PROCEDURE backupWFChildImmsBulk ()
BEGIN

  drop table if exists dataset_wf_previous_backup;

  create table dataset_wf_previous_backup like dataset_wf_previous;
  insert into dataset_wf_previous_backup select * from dataset_wf_previous;

 END//
 DELIMITER ;
