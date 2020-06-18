use data_extracts;

drop procedure if exists cleanBHRChildImmsReport;

DELIMITER //
CREATE PROCEDURE cleanBHRChildImmsReport()
BEGIN

  alter table data_extracts.bhr_codes drop column id;

END//
DELIMITER ;
