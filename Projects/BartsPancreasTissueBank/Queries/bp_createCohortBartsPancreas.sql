use data_extracts;

drop procedure if exists createCohortBartsPancreas;

DELIMITER //
CREATE PROCEDURE createCohortBartsPancreas ()
BEGIN

drop table if exists cohort;

create table cohort select distinct p.id as patient_id, d.pseudo_id as 'group_by', d.doner_id, d.NhsNumber, d.Gender, d.BirthDate, d.DateOfDeath
from dataset_pan d join
 ceg_compass_data.patient p on p.pseudo_id = d.pseudo_id;

alter table cohort modify column group_by varchar(255);
alter table cohort add column PracticeName varchar(100);
alter table cohort add column PracticeODScode varchar(100);
alter table cohort add column AgeYears varchar(10);

-- Practice
update cohort c join ceg_compass_data.patient p on p.pseudo_id = c.group_by
		 JOIN ceg_compass_data.organization org on p.organization_id = org.id
         join ceg_compass_data.episode_of_care e on e.patient_id = p.id
         set c.PracticeName = org.name, c.PracticeODScode = org.ods_code
        WHERE e.registration_type_id = 2
			and e.date_registered <= now()
			and (e.date_registered_end > now() or e.date_registered_end IS NULL);

-- Age years
update cohort c join ceg_compass_data.patient p on p.pseudo_id = c.group_by
set c.AgeYears = p.age_years;

-- DateOfDeath can be '', or only recorded for certain patient_ids of a NHSNumber.
update cohort c1 join cohort c2 on c1.NhsNumber = c2.NhsNumber
  set c1.DateOfDeath = c2.DateOfDeath
  where c2.DateOfDeath is not null and c2.DateOfDeath != '';

END//
DELIMITER ;
