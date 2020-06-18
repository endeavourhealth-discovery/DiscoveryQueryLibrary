USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS encounter_view;

CREATE VIEW encounter_view AS
SELECT
      enc.id encounter_id, 
      get_ods(enc.organization_id) source_organization, 
      pat.nhs_number,
	  DATE_FORMAT(enc.clinical_effective_date,"%Y%m%d %T") encounter_startdate, 
      DATE_FORMAT(enc.end_date,"%Y%m%d %T") encounter_enddate, 
      get_concept_desc(enc.non_core_concept_id) original_type, 
      prac.role_desc hcp_role,
      enc.type encounter_type, 
      '' recorded_date,
      '' parent_encounter,
      get_ods(enc.service_provider_organization_id) event_organization, 
      enc.appointment_id appointment_slot_id, 
      '' location,
      '' ward,
      NULLIF(GREATEST(COALESCE(enc_evt.modified_date,0), COALESCE(prac_evt.modified_date,0)),0) last_modified_date
FROM encounter enc JOIN patient pat ON enc.patient_id = pat.id
LEFT JOIN practitioner prac ON prac.id = enc.practitioner_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 5
           GROUP BY etlg.table_id, etlg.record_id) enc_evt ON enc_evt.record_id = enc.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 13
           GROUP BY etlg.table_id, etlg.record_id) prac_evt ON prac_evt.record_id = prac.id;