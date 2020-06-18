USE [subscriber_pi];
GO

DROP VIEW IF EXISTS appointment_slot_view;
GO

CREATE VIEW appointment_slot_view AS
SELECT
      appt.id slot_id, 
      dbo.get_ods(appt.organization_id) source_origanization, 
      appt.schedule_id session_id, 
      FORMAT(appt.start_date,'yyyymmdd hh:mm:ss') start_time, 
      appt.planned_duration planned_duration, 
      appt.actual_duration actual_duration, 
      dbo.get_concept_desc(appt.appointment_status_concept_id) status, 
      FORMAT(appt.date_time_sent_in,'yyyymmdd hh:mm:ss') actual_start_time, 
      appt.patient_wait wait_time,
      FORMAT(appt.cancelled_date, 'yyyymmdd hh:mm:ss') date_cancelled,
      FORMAT(appt.date_time_left, 'yyyymmdd hh:mm:ss') time_left, 
      pat.nhs_number,
      IIF(appt_evt.modified_date IS NULL, NULL,appt_evt.modified_date) last_modified_date 
FROM appointment appt JOIN patient pat ON appt.patient_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 18
           GROUP BY etlg.table_id, etlg.record_id) appt_evt ON appt_evt.record_id = appt.id;
GO