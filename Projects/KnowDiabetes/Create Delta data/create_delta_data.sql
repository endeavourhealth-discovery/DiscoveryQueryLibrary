
-- delete random patients from the cohort to fake new patients being added
delete from data_extracts.subscriber_cohort where rand() < 0.025;

-- add 3 fake patients to the cohort to fake the removal of patients from a cohort
insert ignore into data_extracts.subscriber_cohort 
select 1, round((rand() * (20000 - 10000))+10000), 1, 0;

insert ignore into data_extracts.subscriber_cohort 
select 1, round((rand() * (20000 - 10000))+10000), 1, 0;

insert ignore into data_extracts.subscriber_cohort 
select 1, round((rand() * (20000 - 10000))+10000), 1, 0;


-- update random patients
update data_extracts.subscriber_cohort coh
	join subscriber_pi.patient p on p.id = coh.patientId
set p.title = p.title
where rand() < 0.1;

-- update random observations
update data_extracts.subscriber_cohort coh
	join subscriber_pi.observation o on o.patient_id = coh.patientId
	join subscriber_pi.concept_map cm on cm.legacy = o.non_core_concept_id
	join subscriber_pi.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
set o.result_value = o.result_value
where scs.codeSetId = 2
and rand() < 0.1;

-- delete random observations
delete o
from data_extracts.subscriber_cohort coh
	join subscriber_pi.observation o on o.patient_id = coh.patientId
	join subscriber_pi.concept_map cm on cm.legacy = o.non_core_concept_id
	join subscriber_pi.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
where scs.codeSetId = 2
and rand() < 0.01;

-- update random allergies
update data_extracts.subscriber_cohort coh
	join subscriber_pi.allergy_intolerance ai on ai.patient_id = coh.patientId
set ai.is_review = ai.is_review
where rand() < 0.1;

-- delete random allergies
delete ai 
from data_extracts.subscriber_cohort coh
	join subscriber_pi.allergy_intolerance ai on ai.patient_id = coh.patientId
where rand() < 0.01;

-- update random medications
update data_extracts.subscriber_cohort coh
	join subscriber_pi.medication_statement ms on ms.patient_id = coh.patientId
set ms.is_active = ms.is_active
where ms.is_active = 1
  and rand() < 0.1;

-- delete random medications
delete ms 
from data_extracts.subscriber_cohort coh
		join subscriber_pi.medication_statement ms on ms.patient_id = coh.patientId
where ms.is_active = 1
  and rand() < 0.01;