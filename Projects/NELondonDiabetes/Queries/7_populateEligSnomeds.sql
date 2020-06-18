USE data_extracts;

DROP PROCEDURE IF EXISTS populateEligSnomeds;

DELIMITER //

CREATE PROCEDURE populateEligSnomeds()

BEGIN

INSERT INTO snomed_codes (GROUP_ID, SNOMED_ID, DESCRIPTION)
VALUES
(4,237602007,'Metabolic syndrome X (disorder)'),
(4,417681008,'Diabetic patient unsuitable for digital retinal photography (finding)'),
(4,839811000000106,'Diabetic retinopathy screening declined (situation)'),
(4,408396006,'Diabetic retinopathy screening not indicated (situation)'),
(4,413122001,'Diabetic retinopathy screening refused (situation)'),
(4,371871000000101,'Eligibility permanently inactive for diabetic retinopathy screening (finding)'),
(4,371841000000107,'Eligibility temporarily inactive for diabetic retinopathy screening (finding)'),
(4,371781000000108,'Eligible for diabetic retinopathy screening (finding)'),
(4,374901000000103,'Excluded from diabetic retinopathy screening (finding)'),
(4,374691000000100,'Excluded from diabetic retinopathy screening as blind (finding)'),
(4,374631000000101,'Excluded from diabetic retinopathy screening as deceased (finding)'),
(4,374841000000109,'Excluded from diabetic retinopathy screening as learning disability (finding)'),
(4,374601000000107,'Excluded from diabetic retinopathy screening as moved away (finding)'),
(4,374781000000105,'Excluded from diabetic retinopathy screening as no current contact details (finding)'),
(4,374721000000109,'Excluded from diabetic retinopathy screening as no longer diabetic (finding)'),
(4,374871000000103,'Excluded from diabetic retinopathy screening as physical disorder (finding)'),
(4,374811000000108,'Excluded from diabetic retinopathy screening as terminal illness (finding)'),
(4,374661000000106,'Excluded from diabetic retinopathy screening as under care of ophthalmologist (finding)'),
(4,371811000000106,'Ineligible for diabetic retinopathy screening (finding)'),
(4,416075005,'On learning disability register (finding)');

END//
DELIMITER ;
