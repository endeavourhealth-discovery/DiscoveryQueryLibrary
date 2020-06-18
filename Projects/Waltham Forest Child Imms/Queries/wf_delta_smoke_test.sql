use data_extracts;

drop procedure if exists smokeTestWFDelta;

DELIMITER //
create procedure smokeTestWFDelta ()
BEGIN

	if not exists (SELECT * FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = 'data_extracts'
		AND TABLE_NAME = 'dataset_wf_delta'
		AND COLUMN_NAME = 'CodeDate') then
	SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'CodeDate doesnt exist';

	end if;

END//
DELIMITER ;
