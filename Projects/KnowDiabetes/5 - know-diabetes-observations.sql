use data_extracts;

drop procedure if exists getKnowDiabetesObservations;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesObservations()
BEGIN

drop table if exists filteredObservations;

create table filteredObservations as
	select distinct
	o.id,
	o.patient_id,
	c.code as snomed_code,
	c.name as original_term,
	o.result_value,
	o.clinical_effective_date,
	o.result_value_units
    from cohort coh
	join subscriber_pi.observation o on o.patient_id = coh.patient_id
	join subscriber_pi.concept_map cm on cm.legacy = o.non_core_concept_id
	join subscriber_pi.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
    where scs.codeSetId = 2;         
         
END//
DELIMITER ;