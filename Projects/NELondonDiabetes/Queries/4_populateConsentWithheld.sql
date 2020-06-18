USE data_extracts;

DROP PROCEDURE IF EXISTS populateConsentWithHeld;

DELIMITER //

CREATE PROCEDURE populateConsentWithHeld()

BEGIN

INSERT INTO snomed_codes (GROUP_ID, SNOMED_ID, DESCRIPTION)
VALUES
(2,305471000000107,'Consent to share demographic information for retinal screening withheld (finding)');

END//
DELIMITER ;
