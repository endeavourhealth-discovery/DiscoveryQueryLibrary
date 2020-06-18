use data_extracts;

drop procedure if exists buildDatasetForEye;

DELIMITER //
CREATE PROCEDURE buildDatasetForEye ()
BEGIN

drop table if exists dataset_eye;

-- DiabetesQofDiagnosis,DiabetesQofDiagnosisDate,BloodPressureCheckDate,BloodPressureCheckSystolicValue,BloodPressureCheckDiastolicValue,HbA1cTestDate,HbA1cTestValue,DiabetesQofTreatment,PregnancyDate,GP2DRSDiabetes (national criteria),

create table dataset_eye (
   pseudo_id varchar(255),

   CCG varchar(100),
   Ethnicity varchar(100),
   EthCode varchar(100),
   Gender varchar(7) null,
   RegisteredDate varchar(10),
   Age varchar(10),
   Doctor varchar(100),
   BirthDate varchar(100) null,
   PracticeCode varchar(50) null,
   PracticeName varchar(255) null,

   NHSNumber varchar(10),
   LSOACode varchar(10),
   AddressLine1 varchar(255),
   AddressLine2 varchar(255),
   AddressLine3 varchar(255),
   AddressLine4 varchar(255),
   Postcode varchar(8),

   LastName varchar(255),
   FirstName varchar(255)
);


insert into dataset_eye (pseudo_id)
  select distinct group_by from cohort c;

alter table dataset_eye add index psuedoIdIdx (pseudo_id);

update dataset_eye d
  join ceg_compass_data.patient p on d.pseudo_id = p.pseudo_id
  join ceg_compass_data.person per on p.person_id = per.id
    set d.Age = per.age_years, d.LSOACode = per.lsoa_code, d.EthCode = per.ethnic_code;

update dataset_eye d
  join ceg_compass_data.ethnicity_lookup el on d.EthCode = el.ethnic_code
    set d.Ethnicity = el.ethnic_name;


update dataset_eye d
  join ceg_compass_data.patient p on d.pseudo_id = p.pseudo_id
  join ceg_compass_data.episode_of_care e
    on e.patient_id = p.id and e.registration_type_id = 2 and e.date_registered <= now() and (e.date_registered_end > now() or e.date_registered_end IS NULL)
  join ceg_compass_data.organization org on org.id = p.organization_id
  join ceg_compass_data.organization parent_org on parent_org.id = org.parent_organization_id and org.parent_organization_id in (315366836, 141517)
  left join ceg_compass_data.practitioner prac on e.usual_gp_practitioner_id = prac.id
    set d.RegisteredDate = e.date_registered, d.PracticeCode = org.ods_code, d.PracticeName = org.name, d.CCG = parent_org.name, d.Doctor = prac.name;


END//
DELIMITER ;
