use jack;

drop table if exists dataset_smi;

create table dataset_smi (
   patient_id bigint(20) default NULL,
   nhs_number varchar(10),
   pseudo_id varchar(255),
   smi_status varchar(30),
   practiceCode varchar(100),
   practiceName varchar(100),
   conceptId int(20),
   conceptDescription varchar(100)
);

alter table dataset_smi add index patientIdIdx (patient_id);
