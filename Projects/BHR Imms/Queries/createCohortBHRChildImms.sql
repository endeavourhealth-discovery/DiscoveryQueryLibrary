use data_extracts;

drop procedure if exists createCohortBHRChildImms;

DELIMITER //
CREATE PROCEDURE createCohortBHRChildImms()
BEGIN

    drop table if exists cohort;

    create table cohort as
    SELECT p.id as 'patient_id', p.id as 'group_by', date_of_birth
    FROM enterprise_pi.patient p
             JOIN enterprise_pi.organization org on p.organization_id = org.id
             join enterprise_pi.episode_of_care e on e.patient_id = p.id
    WHERE
            org.ods_code in ('F82001',
                             'F82002',
                             'F82003',
                             'F82005',
                             'F82006',
                             'F82007',
                             'F82008',
                             'F82009',
                             'F82011',
                             'F82012',
                             'F82014',
                             'F82016',
                             'F82018',
                             'F82019',
                             'F82021',
                             'F82023',
                             'F82025',
                             'F82028',
                             'F82030',
                             'F82034',
                             'F82039',
                             'F82040',
                             'F82042',
                             'F82045',
                             'F82051',
                             'F82053',
                             'F82055',
                             'F82604',
                             'F82607',
                             'F82609',
                             'F82610',
                             'F82612',
                             'F82619',
                             'F82624',
                             'F82625',
                             'F82627',
                             'F82630',
                             'F82634',
                             'F82638',
                             'F82639',
                             'F82642',
                             'F82647',
                             'F82648',
                             'F82649',
                             'F82650',
                             'F82660',
                             'F82661',
                             'F82670',
                             'F82674',
                             'F82675',
                             'F82676',
                             'F82677',
                             'F82679',
                             'F82686',
                             'F86008',
                             'F86009',
                             'F86010',
                             'F86020',
                             'F86022',
                             'F86023',
                             'F86028',
                             'F86032',
                             'F86034',
                             'F86040',
                             'F86042',
                             'F86060',
                             'F86064',
                             'F86066',
                             'F86081',
                             'F86083',
                             'F86085',
                             'F86087',
                             'F86612',
                             'F86624',
                             'F86637',
                             'F86641',
                             'F86642',
                             'F86652',
                             'F86691',
                             'F86692',
                             'F86698',
                             'F86702',
                             'F86703',
                             'F86731',
                             'Y00090',
                             'Y00312',
                             'Y00918',
                             'Y01719',
                             'Y01795',
                             'Y02575',
                             'Y02973',
                             'Y02987',
                             'F82010',
                             'F82015',
                             'F82017',
                             'F82027',
                             'F82031',
                             'F82033',
                             'F82038',
                             'F82663',
                             'F82678',
                             'F86007',
                             'Y01280',
                             'Y00155','F86082','F86025','F86658','F86013','F86657','F82680',
                             'F82013','F82022','F82614','F82621','F82666','F82671','F86012','F86707')
      and e.registration_type_id = 2
      and e.date_registered <= now()
      and p.date_of_death IS NULL
      and (e.date_registered_end > now() or e.date_registered_end IS NULL)
      and DATEDIFF(NOW(), p.date_of_birth) / 365.25 < 20;

END//
DELIMITER ;
