
drop table if exists barts_discharges;
create temporary table barts_discharges as
select a.* 
,	be.original_term
,	em.mapping_david_doc
,	be.clinical_effective_date as barts_discharge_date

from F50_bartsfrailty_first_encounters as a
left outer join ceg_compass_data.encounter as be
	on a.person_id = be.person_id									-- only encounters on our cohort
    and be.organization_id = 294564									-- only Barts encounters
    and be.clinical_effective_date >= a.barts_encounter_date 		-- only encounters after admission
inner join ceg_analysis_data.encounter_code as em
	on be.original_term = em.term
    and em.mapping_david_doc in ('inpatient_discharge_or_end_of_stay','outpatient_visit_(end_of_visit_or_discharge)');

-- Find minimum discharge date
select min(, person_id from barts_discharges group by 2 order by 1 desc
select * from barts_discharges where person_id = 1287428