use data_extracts;

drop procedure if exists createCohortForELGH;

DELIMITER //
CREATE PROCEDURE createCohortForELGH ()
BEGIN

drop table if exists cohort;

create table cohort as
	 SELECT d.id as 'group_by', l.source_skid as 'pseudo_id_from_compass', p.id as 'patient_id'
		FROM darren.dvh_pseudo_nhs d
		LEFT OUTER JOIN ceg_compass_data.link_distributor l	ON d.id = l.target_skid	AND l.target_salt_key_name = 'EGH'
		LEFT OUTER JOIN ceg_compass_data.patient p	ON p.pseudo_id = l.source_skid
		JOIN ceg_compass_data.organization org on p.organization_id = org.id
			 WHERE org.parent_organization_id in (2, 303221, 315366836, 141517, 4181200, 251340514, 28025907, 36780701, 881508970, 153434644)
          or org.ods_code in ('F84660', 'F84054', 'F86086');

					-- F84660 DR CM PATEL'S SURGERY NHS NEWHAM CCG
					-- F84054 The Limehouse Practice NHS TOWER HAMLETS CCG
					-- F86086 Dr Dhital Practice NHS WALTHAM FOREST CCG

alter table cohort add column DateOfBirth date;
alter table cohort add column YearOfDeath int(4);
alter table cohort add column Gender varchar(10);
alter table cohort add column pivot_date date;

alter table cohort add index group_by_idx (group_by);
alter table cohort add index patient_id_idx (patient_id);
alter table cohort add index pseudo_id_from_compass_idx (pseudo_id_from_compass);

END//
DELIMITER ;
