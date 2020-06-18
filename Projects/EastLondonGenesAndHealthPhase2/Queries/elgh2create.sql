USE data_extracts;

-- ahui 19/2/2020

DROP PROCEDURE IF EXISTS elgh2create;

DELIMITER //
CREATE PROCEDURE elgh2create()
BEGIN

SET SQL_SAFE_UPDATES=0;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
CALL createTabsForGH2();
CALL populateF2fEncounters();
CALL populateGH2CCGCodes();

CALL createCohortForELGH2();

CALL createGH2Dataset1();
CALL createGH2Dataset1a();
CALL createGH2Dataset2();
CALL createGH2Dataset2a();
CALL createGH2Dataset3();
CALL createGH2Dataset3a();
CALL createGH2Dataset4();
CALL createGH2Dataset5();
CALL createGH2DemographicsDataset();

SET SQL_SAFE_UPDATES=1;

END //
DELIMITER ;
