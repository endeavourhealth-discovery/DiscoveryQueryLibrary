USE nwl_subscriber_pid;

DROP VIEW IF EXISTS prescription_view;

CREATE VIEW prescription_view AS
SELECT 
      med.id event_id, 
      get_ods(med.organization_id) source_organization, 
      med.patient_id patient_id, 
      pat.nhs_number nhs_number,
      get_concept_desc(med.authorisation_type_concept_id)  issue_type, 
      DATE_FORMAT(get_earliest_med_issue_date(med.id),"%Y%m%d") issue_date, 
      DATE_FORMAT(get_lastest_med_issue_date(med.id),"%Y%m%d") date_of_last_issue,
      DATE_FORMAT(med.clinical_effective_date,"%Y%m%d") recorded_date, 
      get_concept_code(med.core_concept_id) dmdcode,
      med.dose dosage, 
      med.quantity_value quantity, 
      med.quantity_unit quantity_unit,
      '' encounter_type,
      get_concept_desc(med.core_concept_id) dmd_description,
      '' dispensed,
      '' prescrip_location_code,
      '' prescrip_location,
      NULLIF(GREATEST(COALESCE(med_evt.modified_date,0), COALESCE(mdo_evt.modified_date,0)),0) last_modified_date
FROM medication_statement med JOIN patient pat ON med.patient_id = pat.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 10
           GROUP BY etlg.table_id, etlg.record_id) med_evt ON med_evt.record_id = med.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, mo.medication_statement_id
           FROM medication_order mo JOIN event_log etlg ON mo.id = etlg.record_id
           WHERE  etlg.table_id = 9
           GROUP BY mo.medication_statement_id) mdo_evt ON mdo_evt.medication_statement_id = med.id;