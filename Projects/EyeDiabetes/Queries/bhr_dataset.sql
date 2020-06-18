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

-- Age, dob, lsoa, Gender and ethnicity
update dataset_eye d
  join enterprise_pi.patient p on d.pseudo_id = p.nhs_number
  join enterprise_pi.person per on p.person_id = per.id
    set d.Age = round(DATEDIFF(NOW(), per.date_of_birth) / 365.25),
        d.BirthDate = per.date_of_birth,
        d.LSOACode = per.lsoa_code,
        d.EthCode = per.ethnic_code,
        d.Gender = per.patient_gender_id;

update dataset_eye d
  join enterprise_pi.patient_gender p on d.Gender = p.id
    set d.Gender = p.value;

-- Ethnic full name from code
update dataset_eye d
  join enterprise_pi.ethnicity_lookup el on d.EthCode = el.ethnic_code
    set d.Ethnicity = el.ethnic_name;

-- Practice code, name and CCG
update dataset_eye d
  join enterprise_pi.patient p on d.pseudo_id = p.nhs_number
  join enterprise_pi.episode_of_care e on e.patient_id = p.id and e.registration_type_id = 2 and e.date_registered <= now() and (e.date_registered_end > now() or e.date_registered_end IS NULL)
  join enterprise_pi.organization org on org.id = p.organization_id
  left join enterprise_pi.organization parent_org on parent_org.id = org.parent_organization_id
  left join enterprise_pi.practitioner prac on e.usual_gp_practitioner_id = prac.id
    set d.RegisteredDate = e.date_registered,
        d.PracticeCode = org.ods_code,
        d.PracticeName = org.name,
        d.CCG = parent_org.name,
        d.Doctor = prac.name;

-- Update demographics using max(last updated) as filter
update dataset_eye d
  join (select nhs_number, max(last_updated) as maxy from health_checks_bhr.patient_search group by nhs_number) as arse on arse.nhs_number = d.pseudo_id
  join health_checks_bhr.patient_search dem on dem.nhs_number = arse.nhs_number and dem.last_updated = arse.maxy
      set d.AddressLine1 = dem.address_line_1,
        d.AddressLine2 = dem.address_line_2,
        d.AddressLine3 = dem.address_line_3,
        d.AddressLine4 = dem.city,
        d.Postcode = dem.postcode,
        d.FirstName = dem.forenames,
        d.LastName = dem.surname;

END//
DELIMITER ;
