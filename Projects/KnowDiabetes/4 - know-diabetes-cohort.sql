use data_extracts;

drop procedure if exists createCohortKnowDiabetes;

DELIMITER //
CREATE PROCEDURE createCohortKnowDiabetes()
BEGIN

	drop table if exists cohort;
    
	create table cohort as
	select distinct 
		p.id as patient_id, 
		p.nhs_number, 
        p.title,
        p.first_names,
        p.last_name,
		gc.name as gender, 
		p.date_of_birth, 
		p.date_of_death, 
		pa.address_line_1,
		pa.address_line_2,
		pa.address_line_3,
		pa.address_line_4,
		pa.city,
		pa.start_date,
        pa.end_date,
        cctype.name as contact_type,
        ccuse.name as contact_use,
        pc.value as contact_value,
        p.organization_id,
        org.ods_code,
        org.name as org_name,
        org.postcode as org_postcode
	from subscriber_pi.patient p
	left outer join subscriber_pi.patient_address pa on pa.id = p.current_address_id 
    left outer join subscriber_pi.patient_contact pc on pc.patient_id = p.id
	left outer join subscriber_pi.concept ccuse on ccuse.dbid = pc.use_concept_id
	left outer join subscriber_pi.concept cctype on cctype.dbid = pc.type_concept_id
	left outer join subscriber_pi.concept gc on gc.dbid = p.gender_concept_id
	left outer join subscriber_pi.organization org on org.id = p.organization_id
	join subscriber_pi.observation o on o.patient_id = p.id
	join subscriber_pi.concept_map cm on cm.legacy = o.non_core_concept_id
	join subscriber_pi.concept c on c.dbid = cm.core
	join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
	where scs.codeSetId = 1;
    
    alter table cohort
    add index ix_cohort_patient_id (patient_id);

END//
DELIMITER ;
