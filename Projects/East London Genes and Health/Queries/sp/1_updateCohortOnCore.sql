use jack;

update cohort d
join subscriber_transform_ceg_enterprise.pseudo_id_map s on s.pseudo_id = d.pseudo_id_from_compass
join eds.patient_search p on p.patient_id = s.patient_id -- and p.registered_practice_ods_code = d.PracticeODSCode
set
d.DateOfBirth = DATE_SUB(p.date_of_birth, INTERVAL DAYOFMONTH(p.date_of_birth) - 1 DAY),
d.Gender = p.gender,
YearOfDeath = YEAR(p.date_of_death);
