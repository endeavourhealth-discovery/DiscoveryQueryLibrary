use data_extracts;

drop procedure if exists createCohortKnowDiabetesDelta;

DELIMITER //
CREATE PROCEDURE createCohortKnowDiabetesDelta()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	drop table if exists data_extracts.cohortDelta;
    
	create table data_extracts.cohortDelta as
	-- select distinct 
	--	p.id as patient_id
	-- from nwl_subscriber_pid.patient p
	-- join nwl_subscriber_pid.observation o on o.patient_id = p.id
	-- join nwl_subscriber_pid.concept_map cm on cm.legacy = o.non_core_concept_id
	-- join nwl_subscriber_pid.concept c on c.dbid = cm.core
	-- join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
	-- where scs.codeSetId = 1;
	
    select distinct
		p.id as patient_id,
		p.date_of_birth
	from nwl_subscriber_pid.patient p
	join nwl_subscriber_pid.observation o on o.patient_id = p.id
	join nwl_subscriber_pid.concept_map cm on cm.legacy = o.non_core_concept_id
	join nwl_subscriber_pid.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
	join nwl_subscriber_pid.episode_of_care e on e.patient_id = p.id 
	join nwl_subscriber_pid.concept eocc on eocc.dbid = e.registration_type_concept_id 
	where scs.codeSetId = 1 
    and TIMESTAMPDIFF(YEAR,p.date_of_birth,CURDATE()) > 17
	    and eocc.code = 'R' -- currently registered
	and p.date_of_death IS NULL 
	and e.date_registered <= now() 
	and (e.date_registered_end > now() or e.date_registered_end IS NULL);
    
    alter table data_extracts.cohortDelta
    add index ix_cohort_patient_id (patient_id);
    
    insert ignore into data_extracts.subscriber_cohort
    select 1, patient_id, 0, 0 from cohortDelta;
    
    update data_extracts.subscriber_cohort sc 
    left outer join data_extracts.cohortDelta d on d.patient_id = sc.patientId and sc.extractId = 1
    set sc.needsDelete = 1 where d.patient_id is null;
    
	-- update the test patients as the above will try to flag the patients as needing a delete
    insert into data_extracts.subscriber_cohort (extractId, patientId, isBulked, needsDelete)
    select t.extractId, t.patientId, t.isBulked, t.needsDelete
    from data_extracts.subscriber_cohort_test_patients t
    where t.extractId = 1 
    on duplicate key update isBulked = t.isBulked, needsDelete = t.needsDelete;
	
	drop table if exists data_extracts.cohortDelta;

END//
DELIMITER ;
