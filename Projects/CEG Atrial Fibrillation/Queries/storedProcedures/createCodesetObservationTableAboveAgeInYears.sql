drop procedure if exists createCodesetObservationTableAboveAgeInYears;

DELIMITER //
CREATE PROCEDURE createCodesetObservationTableAboveAgeInYears (
    IN codeSetId int,
    IN ageAbove int
)
BEGIN

drop table if exists codeset_observation;

create table codeset_observation as
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
	join cohort c on c.patient_id = o.patient_id
    join ceg_compass_data.patient p on o.patient_id = p.id
	join rf2.code_set_codes r on r.read2_concept_id = o.original_code
	where ( r.code_set_id = codeSetId )
    and p.age_years > ageAbove;

alter table codeset_observation add index (patient_id);
alter table codeset_observation add primary key (id);
alter table codeset_observation add index (clinical_effective_date);

END//
DELIMITER ;
