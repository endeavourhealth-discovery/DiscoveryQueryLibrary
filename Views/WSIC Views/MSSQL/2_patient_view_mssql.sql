USE [subscriber_pi];
GO

DROP VIEW IF EXISTS patient_view;
GO

CREATE VIEW patient_view AS 
SELECT 
      pat.id patient_id,
      dbo.get_ods(pat.registered_practice_organization_id) source_organization,
	CASE pat.date_of_death WHEN '' THEN DATEDIFF(YEAR, pat.date_of_birth, CAST(GETDATE() AS DATE)) ELSE DATEDIFF(YEAR, pat.date_of_birth, pat.date_of_death) END AS age,
      dbo.get_concept_desc(pat.gender_concept_id) sex,
      FORMAT(epoc.startregdate,'yyyymmdd') start_regdate,
      dbo.get_concept_code(epoc.registration_type_concept_id) reg_status, 
      pat.nhs_number nhsnumber, 
      pad.postcode,
      FORMAT(pat.date_of_birth,'yyyymmdd') date_of_birth, 
      epoc.usualgp,
      pat.first_names forename, 
      pat.last_name surname, 
      '' interpreter_required_flag,
      dbo.get_concept_desc(pat.ethnic_code_concept_id) ethnic_category,
      '' religion,
      '' first_language,
      '' have_carer_flag,
      '' carer_surname,
      FORMAT(pat.date_of_death,'yyyymmdd') date_of_death, 
      FORMAT(epoc.endregdate,'yyyymmdd') end_reg_date,
      dbo.get_optout_status(pat.id, pat.registered_practice_organization_id) optout_status,
      pad.address_line_1,
      pad.address_line_2, 
      pad.address_line_3, 
      pad.address_line_4,
      pad.city,
	IIF(dbo.get_greatest_date(dbo.get_greatest_date(pat_evt.modified_date, pad_evt.modified_date), epoc_evt.modified_date) IS NULL, NULL, dbo.get_greatest_date(dbo.get_greatest_date(pat_evt.modified_date, pad_evt.modified_date), epoc_evt.modified_date)) last_modified_date
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
GO