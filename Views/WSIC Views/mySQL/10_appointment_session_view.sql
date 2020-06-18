USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS appointment_session_view;

CREATE VIEW appointment_session_view AS
SELECT 
      sch.id session_id, 
      sch.name session_name,
      get_ods(sch.organization_id) source_organization,
      prac.role_desc hpc_role,
      DATE_FORMAT(sch.start_date,"%Y%m%d %T:%f") start_time,
      sch.type session_type, 
      sch.location location,
      NULLIF(GREATEST(COALESCE(sch_evt.modified_date,0), COALESCE(prac_evt.modified_date,0)),0) last_modified_date
FROM schedule sch JOIN practitioner prac ON prac.id = sch.practitioner_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 17
           GROUP BY etlg.table_id, etlg.record_id) sch_evt ON sch_evt.record_id = sch.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 13
           GROUP BY etlg.table_id, etlg.record_id) prac_evt ON prac_evt.record_id = prac.id;