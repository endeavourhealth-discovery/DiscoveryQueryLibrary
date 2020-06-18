CREATE DEFINER=`endeavour`@`%` PROCEDURE `createCohortKnowDiabetesDeltaQuick`()
BEGIN

DROP TEMPORARY TABLE IF EXISTS data_extracts.cohortDelta1;

CREATE TEMPORARY TABLE data_extracts.cohortDelta1 AS
SELECT DISTINCT
		   p.id AS patient_id,
		   p.date_of_birth,
       o.non_core_concept_id
FROM nwl_subscriber_pid.patient p
	   JOIN nwl_subscriber_pid.observation o ON o.patient_id = p.id
	-- JOIN nwl_subscriber_pid.concept_map cm ON cm.legacy = o.non_core_concept_id
	-- JOIN nwl_subscriber_pid.concept c ON c.dbid = cm.core
	-- JOIN data_extracts.snomed_code_set_codes scs ON scs.snomedCode = c.code
	   JOIN nwl_subscriber_pid.episode_of_care e ON e.patient_id = p.id 
	   JOIN nwl_subscriber_pid.concept eocc ON eocc.dbid = e.registration_type_concept_id 
	-- where scs.codeSetId = 1 
WHERE  TIMESTAMPDIFF(YEAR,p.date_of_birth,CURDATE()) > 17
AND eocc.code = 'R' -- currently registered
AND p.date_of_death IS NULL 
AND e.date_registered <= now() 
AND (e.date_registered_end > now() or e.date_registered_end IS NULL);
    
ALTER TABLE data_extracts.cohortDelta1
ADD INDEX ix_cohort1_patient_id (patient_id);
     
ALTER TABLE data_extracts.cohortDelta1
ADD INDEX ix_non_core_id (non_core_concept_id);
       
DROP TEMPORARY TABLE IF EXISTS data_extracts.cohortDelta2 ;

CREATE TEMPORARY TABLE data_extracts.cohortDelta2 AS
SELECT DISTINCT 
           o.patient_id, 
           o.date_of_birth, 
           cm.core 
FROM data_extracts.cohortDelta1 o JOIN nwl_subscriber_pid.concept_map cm ON cm.legacy = o.non_core_concept_id;
    
ALTER TABLE data_extracts.cohortDelta2
ADD INDEX ix_cohort2_patient_id (patient_id);
    
DROP TEMPORARY TABLE IF EXISTS data_extracts.cohortDelta3;

CREATE TEMPORARY TABLE data_extracts.cohortDelta3 AS
SELECT cm.patient_id, 
       cm.date_of_birth, 
       c.code
FROM data_extracts.cohortDelta2 cm JOIN nwl_subscriber_pid.concept c ON c.dbid = cm.core;
    
ALTER TABLE data_extracts.cohortDelta3
ADD INDEX ix_cohort3_patient_id (patient_id);
    
ALTER TABLE data_extracts.cohortDelta3
ADD INDEX ix_cohort3_code_idx (code);
    
DROP TABLE IF EXISTS data_extracts.cohortDelta;
    
CREATE TABLE data_extracts.cohortDelta AS
SELECT DISTINCT 
      c.patient_id, 
      c.date_of_birth 
FROM data_extracts.cohortDelta3 c JOIN data_extracts.snomed_code_set_codes scs ON scs.snomedCode = c.code
WHERE scs.codeSetId = 1; 

ALTER TABLE data_extracts.cohortDelta
ADD INDEX ix_cohort_patient_id (patient_id);

    insert ignore into data_extracts.subscriber_cohort
    select 1, patient_id, 0, 0 from cohortDelta;
    
    update data_extracts.subscriber_cohort sc 
    left outer join cohortDelta d on d.patient_id = sc.patientId and sc.extractId = 1
    set sc.needsDelete = 1 where d.patient_id is null;
    
	-- update the test patients as the above will try to flag the patients as needing a delete
    insert into data_extracts.subscriber_cohort (extractId, patientId, isBulked, needsDelete)
    select t.extractId, t.patientId, t.isBulked, t.needsDelete
    from subscriber_cohort_test_patients t
    where t.extractId = 1 
    on duplicate key update isBulked = t.isBulked, needsDelete = t.needsDelete;
    
	drop table if exists data_extracts.cohortDelta;
END