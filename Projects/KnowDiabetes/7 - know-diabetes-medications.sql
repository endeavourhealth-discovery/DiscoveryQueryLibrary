use data_extracts;

drop procedure if exists getKnowDiabetesMedications;

DELIMITER //
CREATE PROCEDURE getKnowDiabetesMedications()
BEGIN

	drop table if exists filteredMedications;
    
	create table filteredMedications as
		select distinct
		ms.id,
		ms.patient_id,
		ms.dose,
		ms.quantity_value,
		ms.quantity_unit,
		ms.clinical_effective_date,
		c.name as medication_name,
		c.code as snomed_code
		from cohort coh
		join subscriber_pi.medication_statement ms on ms.patient_id = coh.patient_id
		join subscriber_pi.concept_map cm on cm.legacy = ms.non_core_concept_id
		join subscriber_pi.concept c on c.dbid = cm.core
        where ms.is_active = 1;
         
END//
DELIMITER ;