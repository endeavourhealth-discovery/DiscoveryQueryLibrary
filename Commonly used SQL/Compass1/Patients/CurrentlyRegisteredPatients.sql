/*
A SQL script to obtain all currently registered patients in a Compass 1 database
*/

select o2.name as CCG,
o.name as practice, count(distinct p.id)
from patient p
join organization o on o.id = p.organization_id
join organization o2 on o2.id = o.parent_organization_id
join episode_of_care e on e.patient_id = p.id
where p.date_of_death IS NULL
and e.registration_type_id = 2
and e.date_registered <= now()
and (e.date_registered_end > now() or e.date_registered_end IS NULL)
and
e.id >=
(select max(e2.id)
from
episode_of_care e2
join patient p on p.id = e2.patient_id
where p.date_of_death IS NULL
and e2.registration_type_id = 2
and e2.date_registered <= now()
and (e2.date_registered_end > now() or e2.date_registered_end IS NULL)
and e2.patient_id = e.patient_id)
group by o2.name, o.name
order by o2.name, o.name;
