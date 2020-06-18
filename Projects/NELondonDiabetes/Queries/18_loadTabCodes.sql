USE data_extracts;

DROP PROCEDURE IF EXISTS loadTabCodes;

DELIMITER //
CREATE PROCEDURE loadTabCodes()
BEGIN

call createSnomedCodes();
call createELCCGsPractices();

call populateCohortSnomeds();
call populateConsentWithHeld();
call populateDMResolvedSnomeds();
call populateEligSnomeds();
call populateEthnicSnomeds();
call populateLangSnomeds();
call populatePatDeceasedSnomeds();
call populatePregCodeSnomeds();
call populatePregDelSnomeds();
call populateReqInterpSnomeds();
call populateELCCGCodes();
call populateBPSnomeds();
call populateglycSnomeds();


END//
DELIMITER ;