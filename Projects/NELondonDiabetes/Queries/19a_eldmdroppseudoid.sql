USE data_extracts;

DROP PROCEDURE IF EXISTS eldmdroppseudoid;

DELIMITER //
CREATE PROCEDURE eldmdroppseudoid()
BEGIN

    ALTER TABLE el_dm_dataset DROP COLUMN PSEUDO_ID;

END
//
DELIMITER ;