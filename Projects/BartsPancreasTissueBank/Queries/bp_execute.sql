use data_extracts;

drop procedure if exists executeBartsPancreas;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas ()
BEGIN

call createCohortBartsPancreas();
call buildDatasetForBartsPancreas();
call executeBartsPancreas1Basic();
call executeBartsPancreas2Diagnosis();

END//
DELIMITER ;
