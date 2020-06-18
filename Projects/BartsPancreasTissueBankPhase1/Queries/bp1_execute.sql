USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreasBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreasBP1()
BEGIN

CALL populateEastLondonCCGCodesBP1();
-- CALL createCohortBartsPancreasBP1();
CALL buildDatasetForBartsPancreasBP1();
CALL executeBartsPancreas1BasicBP1();
CALL executeBartsPancreas2DiagnosisBP1();

-- added 26/03/2020

CALL executeBartsPancreas3SymptomsBP1();
CALL executeBartsPancreas4MedicalBP1();
CALL executeBartsPancreas5LifestyleBP1();
CALL executeBartsPancreas6PhysicalBP1();
CALL executeBartsPancreas7FamilyBP1();
CALL executeBartsPancreas8BloodTestBP1();
CALL executeBartsPancreas9UrineBP1();
CALL executeBartsPancreas10SurgicalBP1();
CALL executeBartsPancreas11MedicationsBP1();
CALL executeBartsPancreas12GenericBP1();
CALL transferFromBartsPancreasCohortBP1();


END//
DELIMITER ;
