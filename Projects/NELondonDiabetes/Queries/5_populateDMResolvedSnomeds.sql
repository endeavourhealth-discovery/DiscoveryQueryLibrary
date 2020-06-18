USE data_extracts;

DROP PROCEDURE IF EXISTS populateDMResolvedSnomeds;

DELIMITER //

CREATE PROCEDURE populateDMResolvedSnomeds()

BEGIN

INSERT INTO snomed_codes (GROUP_ID, SNOMED_ID, DESCRIPTION)
VALUES 
(9,315051004,'Diabetes resolved');

END//
DELIMITER ;
