-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %% Step 4
-- %% Push into output files by hospital
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use data_extracts;

drop procedure if exists BF4_Generate_Output_Files;
DELIMITER //
create procedure BF4_Generate_Output_Files()
BEGIN

    -- test tables
    drop table if exists BF_TEST_Royal_London;
    create table BF_TEST_Royal_London as
    select * from F50_bartsfrailty_flags
    where hospital_name = 'Royal London';

    drop table if exists BF_TEST_Newham;
    create table BF_TEST_Newham as
    select * from F50_bartsfrailty_flags
    where hospital_name = 'Newham';

	drop table if exists BF_TEST_Whipps_Cross;
    create table BF_TEST_Whipps_Cross as
    select * from F50_bartsfrailty_flags
    where hospital_name = 'Whipps Cross';

    -- output files
	drop table if exists BF_OUT_Royal_London;
    create table BF_OUT_Royal_London as
    select pseudo_id
	,	admission_date
	,	hospital_name
	,	over65_carehome_admission
	,	over75_fall_history
	,	over75_delirium_admission
	,	over85_over_4_comorbidities
	,	gp_frailty_flag
    ,	master_frailty_flag
    from F50_bartsfrailty_flags
    where hospital_name = 'Royal London';

    drop table if exists BF_OUT_Newham;
    create table BF_OUT_Newham as
    select pseudo_id
	,	admission_date
	,	hospital_name
	,	over65_carehome_admission
	,	over75_fall_history
	,	over75_delirium_admission
	,	over85_over_4_comorbidities
	,	gp_frailty_flag
    ,	master_frailty_flag
    from F50_bartsfrailty_flags
    where hospital_name = 'Newham';

	drop table if exists BF_OUT_Whipps_Cross;
    create table BF_OUT_Whipps_Cross as
    select pseudo_id
	,	admission_date
	,	hospital_name
	,	over65_carehome_admission
	,	over75_fall_history
	,	over75_delirium_admission
	,	over85_over_4_comorbidities
	,	gp_frailty_flag
    ,	master_frailty_flag
    from F50_bartsfrailty_flags
    where hospital_name = 'Whipps Cross';

    -- Added by Jack B
    alter table BF_OUT_Whipps_Cross add column nhs_number varchar(100);
    alter table BF_OUT_Newham add column nhs_number varchar(100);
    alter table BF_OUT_Royal_London add column nhs_number varchar(100);

END;
// DELIMITER ;
