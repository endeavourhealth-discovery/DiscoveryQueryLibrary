USE nwl_subscriber_pid;

-- create table to hold consent codes
DROP TABLE IF EXISTS consent_code;

CREATE TABLE consent_code (
STATUS        VARCHAR(10),
DESCRIPTION   VARCHAR(100),
CODE          VARCHAR(20),
TERM_CODE     VARCHAR(20),
TERM          VARCHAR(100)
);

ALTER TABLE consent_code ADD INDEX code_idx(code);

INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_93C1.','0','Refused consent for upload to local shared electronic record');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_93C3.','0','Refused consent for upload to national shar electronic rec');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9M1..','0','Informed dissent for national audit');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Nd1.','0','No consent for electronic record sharing');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Nd9.','0','Declined consent for PCT to review patient record');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9NdH.','0','Declined consent to share pt data with specified 3rd party');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9NdJ.','0','Consent withdrawn to share pt data with specified 3rd party');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9NdR.','0','Unable to consent to information sharing');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Oh5.','0','Multi-professional risk assessment declined');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Oh8.','0','Personal risk assessment declined');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R1..','0','Confidential patient data held');

INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R11.','0','Conf data - patient not to see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R12.','0','Conf data - not to be reported');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R13.','0','Conf data - staff not to see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R14.','0','Conf data - paramedics not see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R15.','0','Conf data - other Dr not see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9R1Z.','0','Confidential data NOS');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Ndo.','0','Express dissent for Summary Care Record dataset upload');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Nu0.','0','Dissent from secondary use of GP patient identifiable data');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Nu4.','0','Dissent from disclosure of personal confidential data by HSCIC');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Ndb.','0','Consent declined by person with parental responsibility');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Ndt','0','Dissent for key information summary upload');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R2_9Nd3','0','No consent for electronic record sharing');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-In','Consent Given','R2_9Nd7','0','Consent for electronic record sharing');

INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaKRy','YaniU','Ref cons upload to nat ele rec');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaJrC','YamyH','Informd dissent national audit');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaKII','YanY7','No consent for elec recor shar');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaN25','Yaq5P','Decl consnt PCT revw pt record');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaNwT','Yaqo8','Dec con shar pt data 3rd party');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaNwU','YaqoA','Cont with shar pt data 3rd pty');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaQxZ','YatSz','Unable to consent to information sharing');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaJDp','YamBv','Multi-prof risk assess decline');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaJDs','YamC0','Personal risk assess declined');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R1..','Y7ATt','Confidential patient data held');

INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R11.','Y7ATv','Conf data - patient not to see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R12.','Y7ATw','Conf data - not to be reported');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R13.','Y7ATx','Conf data - staff not to see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R14.','Y7ATy','Conf data - paramedics not see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R15.','Y7ATz','Conf data - other Dr not see');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_9R1Z.','Y7AU0','Confidential data NOS');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaaVL','YawMP','Dissent from disclosure of personal confidential data by Health and Social Care Information Centre');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaZ89','YavKM','Dissent from secondary use of GP patient identifiable data');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaXj6','YauT5','Express dissent for Summary Care Record dataset upload');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaX1u','Yatv4','Consent declined by person with parental responsibility');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaY7Y','','Dissent for key information summary upload');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaKRw','YaniQ','Ref cons uploa to loc elec rec');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-Out','Consent Refused','R3_XaQVO','','refusal for creation of electronic record');
INSERT INTO consent_code(status,description,code,term_code,term) VALUES ('Opt-In','Consent Given','R3_XaNwR','','MDG Working - Consent given to share patient data with specified 3rd party');

USE nwl_subscriber_pid;

-- filter out the observation table to the relevant consent codes
DROP VIEW IF EXISTS obs_optout_view;
         
CREATE VIEW obs_optout_view AS
SELECT 
        ob.id,
        ob.patient_id,
        ob.organization_id,
        ob.non_core_concept_id,
        ob.clinical_effective_date,
        cpt.dbid, 
        cpt.code, 
        cpt.name, 
        csc.status
FROM observation ob JOIN concept cpt ON cpt.dbid = ob.non_core_concept_id
                    JOIN consent_code csc ON cpt.id = csc.code AND cpt.id = binary csc.code;

USE nwl_subscriber_pid;

-- function to retrieve the description field on the concept table based on the concept id
DROP FUNCTION IF EXISTS get_concept_desc;

DELIMITER //
CREATE FUNCTION get_concept_desc(p_concept_id int)
RETURNS VARCHAR(400)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_description VARCHAR(400);

SELECT description INTO l_description
FROM concept cpt
WHERE cpt.dbid = p_concept_id;

RETURN l_description;

END//
DELIMITER ;


USE nwl_subscriber_pid;

-- function to retrieve the code field on the concept table based on the concept id
DROP FUNCTION IF EXISTS get_concept_code;

DELIMITER //
CREATE FUNCTION get_concept_code(p_concept_id int)
RETURNS VARCHAR(20)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_code VARCHAR(20);

SELECT code INTO l_code
FROM concept cpt
WHERE cpt.dbid = p_concept_id;

RETURN l_code;

END//
DELIMITER ;


USE nwl_subscriber_pid;

-- function to retrieve the scheme field on the concept table based on the concept id 
DROP FUNCTION IF EXISTS get_concept_scheme;

DELIMITER //
CREATE FUNCTION get_concept_scheme(p_concept_id int)
RETURNS VARCHAR(50)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_scheme VARCHAR(50);

SELECT scheme INTO l_scheme
FROM concept cpt
WHERE cpt.dbid = p_concept_id;

RETURN l_scheme;

END//
DELIMITER ;


USE nwl_subscriber_pid;

-- function to retrieve the ods code based on the organization id
DROP FUNCTION IF EXISTS get_ods;

DELIMITER //
CREATE FUNCTION get_ods(p_org_id bigint)
RETURNS VARCHAR(50)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_ods_code VARCHAR(50);

SELECT ods_code INTO l_ods_code
FROM organization org
WHERE org.id = p_org_id;

RETURN l_ods_code;

END//
DELIMITER ;

USE nwl_subscriber_pid;

-- function to retrieve the organization name based on the organization id
DROP FUNCTION IF EXISTS get_org_name;

DELIMITER //
CREATE FUNCTION get_org_name(p_org_id bigint)
RETURNS VARCHAR(255)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_org_name VARCHAR(255);

SELECT name INTO l_org_name
FROM organization org
WHERE org.id = p_org_id;

RETURN l_org_name;

END//
DELIMITER ;

USE nwl_subscriber_pid;

-- function to retrieve the patient's latest opt out status
DROP FUNCTION IF EXISTS get_optout_status;

DELIMITER //
CREATE FUNCTION get_optout_status(p_patient_id bigint, p_organization_id bigint)
RETURNS VARCHAR(1)
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_status     VARCHAR(1);
DECLARE l_patient_id bigint;
DECLARE l_organization_id bigint;

    SELECT 
          ob.patient_id,
          ob.organization_id,
          IF (ob.status = 'Opt-Out',1,IF(ob.status = 'Opt-In',null,null)) INTO l_patient_id, l_organization_id, l_status
    FROM obs_optout_view ob
    LEFT JOIN obs_optout_view ob2 ON ob2.patient_id = ob.patient_id
    AND (ob.clinical_effective_date < ob2.clinical_effective_date
    OR (ob.clinical_effective_date = ob2.clinical_effective_date AND ob.id < ob2.id))
    WHERE ob2.patient_id IS NULL  
    AND ob.patient_id = p_patient_id 
    AND ob.organization_id = p_organization_id LIMIT 1;

RETURN l_status;

END//

DELIMITER ;


USE nwl_subscriber_pid;

-- function to retrieve the event type from the decription of the concept table
DROP FUNCTION IF EXISTS get_event_type;

DELIMITER //
CREATE FUNCTION get_event_type(p_description VARCHAR(400))
RETURNS VARCHAR(50)
NOT DETERMINISTIC NO SQL
BEGIN
DECLARE l_event VARCHAR(50);

SELECT substr(p_description,instr(p_description,"(") + 1, instr(p_description,")") - instr(p_description,"(") - 1) INTO l_event;

RETURN l_event;

END//
DELIMITER ;

USE nwl_subscriber_pid;

-- function to retrieve the latest medication order issue date based on the medication statement id
DROP FUNCTION IF EXISTS get_lastest_med_issue_date;

DELIMITER //
CREATE FUNCTION get_lastest_med_issue_date (p_medication_stmt_id bigint) 
RETURNS DATE
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_date DATE;

-- get latest issue date

SELECT 
      mo.clinical_effective_date INTO l_date
FROM medication_order mo 
LEFT JOIN medication_order mo2 ON mo.medication_statement_id = mo2.medication_statement_id
    AND (mo.clinical_effective_date < mo2.clinical_effective_date
    OR (mo.clinical_effective_date = mo2.clinical_effective_date AND mo.id < mo2.id))
    WHERE mo2.medication_statement_id IS NULL  
    AND mo.medication_statement_id = p_medication_stmt_id;

RETURN l_date;

END//

DELIMITER ;


USE nwl_subscriber_pid;

-- function to retrieve the earliest medication order issue date based on the medication statement id
DROP FUNCTION IF EXISTS get_earliest_med_issue_date;

DELIMITER //
CREATE FUNCTION get_earliest_med_issue_date (p_medication_stmt_id bigint) 
RETURNS DATE
NOT DETERMINISTIC READS SQL DATA
BEGIN
DECLARE l_date DATE;

-- get earliest issue date

SELECT 
       mo.clinical_effective_date INTO l_date
FROM medication_order mo 
LEFT JOIN medication_order mo2 ON mo.medication_statement_id = mo2.medication_statement_id
    AND (mo.clinical_effective_date > mo2.clinical_effective_date
    OR (mo.clinical_effective_date = mo2.clinical_effective_date AND mo.id > mo2.id))
    WHERE mo2.medication_statement_id IS NULL  
    AND mo.medication_statement_id = p_medication_stmt_id;

RETURN l_date;

END//

DELIMITER ;


