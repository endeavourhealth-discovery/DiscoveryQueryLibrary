use jack;

-- Fill patient ids (will be overridden when smi identified)
-- update dataset_smi d
-- join ceg_compass_data.patient p on p.pseudo_id = d.pseudo_id
-- set
-- d.patient_id = p.id;

-- Registered, at CCG Newham, TH and City
update dataset_smi d
join ceg_compass_data.patient p on p.pseudo_id = d.pseudo_id
join ceg_compass_data.organization org on p.organization_id = org.id
join ceg_compass_data.episode_of_care e on e.patient_id = p.id
and		 e.registration_type_id = 2
			and e.date_registered <= now()
			and (e.date_registered_end > now() or e.date_registered_end IS NULL)
            set d.patient_id = p.id, practiceCode = org.ods_code, practiceName = org.name
  WHERE org.parent_organization_id in  (2, 303221, 4181200);

delete from dataset_smi where patient_id is null;

drop table if exists smi_patientids;

create table smi_patientids (
   patient_id bigint(20) default NULL,
   conceptId int(20),
   conceptDescription varchar(100),
   pseudo_id varchar(255)
);
insert into smi_patientids (patient_id, pseudo_id) select p.id, d.pseudo_id from dataset_smi d
join ceg_compass_data.patient p on p.pseudo_id = d.pseudo_id;

-- Index new table
alter table smi_patientids add index patientIdIdx (patient_id);
alter table smi_patientids add index pseudoIdIdx (pseudo_id);
alter table smi_patientids add index conceptIdIdx (conceptId);

-- smi_patientids concept id
update smi_patientids d
join ceg_compass_data.observation o on o.patient_id = d.patient_id
set
d.conceptId = o.snomed_concept_id
where o.snomed_concept_id in
(417601000000102,397711000000100,191538001,191530008,191677006,274953007,1089691000000105,278853003,231489001,441704009,191627008,192362008,191632009,767633005,13746004,85248005,767631007,767632000,371596008,767636002,31446002,83225003,44906001,268622001,357705009,48500005,53607008,231449007,280949006,61831009,278506006,77475008,63249007,13313007,191636007,191643001,16506000,79584002,21071000119101,191525009,307504004,5510009,191672000,191667009,755301000000102,231487004,21831000119109,104851000119103,60401000119104,231485007,191680007,191683009,69322001,191676002,231437006,1089511000000100,191613003,1086471000000103,68890003,58214004,88975006,31027006,4441000,53049002,61403008,73867007,28663008,162004,28475009,191670008,191668004,191604000);

-- smi_patientids concept description
update smi_patientids d
left join ceg_compass_data.Concept c on c.ConceptId = d.conceptId
set d.conceptDescription = c.Definition;

-- Transfer from smi to dataset
update dataset_smi d join smi_patientids s on d.pseudo_id = s.pseudo_id
set
-- d.patient_id = s.patient_id, (do we need regsitered patient_id or where smi diagnosed)
d.conceptId = s.conceptId,
d.conceptDescription = s.conceptDescription
where s.conceptId is not null;

-- No discovery record
update dataset_smi d set smi_status = 'NO_RECORD' where d.patient_id is null;

-- SMI
update dataset_smi d set smi_status = 'SMI' where d.conceptId is not null;

-- SMI_NOT_PRESENT
update dataset_smi set smi_status = 'SMI_NOT_PRESENT' where smi_status is null;

-- Clean
alter table dataset_smi drop column patient_id;
alter table dataset_smi drop column pseudo_id;
