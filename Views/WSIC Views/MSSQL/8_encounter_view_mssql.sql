USE [subscriber_pi];
GO

DROP VIEW IF EXISTS encounter_view;
GO

CREATE VIEW encounter_view AS
SELECT
      enc.id encounter_id, 
      dbo.get_ods(enc.organization_id) source_organization, 
      pat.nhs_number,
	FORMAT(enc.clinical_effective_date, 'yyyymmdd hh:mm:ss') encounter_startdate, 
      FORMAT(enc.end_date, 'yyyymmdd hh:mm:ss') encounter_enddate, 
      dbo.get_concept_desc(enc.non_core_concept_id) original_type, 
      prac.role_desc hcp_role,
      enc.type encounter_type, 
      '' recorded_date,
      '' parent_encounter,
      dbo.get_ods(enc.service_provider_organization_id) event_organization, 
      enc.appointment_id appointment_slot_id, 
      '' location,
      '' ward,
      IIF(dbo.get_greatest_date(enc_evt.modified_date, prac_evt.modified_date) IS NULL, NULL, dbo.get_greatest_date(enc_evt.modified_date, prac_evt.modified_date)) last_modified_date
FROM encounter enc JOIN patient pat ON enc.patient_id = pat.id
LEFT JOIN practitioner prac ON prac.id = enc.practitioner_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 5
           GROUP BY etlg.table_id, etlg.record_id) enc_evt ON enc_evt.record_id = enc.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 13
           GROUP BY etlg.table_id, etlg.record_id) prac_evt ON prac_evt.record_id = prac.id;
GO
