USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS patient_view;

CREATE VIEW patient_view AS 
SELECT 
      pat.id patient_id,
      get_ods(pat.registered_practice_organization_id) source_organization,
      IF (pat.date_of_death IS NULL, TIMESTAMPDIFF(YEAR,pat.date_of_birth,CURDATE()), TIMESTAMPDIFF(YEAR,pat.date_of_birth,pat.date_of_death)) age,
      get_concept_desc(pat.gender_concept_id) sex,
      DATE_FORMAT(epoc.startregdate,"%Y%m%d") start_regdate,
      get_concept_code(epoc.registration_type_concept_id)  reg_status, 
      pat.nhs_number nhsnumber, 
      pad.postcode,
      DATE_FORMAT(pat.date_of_birth,"%Y%m%d") date_of_birth, 
      epoc.usualgp,
      pat.first_names forename, 
      pat.last_name surname, 
      '' interpreter_required_flag,
      get_concept_desc(pat.ethnic_code_concept_id) ethnic_category,
      '' religion,
      '' first_language,
      '' have_carer_flag,
      '' carer_surname,
      DATE_FORMAT(pat.date_of_death,"%Y%m%d") date_of_death, 
      DATE_FORMAT(epoc.endregdate,"%Y%m%d") end_reg_date,
      get_optout_status(pat.id, pat.registered_practice_organization_id) optout_status,
      pad.address_line_1,
      pad.address_line_2, 
      pad.address_line_3, 
      pad.address_line_4,
      pad.city, 
      NULLIF(GREATEST(COALESCE(pat_evt.modified_date,0), COALESCE(pad_evt.modified_date,0),COALESCE(epoc_evt.modified_date,0)),0) last_modified_date
FROM patient pat  
LEFT JOIN patient_address pad ON pat.current_address_id = pad.id AND pat.id = pad.patient_id
LEFT JOIN 
   (SELECT  
           epc.id, 
           epc.organization_id, 
           epc.patient_id, 
           epc.registration_type_concept_id, 
           epc.registration_status_concept_id, 
           epc.date_registered startregdate, 
           epc.date_registered_end endregdate, 
           epc.usual_gp_practitioner_id,
           prac.name usualgp
    FROM episode_of_care epc LEFT JOIN practitioner prac 
    ON prac.id = epc.usual_gp_practitioner_id AND prac.organization_id = epc.organization_id) epoc 
    ON epoc.patient_id = pat.id AND epoc.organization_id = pat.registered_practice_organization_id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 2
           GROUP BY etlg.table_id, etlg.record_id) pat_evt ON pat_evt.record_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 20
           GROUP BY etlg.table_id, etlg.record_id) pad_evt ON pad_evt.record_id = pad.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 6
           GROUP BY etlg.table_id, etlg.record_id) epoc_evt ON epoc_evt.record_id = epoc.id;