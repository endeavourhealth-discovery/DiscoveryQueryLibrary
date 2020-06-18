use data_extracts;

drop procedure if exists transferFromBartsPancreasCohort;

DELIMITER //

CREATE PROCEDURE transferFromBartsPancreasCohort ()

BEGIN
update dataset_p_1 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_2 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_3 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_4 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_5 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_6 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_7 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_8 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_9 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_10 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;
update dataset_p_11 d join cohort c on c.group_by = d.pseudo_id set d.Gender = c.Gender, d.DonerId = c.doner_id, d.AgeYears = c.AgeYears, d.DateOfDeath = c.DateOfDeath, d.BirthDate = c.BirthDate, d.NHSNumber = c.NHSNumber;


alter table dataset_p_1 drop column pseudo_id;
alter table dataset_p_2 drop column pseudo_id;
alter table dataset_p_3 drop column pseudo_id;
alter table dataset_p_4 drop column pseudo_id;
alter table dataset_p_5 drop column pseudo_id;
alter table dataset_p_6 drop column pseudo_id;
alter table dataset_p_7 drop column pseudo_id;
alter table dataset_p_8 drop column pseudo_id;
alter table dataset_p_9 drop column pseudo_id;
alter table dataset_p_10 drop column pseudo_id;
alter table dataset_p_11 drop column pseudo_id;

END//
DELIMITER ;
