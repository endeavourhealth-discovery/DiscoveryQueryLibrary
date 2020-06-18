use data_extracts;

drop procedure if exists createCohortForPKB;

DELIMITER //
CREATE PROCEDURE createCohortForPKB()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	drop table if exists data_extracts.cohortDelta;
    
	create table data_extracts.cohortDelta as
	
    -- find all currently registered patients who are over 17
    select distinct
		p.id as patient_id
	from nwl_subscriber_pid.patient p
	join nwl_subscriber_pid.episode_of_care e on e.patient_id = p.id 
	join nwl_subscriber_pid.concept eocc on eocc.dbid = e.registration_type_concept_id 
	where TIMESTAMPDIFF(YEAR,p.date_of_birth,CURDATE()) > 17
	    and eocc.code = 'R' -- currently registered
	and p.date_of_death IS NULL 
	and e.date_registered <= now() 
	and (e.date_registered_end > now() or e.date_registered_end IS NULL);
    
    alter table data_extracts.cohortDelta
    add index ix_cohort_patient_id (patient_id);
    
    -- insert all patients into the subscriber_cohort table if they are not there already setting the bulk flag to 0
    insert ignore into data_extracts.subscriber_cohort
    select 2, patient_id, 0, 0 from cohortDelta;
    
    -- If any patients are no longer in the cohort, set needsDelete to 1 to be handled in the deletions procedure
    update data_extracts.subscriber_cohort sc 
    left outer join data_extracts.cohortDelta d on d.patient_id = sc.patientId and sc.extractId = 2
    set sc.needsDelete = 1 where d.patient_id is null;
    
	drop table if exists data_extracts.cohortDelta;

END//
DELIMITER ;
