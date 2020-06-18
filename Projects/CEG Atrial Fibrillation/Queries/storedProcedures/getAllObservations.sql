drop procedure if exists getAllObservations;

DELIMITER //
CREATE PROCEDURE getAllObservations (
    IN codeSetId int
)
BEGIN

insert into dataset (observation_id, patient_id, clinical_effective_date, date_precision_id, practitioner_id, organization_id, original_code, original_term, result_value, result_value_units)
	select distinct
  o.id,
  o.patient_id,
  o.clinical_effective_date,
  o.date_precision_id,
  o.practitioner_id,
  o.organization_id,
  o.original_code,
  o.original_term,
  o.result_value,
  o.result_value_units
	from ceg_compass_data.observation o
	join cohort_af c on c.patient_id = o.patient_id
	join rf2.code_set_codes r on r.read2_concept_id = o.original_code
	where ( r.code_set_id = codeSetId );

 END//
DELIMITER ;
