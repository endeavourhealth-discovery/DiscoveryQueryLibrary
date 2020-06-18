USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS appointment_slot_view;

CREATE VIEW appointment_slot_view AS
SELECT
      appt.id slot_id, 
      get_ods(appt.organization_id) source_origanization, 
      appt.schedule_id session_id, 
      DATE_FORMAT(appt.start_date,"%Y%m%d %T") start_time, 
      appt.planned_duration planned_duration, 
      appt.actual_duration actual_duration, 
      get_concept_desc(appt.appointment_status_concept_id) status, 
      DATE_FORMAT(appt.date_time_sent_in,"%Y%m%d %T") actual_start_time, 
      appt.patient_wait wait_time,
      DATE_FORMAT(appt.cancelled_date,"%Y%m%d %T") date_cancelled,
      DATE_FORMAT(appt.date_time_left,"%Y%m%d %T") time_left, 
      pat.nhs_number,
      NULLIF(COALESCE(appt_evt.modified_date,0),0)  last_modified_date 
FROM appointment appt JOIN patient pat ON appt.patient_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 18
           GROUP BY etlg.table_id, etlg.record_id) appt_evt ON appt_evt.record_id = appt.id;