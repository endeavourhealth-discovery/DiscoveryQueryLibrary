use data_extracts;

drop procedure if exists getKnowDiabetesPatientDelta;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesPatientDelta()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date = (select dt_change from data_extracts.currentEventLogDate);

	replace into data_extracts.filteredPatientsDelta
	select distinct
		p.id
    from data_extracts.subscriber_cohort coh
    join nwl_subscriber_pid.patient p on p.id = coh.patientId
    
	-- join (select record_id 
	-- from nwl_subscriber_pid.event_log e 
    -- where e.table_id = 2
    -- and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
    -- group by record_id) log on log.record_id = p.id
	
	join (select distinct(record_id)
		from nwl_subscriber_pid.event_log e
		where e.table_id = 2
		and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
	)  log on log.record_id = p.id
	
    where coh.isBulked = 1
    
    union
    
    select p.id
    from data_extracts.subscriber_cohort coh
    join nwl_subscriber_pid.patient p on p.id = coh.patientId
    where coh.isBulked = 0;
         
END//
DELIMITER ;