use data_extracts;

drop procedure if exists getKnowDiabetesObservationsDelta;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesObservationsDelta()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date = (select dt_change from data_extracts.currentEventLogDate);

	replace into data_extracts.filteredObservationsDelta
	select distinct
		o.id, o.organization_id
    from data_extracts.subscriber_cohort coh
	join nwl_subscriber_pid.observation o on o.patient_id = coh.patientId
	join nwl_subscriber_pid.concept_map cm on cm.legacy = o.non_core_concept_id
	join nwl_subscriber_pid.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
	
    -- join (select record_id 
	-- from nwl_subscriber_pid.event_log e 
    -- where e.table_id = 11
    -- and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
    -- group by record_id) log on log.record_id = o.id
	
	join (select distinct(record_id)
		from nwl_subscriber_pid.event_log e
		where e.table_id = 11
		and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
		) log on log.record_id = o.id
			  
    where scs.codeSetId = 2
      and coh.isBulked = 1
      
	union
    
    select distinct
		o.id, o.organization_id
    from data_extracts.subscriber_cohort coh
	join nwl_subscriber_pid.observation o on o.patient_id = coh.patientId
	join nwl_subscriber_pid.concept_map cm on cm.legacy = o.non_core_concept_id
	join nwl_subscriber_pid.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
    where scs.codeSetId = 2
      and coh.isBulked = 0;
         
END//
DELIMITER ;