USE nwl_subscriber_pid;

DROP VIEW IF EXISTS clinical_event_view;

CREATE VIEW clinical_event_view AS
SELECT 
      ob.id event_id, 
      get_ods(ob.organization_id) source_organization, 
      ob.patient_id, 
      pat.nhs_number nhs_number,
      DATE_FORMAT(ob.clinical_effective_date,"%Y%m%d") effective_date,
      get_concept_code(ob.non_core_concept_id) original_code,
      get_concept_desc(ob.non_core_concept_id) original_term,
      get_concept_desc(get_concept_scheme(ob.non_core_concept_id)) original_code_scheme,
      ob.result_value result_value,
      CASE 
      WHEN ob.is_problem = 1 AND ob.is_review = 0 THEN 'N - New'
      WHEN ob.is_problem = 1 AND ob.is_review = 1 THEN 'F - Follow Up'
      ELSE 'O - Other'
      END AS episode_type,
      prac.role_desc hcp_role,
      enc.type encounter_type,
      '' recorded_date,
      get_concept_code(ob.core_concept_id) snomed_concept_id,
      get_concept_desc(ob.core_concept_id) snomed_term,
      ob.parent_observation_id parent_event,
      get_ods(enc.organization_id) event_location, 
      get_org_name(enc.organization_id) location_name,
      enc.appointment_id appointment_slot_id,
      get_event_type(get_concept_desc(ob.core_concept_id)) event_type,
      NULLIF(GREATEST(COALESCE(ob_evt.modified_date,0), COALESCE(ent_evt.modified_date,0),COALESCE(prac_evt.modified_date,0)),0) last_modified_date
FROM observation ob 
JOIN patient pat ON ob.patient_id = pat.id
LEFT JOIN practitioner prac ON prac.id = ob.practitioner_id
LEFT JOIN encounter enc ON enc.id = ob.encounter_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 11
           GROUP BY etlg.table_id, etlg.record_id) ob_evt ON ob_evt.record_id = ob.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 5
           GROUP BY etlg.table_id, etlg.record_id) ent_evt ON ent_evt.record_id = enc.id	
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 13
           GROUP BY etlg.table_id, etlg.record_id) prac_evt ON prac_evt.record_id = prac.id;