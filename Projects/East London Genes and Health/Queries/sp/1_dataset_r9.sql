use data_extracts;

drop table if exists dataset1;

create table dataset1 (
  pseudo_id varchar(100) default NULL,
  ExtractDate datetime default NULL,
  Gender varchar(20) default null,
  Age varchar(100) default null,
  DateOfBirth date default null,
  Ethnicity varchar(100) default NULL,
  BirthCountryTerm varchar(100) null,
  BirthCountryCode varchar(100) null,
  RegistrationStart varchar(100) null,
  RegistrationEnd varchar(100) null,
  YearOfDeath int(4) default null,

  IMD2010 varchar(100) null,
  LSOA2011 varchar(100) null,

  PracticeODSCode varchar(100) null,
  PracticeODSName varchar(100) null,

  F2fVisits1year int(11) default null,
  F2fVisits5years int(11) default null,

  FHDiabetesCode varchar(100) null,
  FHDiabetesDate varchar(100) null,
  FHIHDCode varchar(100) null,
  FHIHDDate varchar(100) null,

  T1DiabetesCode varchar(100) null,
  T1DiabetesDate varchar(100) null,

  T2DiabetesCode varchar(100) null,
  T2DiabetesDate varchar(100) null,

  SecondaryCode varchar(100) null,
  SecondaryDate varchar(100) null,

  OtherCode varchar(100) null,
  OtherDate varchar(100) null,

  PancreaticCode varchar(100) null,
  PancreaticDate varchar(100) null,

  PregnancyCode varchar(100) null,
  PregnancyDate varchar(100) null,

  EmergenciesCode varchar(100) null,
  EmergenciesDate varchar(100) null,

  BariatricCode varchar(100) null,
  BariatricDate varchar(100) null,

  PrediabetesEarliestCode varchar(100) null,
  PrediabetesEarliestDate varchar(100) null,
  PrediabetesLatestCode varchar(100) null,
  PrediabetesLatestDate varchar(100) null,

  AtRiskEarliestCode varchar(100) null,
  AtRiskEarliestDate varchar(100) null,
  AtRiskLatestCode varchar(100) null,
  AtRiskLatestDate varchar(100) null,

  HbA1cEarliestCode varchar(100) null,
  HbA1cEarliestDate varchar(100) null,
  HbA1cEarliestValue varchar(100) null,
  HbA1cEarliestUnit varchar(100) null,

  HbA1cLatestCode varchar(100) null,
  HbA1cLatestDate varchar(100) null,
  HbA1cLatestValue varchar(100) null,
  HbA1cLatestUnit varchar(100) null,

  QDiabetesEarliestCode varchar(100) null,
  QDiabetesEarliestDate varchar(100) null,
  QDiabetesEarliestValue varchar(100) null,
  QDiabetesEarliestUnit varchar(100) null,

  QDiabetesLatestCode varchar(100) null,
  QDiabetesLatestDate varchar(100) null,
  QDiabetesLatestValue varchar(100) null,
  QDiabetesLatestUnit varchar(100) null,

  QRiskEarliestCode varchar(100) null,
  QRiskEarliestDate varchar(100) null,
  QRiskEarliestValue varchar(100) null,
  QRiskEarliestUnit varchar(100) null,

  QRiskLatestCode varchar(100) null,
  QRiskLatestDate varchar(100) null,
  QRiskLatestValue varchar(100) null,
  QRiskLatestUnit varchar(100) null,

  RetinopathyScreenCode varchar(100) null,
  RetinopathyScreenDate varchar(100) null,

  RetinalDiseaseStatusEitherEyeLatestCode varchar(100) null,
  RetinalDiseaseStatusEitherEyeLatestDate varchar(100) null,
  RetinalDiseaseStatusEitherEyeEarliestCode varchar(100) null,
  RetinalDiseaseStatusEitherEyeEarliestDate varchar(100) null,

  RetinalDiseaseStatusLeftEyeLatestCode varchar(100) null,
  RetinalDiseaseStatusLeftEyeLatestDate varchar(100) null,
  RetinalDiseaseStatusLeftEyeEarliestCode varchar(100) null,
  RetinalDiseaseStatusLeftEyeEarliestDate varchar(100) null,

  RetinalDiseaseStatusRightEyeLatestCode varchar(100) null,
  RetinalDiseaseStatusRightEyeLatestDate varchar(100) null,
  RetinalDiseaseStatusRightEyeEarliestCode varchar(100) null,
  RetinalDiseaseStatusRightEyeEarliestDate varchar(100) null,

  MaculopathyStatusEitherEyeLatestCode varchar(100) null,
  MaculopathyStatusEitherEyeLatestDate varchar(100) null,
  MaculopathyStatusEitherEyeEarliestCode varchar(100) null,
  MaculopathyStatusEitherEyeEarliestDate varchar(100) null,

  MaculopathyStatusLeftEyeLatestCode varchar(100) null,
  MaculopathyStatusLeftEyeLatestDate varchar(100) null,
  MaculopathyStatusLeftEyeEarliestCode varchar(100) null,
  MaculopathyStatusLeftEyeEarliestDate varchar(100) null,

  MaculopathyStatusRightEyeLatestCode varchar(100) null,
  MaculopathyStatusRightEyeLatestDate varchar(100) null,
  MaculopathyStatusRightEyeEarliestCode varchar(100) null,
  MaculopathyStatusRightEyeEarliestDate varchar(100) null,

  EDCode varchar(100) null,
  EDDate varchar(100) null,

  PVDCode varchar(100) null,
  PVDDate varchar(100) null,

  AAACode varchar(100) null,
  AAADate varchar(100) null,

  FootUlcerLeftCode varchar(100) null,
  FootUlcerLeftDate varchar(100) null,

  FootUlcerRightCode varchar(100) null,
  FootUlcerRightDate varchar(100) null,

  NeuropathyCode varchar(100) null,
  NeuropathyDate varchar(100) null,

  IHDLatestCode varchar(100) null,
  IHDLatestDate varchar(100) null,

  IHDEarliestCode varchar(100) null,
  IHDEarliestDate varchar(100) null,

  AnginaCode varchar(100) null,
  AnginaDate varchar(100) null,

  MICode varchar(100) null,
  MIDate varchar(100) null,

  AFFlutterCode varchar(100) null,
  AFFlutterDate varchar(100) null,

  HDCode varchar(100) null,
  HDDate varchar(100) null,

  TIACode varchar(100) null,
  TIADate varchar(100) null,

  StrokeCode varchar(100) null,
  StrokeDate varchar(100) null,

  StrokeHaemorrhagicCode varchar(100) null,
  StrokeHaemorrhagicDate varchar(100) null,

  StrokeIschaemicCode varchar(100) null,
  StrokeIschaemicDate varchar(100) null,

  HypertensionCode varchar(100) null,
  HypertensionDate varchar(100) null,

  CKDLatestCode varchar(100) null,
  CKDLatestDate varchar(100) null,

  CKDEarliestCode varchar(100) null,
  CKDEarliestDate varchar(100) null,

  DialysisLatestCode varchar(100) null,
  DialysisLatestDate varchar(100) null,

  DialysisEarliestCode varchar(100) null,
  DialysisEarliestDate varchar(100) null,

  RTLatestCode varchar(100) null,
  RTLatestDate varchar(100) null,

  RTEarliestCode varchar(100) null,
  RTEarliestDate varchar(100) null,

  RTRLatestCode varchar(100) null,
  RTRLatestDate varchar(100) null,

  RTREarliestCode varchar(100) null,
  RTREarliestDate varchar(100) null,

  PCSCode varchar(100) null,
  PCSDate varchar(100) null,

  ObesityDisorderCode varchar(100) null,
  ObesityDisorderDate varchar(100) null,

  NAFLDCode varchar(100) null,
  NAFLDDate varchar(100) null,

  HypercholesterolCode varchar(100) null,
  HypercholesterolDate varchar(100) null,

  AcanthosisCode varchar(100) null,
  AcanthosisDate varchar(100) null,

  ThyroidLatestCode varchar(100) null,
  ThyroidLatestDate varchar(100) null,

  ThyroidEarliestCode varchar(100) null,
  ThyroidEarliestDate varchar(100) null,

  CoeliacDiseaseCode varchar(100) null,
  CoeliacDiseaseDate varchar(100) null,

  VitiligoCode varchar(100) null,
  VitiligoDate varchar(100) null,

  FrailtyindexCode varchar(100) null,
  FrailtyindexDate varchar(100) null,

  NHSHCCode varchar(100) null,
  NHSHCDate varchar(100) null
  );

alter table dataset1 add index patientIdIdx (pseudo_id);

insert into dataset1 (pseudo_id, ExtractDate) select distinct group_by, now() from cohort;
