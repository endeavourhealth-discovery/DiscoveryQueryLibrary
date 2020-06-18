use data_extracts;

drop procedure if exists buildDatasetForWFChildImms;

DELIMITER //
CREATE PROCEDURE buildDatasetForWFChildImms ()
BEGIN

drop table if exists dataset_wf;

create table dataset_wf (
   id bigint(20) default NULL,
   patient_id bigint(20) default NULL,
   CodeDate varchar(20) default NULL,
   CodeTerm varchar(100) default null,
   CodeName varchar(100) default null,
   -- CodeValue varchar(50) default null,
   Ethnicity varchar(100) default NULL,
   Gender varchar(7) null,
   Age varchar(10) null,
   BirthDate varchar(100) null,
   PracticeODSCode varchar(50) null,
   PracticeName varchar(255) null,

   NHSNumber varchar(10) default null,
   AddressLine1 varchar(255) default null,
   AddressLine2 varchar(255) default null,
   AddressLine3 varchar(255) default null,

   LastName varchar(255) default null,
   FirstName varchar(255) default null,

   City varchar(255) default null,
   Postcode varchar(8) default null
);

alter table dataset_wf add unique index observationIdUniqueIdx (id);

END//
DELIMITER ;
