USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS patient_reg_hist_view;

CREATE VIEW patient_reg_hist_view AS 
SELECT 
      get_ods(epoc.organization_id) source_origanization, 
      pat.nhs_number,
      get_concept_code(epoc.registration_status_concept_id) reg_status, 
      get_concept_desc(epoc.registration_status_concept_id) reg_status_desc, 
      get_concept_code(epoc.registration_type_concept_id) registration_type, 
      get_concept_desc(epoc.registration_type_concept_id) registration_type_desc, 
      DATE_FORMAT(epoc.date_registered,"%Y%m%d") date_registered, 
      DATE_FORMAT(epoc.date_registered_end,"%Y%m%d") date_registered_end,
      epoc.id sequence_number,
      NULLIF(COALESCE(epoc_evt.modified_date,0),0)  last_modified_date 
FROM episode_of_care epoc JOIN patient pat ON epoc.patient_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 6
           GROUP BY etlg.table_id, etlg.record_id) epoc_evt ON epoc_evt.record_id = epoc.id;
