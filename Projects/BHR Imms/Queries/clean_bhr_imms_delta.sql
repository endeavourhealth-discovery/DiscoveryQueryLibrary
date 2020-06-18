use data_extracts;

drop procedure if exists cleanBHRChildImmsDelta;

DELIMITER //
CREATE PROCEDURE cleanBHRChildImmsDelta()
BEGIN

  alter table data_extracts.bhr_codes_delta drop column id;

END//
DELIMITER ;
