CREATE DEFINER=`endeavour`@`%` PROCEDURE `getKnowDiabetesObservationsDeltaQuick`()
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	set @current_event_log_date = (select transactionDate from data_extracts.subscriber_extracts where extractId = 1);
    set @max_event_log_date = (select dt_change from data_extracts.currentEventLogDate);
  DROP TEMPORARY TABLE if exists data_extracts.filteredObservationsDelta1;
	CREATE TEMPORARY TABLE data_extracts.filteredObservationsDelta1 AS
	SELECT DISTINCT 
           cm.legacy
	FROM nwl_subscriber_pid.concept_map cm JOIN nwl_subscriber_pid.concept c ON c.dbid = cm.core
	     JOIN data_extracts.snomed_code_set_codes scs ON scs.snomedCode = c.code
	WHERE scs.codeSetId = 2;
  DROP TEMPORARY TABLE if exists data_extracts.filteredObservationsDelta2;
	CREATE TEMPORARY TABLE data_extracts.filteredObservationsDelta2 AS
    SELECT DISTINCT 
           o.id, 
		   o.organization_id,
		   o.patient_id
	FROM nwl_subscriber_pid.observation o JOIN data_extracts.filteredObservationsDelta1 cm ON cm.legacy = o.non_core_concept_id
	     JOIN (SELECT DISTINCT (record_id) FROM nwl_subscriber_pid.event_log e
		         WHERE e.table_id = 11 AND e.dt_change > @current_event_log_date AND e.dt_change <= @max_event_log_date
		        ) log ON log.record_id = o.id;
	ALTER TABLE data_extracts.filteredObservationsDelta2 ADD INDEX pat_idx(patient_id);
 DROP TEMPORARY TABLE if exists data_extracts.filteredObservationsDelta3;
    CREATE TEMPORARY TABLE data_extracts.filteredObservationsDelta3 AS
    SELECT DISTINCT
	       o.id, 
		   o.organization_id,
		   o.patient_id 
	FROM nwl_subscriber_pid.observation o JOIN data_extracts.filteredObservationsDelta1 cm ON cm.legacy = o.non_core_concept_id;
    ALTER TABLE data_extracts.filteredObservationsDelta3 ADD INDEX pat_idx(patient_id);
  REPLACE INTO data_extracts.filteredObservationsDelta
  SELECT DISTINCT 
	     o.id, 
		 o.organization_id
  FROM data_extracts.subscriber_cohort coh JOIN data_extracts.filteredObservationsDelta2 o ON o.patient_id = coh.patientId
  WHERE coh.isBulked = 1
  UNION
  SELECT DISTINCT 
	     o.id, 
		 o.organization_id
  FROM data_extracts.subscriber_cohort coh JOIN data_extracts.filteredObservationsDelta3 o ON o.patient_id = coh.patientId
  WHERE coh.isBulked = 0;
END