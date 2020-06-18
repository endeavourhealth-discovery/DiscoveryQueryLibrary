drop table if exists cohort_af;
-- Insert AF
create table cohort_af as
	select distinct(o.patient_id) from ceg_compass_data.observation o
	join ceg_compass_data.organization org on org.id = o.organization_id
	join rf2.code_set_codes r on r.read2_concept_id = o.original_code
    join ceg_compass_data.episode_of_care e on e.patient_id = o.patient_id
    join ceg_compass_data.patient p on p.id = o.patient_id
	where org.parent_organization_id in (2, 251340514, 306924583, 1268492093, 721322892, 1083463, 93721724, 303221, 28025907)
	and r.code_set_id = 9
    and p.date_of_death IS NULL
	and e.registration_type_id = 2
	and e.date_registered <= now()
	and (e.date_registered_end > now() or e.date_registered_end IS NULL);
-- Remove AF Resolve
delete from cohort_af where patient_id in (
	select distinct(o.patient_id) from ceg_compass_data.observation o
	join ceg_compass_data.organization org on org.id = o.organization_id
	join rf2.code_set_codes r on r.read2_concept_id = o.original_code
    where org.parent_organization_id in (2, 251340514, 306924583, 1268492093, 721322892, 1083463, 93721724, 303221, 28025907)
	and r.code_set_id = 10);

create table cohort_af_65 as
	select distinct(o.patient_id) from ceg_compass_data.observation o
	join ceg_compass_data.organization org on org.id = o.organization_id
    join ceg_compass_data.episode_of_care e on e.patient_id = o.patient_id
    join ceg_compass_data.patient p on p.id = o.patient_id
	where org.parent_organization_id in (2, 251340514, 306924583, 1268492093, 721322892, 1083463, 93721724, 303221, 28025907)
    and p.date_of_death IS NULL
    and p.age_years > 65
	and e.registration_type_id = 2
	and e.date_registered <= now()
	and (e.date_registered_end > now() or e.date_registered_end IS NULL);    
