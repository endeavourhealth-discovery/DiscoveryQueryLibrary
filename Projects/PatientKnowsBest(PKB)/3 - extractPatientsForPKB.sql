use data_extracts;

drop procedure if exists extractPatientsForPKB;

DELIMITER //
CREATE PROCEDURE extractPatientsForPKB()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
    -- work out where we are in the event log
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date = (select dt_change from data_extracts.currentEventLogDate);

	replace into data_extracts.pkbPatients
    -- select all the patients that have been modified since we last ran an extract
	select distinct
		p.id
    from data_extracts.subscriber_cohort coh
    join nwl_subscriber_pid.patient p on p.id = coh.patientId	
	join (select distinct(record_id)
		from nwl_subscriber_pid.event_log e
		where e.table_id = 2
		and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
	)  log on log.record_id = p.id
	
    where coh.isBulked = 1
    
    union
    -- select all patients that have never been sent
    select p.id
    from data_extracts.subscriber_cohort coh
    join nwl_subscriber_pid.patient p on p.id = coh.patientId
    where coh.isBulked = 0;
         
END//
DELIMITER ;