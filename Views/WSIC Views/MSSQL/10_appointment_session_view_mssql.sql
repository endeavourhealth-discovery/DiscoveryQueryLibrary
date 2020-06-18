USE [subscriber_pi];
GO

DROP VIEW IF EXISTS appointment_session_view;
GO

CREATE VIEW appointment_session_view AS
SELECT 
      sch.id session_id, 
      sch.name session_name,
      dbo.get_ods(sch.organization_id) source_organization,
      prac.role_desc hpc_role,
      FORMAT(sch.start_date, 'yyyymmdd hh:mm:ss.mm') start_time,
      sch.type session_type, 
      sch.location location,
      IIF(dbo.get_greatest_date(sch_evt.modified_date, prac_evt.modified_date) IS NULL, NULL, dbo.get_greatest_date(sch_evt.modified_date, prac_evt.modified_date)) last_modified_date
FROM schedule sch JOIN practitioner prac ON prac.id = sch.practitioner_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 17
           GROUP BY etlg.table_id, etlg.record_id) sch_evt ON sch_evt.record_id = sch.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 13
           GROUP BY etlg.table_id, etlg.record_id) prac_evt ON prac_evt.record_id = prac.id;
GO