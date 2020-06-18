use data_extracts;

drop procedure if exists extractDeletionsForPKB;

DELIMITER //
CREATE PROCEDURE extractDeletionsForPKB()
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date = (select dt_change from data_extracts.currentEventLogDate);

	replace into data_extracts.pkbDeletions
    -- select all records that we have sent previously that have been deleted
	select distinct
		e.record_id, e.table_id
    from data_extracts.`references` r
    join nwl_subscriber_pid.event_log e on e.record_id = r.an_id and e.table_id = r.type_id
    where e.change_type = 2
	  and e.dt_change > @current_event_log_date and e.dt_change <= @max_event_log_date
      
	union
    
    -- select all patients that are no longer in the cohort as they need to be deleted
    select distinct
		p.id, 2
	from data_extracts.subscriber_cohort coh
    join nwl_subscriber_pid.patient p on p.id = coh.patientId
    where coh.needsDelete = 1;
	
	delete from data_extracts.subscriber_cohort where needsDelete = 1;
END//
DELIMITER ;