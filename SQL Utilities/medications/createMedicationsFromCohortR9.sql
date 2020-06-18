drop procedure if exists createMedicationsFromCohortR9;

DELIMITER //
CREATE PROCEDURE createMedicationsFromCohortR9 (
    IN snomedIds varchar (15000),
    IN filterType int
)
BEGIN

drop table if exists tmp_snomedIds;
create temporary table tmp_snomedIds (
    snomedId bigint(20)
);
insert into tmp_snomedIds (snomedId) select s.subtypeId	from rf2.sct2_transitiveclosure s where find_in_set(s.supertypeId, snomedIds);

drop table if exists medicationsFromCohort;

if (filterType = 0) then
	-- earliest
	create table medicationsFromCohort as
	  select
		m.id,
		m.dmd_id,
		m.patient_id,
    cr.pseudo_id,
		m.original_term,
		m.clinical_effective_date,
		m.quantity_unit,
		m.quantity_value
	 from cohort cr
	  join ceg_compass_data.medication_statement m on m.patient_id = cr.patient_id
	  join tmp_snomedIds tmp on tmp.snomedId = m.dmd_id;
else
	-- 12 months previously from now()
	create table medicationsFromCohort as
	  select
		m.id,
		m.dmd_id,
		m.patient_id,
    cr.pseudo_id,
		m.original_term,
		m.clinical_effective_date,
		m.quantity_unit,
		m.quantity_value
	 from cohort cr
	  join ceg_compass_data.medication_statement m on m.patient_id = cr.patient_id
	  join tmp_snomedIds tmp on tmp.snomedId = m.dmd_id
      where m.clinical_effective_date > DATE_SUB(now(), INTERVAL 12 MONTH);
end if;


alter table medicationsFromCohort add index (patient_id);
-- alter table medicationsFromCohort add index (clinical_effective_date);

END//
DELIMITER ;
