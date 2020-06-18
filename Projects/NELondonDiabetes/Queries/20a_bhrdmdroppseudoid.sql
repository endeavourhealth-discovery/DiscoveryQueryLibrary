USE data_extracts;

DROP PROCEDURE IF EXISTS bhrdmdroppseudoid;

DELIMITER //
CREATE PROCEDURE bhrdmdroppseudoid()
BEGIN

    ALTER TABLE bhr_dm_dataset DROP COLUMN PSEUDO_ID;

END
//
DELIMITER ;