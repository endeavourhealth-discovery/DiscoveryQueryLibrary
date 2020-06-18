use data_extracts;

drop procedure if exists getKnowDiabetesAllergies;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesAllergies()
BEGIN

	drop table if exists filteredAllergies;

	create table filteredAllergies as
		select distinct
		ai.id,
		ai.patient_id,
		ai.clinical_effective_date,
		c.name as allergy_name,
		c.code as snomed_code
		from cohort coh
		join subscriber_pi.allergy_intolerance ai on ai.patient_id = coh.patient_id
		join subscriber_pi.concept_map cm on cm.legacy = ai.non_core_concept_id
		join subscriber_pi.concept c on c.dbid = cm.core;
			 
         
END//
DELIMITER ;