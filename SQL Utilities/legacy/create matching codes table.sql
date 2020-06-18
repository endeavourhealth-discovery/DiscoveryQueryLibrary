drop procedure if exists create_matching_codes_table;

DELIMITER //
CREATE PROCEDURE create_matching_codes_table (
    IN codeSetId int
)
BEGIN

drop table if exists matching_codes;

create table matching_codes as
 select
  o.id,
  o.patient_id,
  cr.pseudo_id_from_dvh as pseudo_id,
  o.clinical_effective_date,
  o.date_precision_id,
  o.practitioner_id,
  o.organization_id,
  o.original_code,
  o.original_term,
  o.result_value,
  o.result_value_units,
  date_format(o.result_date, '%d/%m/%Y') as result_date,
  o.result_text,
  o.result_concept_id
 from rf2.elgh_cohort cr
 inner join ceg_compass_data.observation o on o.patient_id = cr.patient_id
 inner join rf2.code_set_codes csc on csc.read2_concept_id = o.original_code
where csc.code_set_id = codeSetId;


END//
DELIMITER ;
