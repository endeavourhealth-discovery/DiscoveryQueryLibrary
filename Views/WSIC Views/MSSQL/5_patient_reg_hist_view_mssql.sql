USE [subscriber_pi];
GO 

DROP VIEW IF EXISTS patient_reg_hist_view;
GO

CREATE VIEW patient_reg_hist_view AS 
SELECT 
      dbo.get_ods(epoc.organization_id) source_origanization, 
      pat.nhs_number,
      dbo.get_concept_code(epoc.registration_status_concept_id) reg_status, 
      dbo.get_concept_desc(epoc.registration_status_concept_id) reg_status_desc, 
      dbo.get_concept_code(epoc.registration_type_concept_id) registration_type, 
      dbo.get_concept_desc(epoc.registration_type_concept_id) registration_type_desc, 
      FORMAT(epoc.date_registered,'yyyymmdd') date_registered, 
      FORMAT(epoc.date_registered_end,'yyyymmdd') date_registered_end,
      epoc.id sequence_number,
      IIF(epoc_evt.modified_date IS NULL, NULL, epoc_evt.modified_date) last_modified_date 
FROM episode_of_care epoc JOIN patient pat ON epoc.patient_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 6
           GROUP BY etlg.table_id, etlg.record_id) epoc_evt ON epoc_evt.record_id = epoc.id;
GO