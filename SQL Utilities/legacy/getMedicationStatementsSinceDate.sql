drop procedure if exists getMedicationStatementsSinceDate;

DELIMITER //
CREATE PROCEDURE getMedicationStatementsSinceDate (
	IN snomedIds varchar (15000),
    IN dateFrom date
)
BEGIN

drop table if exists tmp_snomedIds;
create temporary table tmp_snomedIds (
    snomedId bigint(20)
);

-- Children
insert into tmp_snomedIds (snomedId) select s.subtypeId	from rf2.sct2_transitiveclosure s where find_in_set(s.supertypeId, snomedIds);

insert into dataset (medication_statement_id, patient_id, original_term, clinical_effective_date, date_precision_id, practitioner_id)
select m.id, m.patient_id, m.original_term, m.clinical_effective_date, m.date_precision_id, m.practitioner_id
from ceg_compass_data.medication_statement m
join cohort c on c.patient_id = m.patient_id
join tmp_snomedIds tmp on tmp.snomedId = m.dmd_id
where m.clinical_effective_date >  dateFrom;

END//
DELIMITER ;
