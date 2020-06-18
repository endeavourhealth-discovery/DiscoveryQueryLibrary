drop procedure if exists clean;

DELIMITER //
CREATE PROCEDURE clean ()
BEGIN

drop table if exists cohort;
drop table if exists dataset;
drop table if exists codeset_observation;

END//
DELIMITER ;
