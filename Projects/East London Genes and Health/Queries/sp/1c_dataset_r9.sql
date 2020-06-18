use data_extracts;

drop table if exists dataset1c;

create table dataset1c (
  pseudo_id varchar(100) default NULL,
  MICode varchar(50),
  MIDate varchar(50),
  CHFCode varchar(50),
  CHFDate varchar(50),
  PVDCode varchar(50),
  PVDDate varchar(50),
  CVACode varchar(50),
  CVADate varchar(50),
  PLEGIACode varchar(50),
  PLEGIADate varchar(50),
  COPDCode varchar(50),
  COPDDate varchar(50),
  DMCode varchar(50),
  DMDate varchar(50),
  DMENDORGANCode varchar(50),
  DMENDORGANDate varchar(50),
  RENALCode varchar(50),
  RENALDate varchar(50),
  LIVERCode varchar(50),
  LIVERDate varchar(50),
  SEVERELIVERCode varchar(50),
  SEVERELIVERDate varchar(50),
  ULCERCode varchar(50),
  ULCERDate varchar(50),
  CANCERCode varchar(50),
  CANCERDate varchar(50),
  METASTASESCode varchar(50),
  METASTASESDate varchar(50),
  DEMENTIACode varchar(50),
  DEMENTIADate varchar(50),
  RHEUMATICCode varchar(50),
  RHEUMATICDate varchar(50),
  HIVCode varchar(50),
  HIVDate varchar(50),
  HBPCode varchar(50),
  HBPDate varchar(50),
  SKINULCERCode varchar(50),
  SKINULCERDate varchar(50),
  DEPRESSIONCode varchar(50),
  DEPRESSIONDate varchar(50),
  SMICode varchar(50),
  SMIDate varchar(50)
);

alter table dataset1c add index patientIdIdx (pseudo_id);

insert into dataset1c (pseudo_id) select distinct group_by from cohort;
