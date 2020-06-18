drop procedure if exists getLatestObservationsAboveAgeInYears;

DELIMITER //
CREATE PROCEDURE getLatestObservationsAboveAgeInYears (
    IN codeSetId int,
    IN ageAbove int
)
BEGIN

call createCodesetObservationTableAboveAgeInYears( codeSetId, ageAbove );

insert into dataset (observation_id, patient_id, clinical_effective_date, date_precision_id, practitioner_id, organization_id, original_code, original_term, result_value, result_value_units)
	select
  o1.id,
  o1.patient_id,
  o1.clinical_effective_date,
  o1.date_precision_id,
  o1.practitioner_id,
  o1.organization_id,
  o1.original_code,
  o1.original_term,
  o1.result_value,
  o1.result_value_units
	 from codeset_observation o1
	 left join codeset_observation o2 on o1.patient_id = o2.patient_id
	   and (o1.clinical_effective_date < o2.clinical_effective_date
		 or (o1.clinical_effective_date = o2.clinical_effective_date and o1.id < o2.id))
	 where o2.patient_id is null;

-- drop table if exists codeset_observation;

 END//
DELIMITER ;
