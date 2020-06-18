use data_extracts;

drop procedure if exists createCohortWFChildImms;

DELIMITER //
CREATE PROCEDURE createCohortWFChildImms ()
BEGIN


drop table if exists cohort;

create table cohort as
	 SELECT p.id as 'patient_id', p.id as 'group_by', age_years
		FROM ceg_compass_data.patient p
		 JOIN ceg_compass_data.organization org on p.organization_id = org.id
         join ceg_compass_data.episode_of_care e on e.patient_id = p.id
        WHERE
       org.parent_organization_id in (315366836, 141517) -- All WF practices, new tpp has 881508960 as well
	   	-- and org.ods_code != 'F86018' 
			and e.registration_type_id = 2
			and e.date_registered <= now()
      and p.date_of_death IS NULL
			and (e.date_registered_end > now() or e.date_registered_end IS NULL)
			and (age_years < 20 or age_years is null);

END//
DELIMITER ;
