-- There are no observations that post-date the admission date (how critical is this?)

select count(distinct(ae.person_id))
,	ae.barts_encounter_date
-- ,	obs.encounter_id
,	obs.clinical_effective_date 
-- ,	obs.snomed_concept_id
-- ,	obs.original_term
-- ,	obs.original_code

from ceg_compass_data.observation as obs
right join F50_bartsfrailty_ae_encounters as ae
	on obs.person_id = ae.person_id
    and obs.organization_id = ae.organization_id
    -- and obs.encounter_id = ae.barts_encounter_id
    and obs.clinical_effective_date >= DATE_ADD(ae.barts_encounter_date, INTERVAL -7 DAY)
    -- and ae.person_id = 126708
group by 2,3
order by obs.clinical_effective_date;


select * from ceg_compass_data   



select * from ceg_compass_data.encounter_raw 
where person_id = 126708 
and organization_id = 294564
-- where id = 2096032246
order by clinical_effective_date desc