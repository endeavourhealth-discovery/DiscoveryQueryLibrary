USE data_extracts;

DROP PROCEDURE IF EXISTS bhrdmexecute;

DELIMITER //
CREATE PROCEDURE bhrdmexecute()
BEGIN
SET SQL_SAFE_UPDATES=0;
call BHRbuildCohortForDiabetes();
call BHRbuildDatasetForDiabetes();
SET SQL_SAFE_UPDATES=1;

END//
DELIMITER ;