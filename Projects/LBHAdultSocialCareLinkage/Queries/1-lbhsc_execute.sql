USE data_extracts;

-- ahui 10/03/2020

DROP PROCEDURE IF EXISTS lbhsc_execute;

DELIMITER //
CREATE PROCEDURE lbhsc_execute()
BEGIN

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

CALL populateEastLondonCCGCodesLBHSC();
CALL populateLsoaLookup();
CALL populateGPEncounters();
CALL populatePhoneEncounters();
CALL populateHomeEncounters();

CALL createCohortForLBHSC();
CALL createLBHSocialCareDataset();
CALL executeLBHSocialCare();

UPDATE lbhsc_dataset l JOIN cohort_lbhsc c ON c.group_by = l.pseudo_id SET l.pseudo_nhsNumber = c.group_by;

ALTER TABLE lbhsc_dataset DROP COLUMN pseudo_id;

DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS snomeds;


END//
DELIMITER ;