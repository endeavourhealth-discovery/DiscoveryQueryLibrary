use data_extracts;

drop procedure if exists buildDatasetForBartsPancreas;

DELIMITER //
CREATE PROCEDURE buildDatasetForBartsPancreas ()
BEGIN

drop table if exists dataset_p_1;
drop table if exists dataset_p_2;
drop table if exists dataset_p_3;
drop table if exists dataset_p_4;
drop table if exists dataset_p_5;
drop table if exists dataset_p_6;
drop table if exists dataset_p_7;
drop table if exists dataset_p_8;
drop table if exists dataset_p_9;
drop table if exists dataset_p_10;
drop table if exists dataset_p_11;

create table dataset_p_1 (
   id bigint(20) default NULL,
--    patient_id bigint(20) default NULL,
   pseudo_id varchar(255) default NULL,
   DonerId varchar(255) default NULL,

    NHSNumber varchar(10) default null,
    Gender varchar(7) null,
    AgeYears varchar(10) null,
    BirthDate varchar(100) null,
    DateOfDeath varchar(30) null,

   CodeDate varchar(20) default NULL,
   CodeTerm varchar(100) default null,
   CodeName varchar(100) default null,
   CodeValue varchar(100) default null
);
create table dataset_p_2 as select * from dataset_p_1;
create table dataset_p_3 as select * from dataset_p_1;
create table dataset_p_4 as select * from dataset_p_1;
create table dataset_p_5 as select * from dataset_p_1;
create table dataset_p_6 as select * from dataset_p_1;
create table dataset_p_7 as select * from dataset_p_1;
create table dataset_p_8 as select * from dataset_p_1;
create table dataset_p_9 as select * from dataset_p_1;
create table dataset_p_10 as select * from dataset_p_1;
create table dataset_p_11 as select * from dataset_p_1;

alter table dataset_p_1 add unique index patientIdUniqueIdx (id);
alter table dataset_p_2 add unique index patientIdUniqueIdx (id);
alter table dataset_p_1 add index pseudoIdx (pseudo_id);
alter table dataset_p_2 add index pseudoIdx (pseudo_id);
END//
DELIMITER ;
