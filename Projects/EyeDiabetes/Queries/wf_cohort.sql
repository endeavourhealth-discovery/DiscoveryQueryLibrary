use data_extracts;

drop procedure if exists buildCohortForEye;

DELIMITER //
CREATE PROCEDURE buildCohortForEye ()
BEGIN

drop table if exists cohort;

call addCodesToCodeset (212, 'C100.,C1000,C1001,C100z,C101.,C101y,C101z,C102.,C1020,C1021,C102z,C103.,C103y,C103z,C104.,C1040,C1041,C104y,C104z,C105.,C1050,C1051,C105y,C105z,C106.,C1060,C1061,66AJ1,C106y,C106z,C107.,C1070,C1071,C1072,C1073,C1074,C107y,C107z,C108.,C1084,C108A,C108B,C108C,C108D,C108E,C108F,C108G,C108H,C108J,C108y,C108z,C109.,C1099,C109A,C109B,C109C,C109D,C109E,C109F,C109G,C109H,C10A.,C10A0,C10A1,C10A2,C10A3,C10A4,C10A5,C10A6,C10A7,C10AW,C10AX,C10B.,C10B0,C10J.,C10J0,C10P.,C10P0,C10P1,C10y.,C10y0,C10y1,C10yy,C10yz,C10z.,C10z0,C10z1,C10zy,C10zz,C11y0,Cyu2.,Cyu20,Cyu21,Cyu22,Cyu23,L1805,L1806,L1807,L180X,Lyu29,PKyP.,X008t,X40J7,X40J8,X40J9,X40Ja,X40Jb,X40JK,X40JN,X40JR,X40JV,X40JW,X40JX,Xa3ee,Xaagd,Xaage,Xaagf,XaCJ2,XaJlN,XaJUH,XE10E,XE10F,XE10G,XE10H,XE10I,XE128,XE12A,XE12C,XE12G,XE12K,XE12M,XM1Qx,C10..,C1010,C1011,C1030,C1031,C1080,C1081,C1082,C1083,C1085,C1086,C1087,C1088,C1089,C1090,C1091,C1092,C1093,C1094,C1095,C1096,C1097,C109J,C109K,C10C.,C10D.,C10E.,C10E0,C10E1,C10E2,C10E3,C10E4,C10E5,C10E6,C10E7,C10E8,C10E9,C10EA,C10EB,C10EC,C10ED,C10EE,C10EF,C10EG,C10EH,C10EJ,C10EK,C10EL,C10EM,C10EN,C10EP,C10EQ,C10ER,C10F.,C10F0,C10F1,C10F2,C10F3,C10F4,C10F5,C10F6,C10F7,C10F9,C10FA,C10FB,C10FC,C10FD,C10FE,C10FF,C10FG,C10FH,C10FJ,C10FK,C10FL,C10FM,C10FN,C10FP,C10FQ,C10FR,C10FS,C10G.,C10G0,C10H.,C10H0,C10M.,C10M0,C10N.,C10N0,C10N1,X40J4,X40J5,X40J6,X40JA,X40JB,X40JC,X40JG,X40JI,X40JJ,X40JO,X40JS,X40JY,X40JZ,Xa4g7,XaELP,XaELQ,XaEnn,XaEno,XaEnp,XaEnq,XaF04,XaF05,XaFm8,XaFmA,XaFmK,XaFmL,XaFmM,XaFn7,XaFn8,XaFn9,XaFWG,XaFWI,XaIrf,XaIzM,XaIzN,XaIzQ,XaIzR,XaJlL,XaJlM,XaJlQ,XaJlR,XaJQp,XaJSr,XaJUI,XaKyW,XaKyX,XaMzI,XaOPt,XaOPu,XM1Xk,XSETe,XSETH,XSETK,XSETp,', null);

create table cohort as
	SELECT distinct p.id as 'patient_id', p.pseudo_id as 'group_by', org.id as 'organization_id' from ceg_compass_data.observation o
	join ceg_compass_data.organization org on org.id = o.organization_id
	join data_extracts.code_set_codes r on r.read2_concept_id = o.original_code
    join ceg_compass_data.episode_of_care e on e.patient_id = o.patient_id
    join ceg_compass_data.patient p on p.id = o.patient_id
	where
	 org.parent_organization_id in  (315366836, 141517) -- All WF practices
	--	org.ods_code = 'F86627'  -- CHURCHILL MEDICAL CENTRE
	and r.code_set_id = 212
  and p.date_of_death IS NULL
	and e.registration_type_id = 2
	and e.date_registered <= now()
	and (e.date_registered_end > now() or e.date_registered_end IS NULL)
	and (age_years >= 12);

	alter table cohort add index groupByIdx (group_by);

	END//
	DELIMITER ;
