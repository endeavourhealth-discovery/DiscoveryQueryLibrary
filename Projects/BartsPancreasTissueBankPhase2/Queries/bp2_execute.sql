USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreasBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreasBP2()
BEGIN

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

CALL populateEastLondonCCGCodesBP2();
-- CALL createCohortBartsPancreasBP2();
CALL buildDatasetForBartsPancreasBP2();

CALL executeBartsPancreas1BasicBP2();
CALL executeBartsPancreas2DiagnosisBP2();

CALL executeBartsPancreas3SymptomsBP2();
CALL executeBartsPancreas4MedicalBP2();
CALL executeBartsPancreas5LifestyleBP2();
CALL executeBartsPancreas6PhysicalBP2();
CALL executeBartsPancreas7FamilyBP2();
CALL executeBartsPancreas8BloodTestBP2();
CALL executeBartsPancreas9UrineBP2();
CALL executeBartsPancreas10SurgicalBP2();
CALL executeBartsPancreas11MedicationsBP2();
CALL executeBartsPancreas12GenericBP2();

CALL transferFromBartsPancreasCohortBP2();


END//
DELIMITER ;
