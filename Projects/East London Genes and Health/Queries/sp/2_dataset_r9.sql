use data_extracts;

drop procedure if exists buildDataset2ForELGH;

DELIMITER //
CREATE PROCEDURE buildDataset2ForELGH ()
BEGIN

drop table if exists dataset2;

create table dataset2 (

  pseudo_id varchar(100) default NULL,
  age_years  int(11) default null,

	SmokerCode varchar(30) null,
	SmokerDate varchar(30) null,

	WeightEarliestCode varchar(30) null,
	WeightEarliestDate varchar(30) null,
	WeightEarliestValue varchar(30) null,
	WeightEarliestUnit varchar(50) null,
	WeightEarliestAge varchar(30) null,

	WeightT1T2WindowCode varchar(30) null,
	WeightT1T2WindowDate varchar(30) null,
	WeightT1T2WindowValue varchar(30) null,
	WeightT1T2WindowUnit varchar(50) null,
	WeightT1T2WindowAge varchar(30) null,

	WeightLatestCode varchar(30) null,
	WeightLatestDate varchar(30) null,
	WeightLatestValue varchar(30) null,
	WeightLatestUnit varchar(50) null,
	WeightLatestAge varchar(30) null,

	HeightEarliestCode varchar(30) null,
	HeightEarliestDate varchar(30) null,
	HeightEarliestValue varchar(30) null,
	HeightEarliestUnit varchar(50) null,
	HeightEarliestAge varchar(30) null,

	HeightT1T2WindowCode varchar(30) null,
	HeightT1T2WindowDate varchar(30) null,
	HeightT1T2WindowValue varchar(30) null,
	HeightT1T2WindowUnit varchar(30) null,
	HeightT1T2WindowAge varchar(30) null,

	HeightLatestCode varchar(30) null,
	HeightLatestDate varchar(30) null,
	HeightLatestValue varchar(30) null,
	HeightLatestUnit varchar(50) null,
	HeightLatestAge varchar(30) null,

	BMIEarliestCode varchar(30) null,
	BMIEarliestDate varchar(30) null,
	BMIEarliestValue varchar(30) null,
	BMIEarliestUnit varchar(50) null,
	BMIEarliestAge varchar(30) null,

	BMIT1T2WindowCode varchar(30) null,
	BMIT1T2WindowDate varchar(30) null,
	BMIT1T2WindowValue varchar(30) null,
	BMIT1T2WindowUnit varchar(30) null,
	BMIT1T2WindowAge varchar(30) null,

	BMILatestCode varchar(30) null,
	BMILatestDate varchar(30) null,
	BMILatestValue varchar(30) null,
	BMILatestUnit varchar(30) null,
	BMILatestAge varchar(30) null,

	HbA1cEarliestCode varchar(30) null,
	HbA1cEarliestDate varchar(30) null,
	HbA1cEarliestValue varchar(30) null,
	HbA1cEarliestUnit varchar(30) null,

	HbA1cT1T2WindowCode varchar(30) null,
	HbA1cT1T2WindowDate varchar(30) null,
	HbA1cT1T2WindowValue varchar(30) null,
	HbA1cT1T2WindowUnit varchar(30) null,

	HbA1cLatestCode varchar(30) null,
	HbA1cLatestDate varchar(30) null,
	HbA1cLatestValue varchar(30) null,
	HbA1cLatestUnit varchar(30) null,

	CholesterolEarliestCode varchar(30) null,
	CholesterolEarliestDate varchar(30) null,
	CholesterolEarliestValue varchar(30) null,
	CholesterolEarliestUnit varchar(30) null,

	CholesterolT1T2WindowCode varchar(30) null,
	CholesterolT1T2WindowDate varchar(30) null,
	CholesterolT1T2WindowValue varchar(30) null,
	CholesterolT1T2WindowUnit varchar(30) null,

	CholesterolLatestCode varchar(30) null,
	CholesterolLatestDate varchar(30) null,
	CholesterolLatestValue varchar(30) null,
	CholesterolLatestUnit varchar(30) null,

	HDLEarliestCode varchar(30) null,
	HDLEarliestDate varchar(30) null,
	HDLEarliestValue varchar(30) null,
	HDLEarliestUnit varchar(30) null,

	HDLT1T2WindowCode varchar(30) null,
	HDLT1T2WindowDate varchar(30) null,
	HDLT1T2WindowValue varchar(30) null,
	HDLT1T2WindowUnit varchar(30) null,

	HDLLatestCode varchar(30) null,
	HDLLatestDate varchar(30) null,
	HDLLatestValue varchar(30) null,
	HDLLatestUnit varchar(30) null,

	LDLEarliestCode varchar(30) null,
	LDLEarliestDate varchar(30) null,
	LDLEarliestValue varchar(30) null,
	LDLEarliestUnit varchar(30) null,
	LDLT1T2WindowCode varchar(30) null,
	LDLT1T2WindowDate varchar(30) null,
	LDLT1T2WindowValue varchar(30) null,
	LDLT1T2WindowUnit varchar(30) null,
	LDLLatestCode varchar(30) null,
	LDLLatestDate varchar(30) null,
	LDLLatestValue varchar(30) null,
	LDLLatestUnit varchar(30) null,

	TriglyceridesEarliestCode varchar(30) null,
	TriglyceridesEarliestDate varchar(30) null,
	TriglyceridesEarliestValue varchar(30) null,
	TriglyceridesEarliestUnit varchar(30) null,
	TriglyceridesT1T2WindowCode varchar(30) null,
	TriglyceridesT1T2WindowDate varchar(30) null,
	TriglyceridesT1T2WindowValue varchar(30) null,
	TriglyceridesT1T2WindowUnit varchar(30) null,
	TriglyceridesLatestCode varchar(30) null,
	TriglyceridesLatestDate varchar(30) null,
	TriglyceridesLatestValue varchar(30) null,
	TriglyceridesLatestUnit varchar(30) null,

	ProteinCreatinineEarliestCode varchar(30) null,
	ProteinCreatinineEarliestDate varchar(30) null,
	ProteinCreatinineEarliestValue varchar(30) null,
	ProteinCreatinineEarliestUnit varchar(30) null,
	ProteinCreatinineLatestCode varchar(30) null,
	ProteinCreatinineLatestDate varchar(30) null,
	ProteinCreatinineLatestValue varchar(30) null,
	ProteinCreatinineLatestUnit varchar(30) null,

	AlbuminCreatinineEarliestCode varchar(30) null,
	AlbuminCreatinineEarliestDate varchar(30) null,
	AlbuminCreatinineEarliestValue varchar(30) null,
	AlbuminCreatinineEarliestUnit varchar(30) null,
	AlbuminCreatinineLatestCode varchar(30) null,
	AlbuminCreatinineLatestDate varchar(30) null,
	AlbuminCreatinineLatestValue varchar(30) null,
	AlbuminCreatinineLatestUnit varchar(30) null,

	AlbuminEarliestCode varchar(30) null,
	AlbuminEarliestDate varchar(30) null,
	AlbuminEarliestValue varchar(30) null,
	AlbuminEarliestUnit varchar(30) null,
	AlbuminLatestCode varchar(30) null,
	AlbuminLatestDate varchar(30) null,
	AlbuminLatestValue varchar(30) null,
	AlbuminLatestUnit varchar(30) null,

	SysBPEarliestCode varchar(30) null,
	SysBPEarliestDate varchar(30) null,
	SysBPEarliestValue varchar(30) null,
	SysBPEarliestUnit varchar(30) null,
	SysBPLatestCode varchar(30) null,
	SysBPLatestDate varchar(30) null,
	SysBPLatestValue varchar(30) null,
	SysBPLatestUnit   varchar(30) null,

	DiaBPEarliestCode varchar(30) null,
	DiaBPEarliestDate varchar(30) null,
	DiaBPEarliestValue varchar(30) null,
	DiaBPEarliestUnit varchar(30) null,
	DiaBPLatestCode varchar(30) null,
	DiaBPLatestDate varchar(30) null,
	DiaBPLatestValue varchar(30) null,
	DiaBPLatestUnit varchar(30) null,

	CreatinineEarliestCode varchar(30) null,
	CreatinineEarliestDate varchar(30) null,
	CreatinineEarliestValue varchar(30) null,
	CreatinineEarliestUnit varchar(30) null,
	CreatinineLatestCode varchar(30) null,
	CreatinineLatestDate varchar(30) null,
	CreatinineLatestValue varchar(30) null,
	CreatinineLatestUnit varchar(30) null,

	EGFREarliestCode varchar(30) null,
	EGFREarliestDate varchar(30) null,
	EGFREarliestValue varchar(30) null,
	EGFREarliestUnit varchar(30) null,
	EGFRLatestCode varchar(30) null,
	EGFRLatestDate varchar(30) null,
	EGFRLatestValue varchar(30) null,
	EGFRLatestUnit varchar(30) null,

	GADLatestCode varchar(30) null,
	GADLatestDate varchar(30) null,
	GADLatestValue varchar(30) null,
	GADLatestUnit varchar(30) null,

	IsletCellLatestCode varchar(30) null,
	IsletCellLatestDate varchar(30) null,
	IsletCellLatestValue varchar(30) null,
	IsletCellLatestUnit varchar(30) null,
	IA2LatestCode varchar(30) null,
	IA2LatestDate varchar(30) null,
	IA2LatestValue varchar(30) null,
	IA2LatestUnit varchar(30) null,

	CoeliacLatestCode varchar(30) null,
	CoeliacLatestDate varchar(30) null,
	CoeliacLatestValue varchar(30) null,
	CoeliacLatestUnit varchar(30) null,

	PeroxidaseLatestCode varchar(30) null,
	PeroxidaseLatestDate varchar(30) null,
	PeroxidaseLatestValue varchar(30) null,
	PeroxidaseLatestUnit varchar(30) null,

	CpeptideLatestCode varchar(30) null,
	CpeptideLatestDate varchar(30) null,
	CpeptideLatestValue varchar(30) null,
	CpeptideLatestUnit varchar(30) null,

	SerumInsulinLatestCode varchar(30) null,
	SerumInsulinLatestDate varchar(30) null,
	SerumInsulinLatestValue varchar(30) null,
	SerumInsulinLatestUnit varchar(30) null,

	SerumALTLatestCode varchar(30) null,
	SerumALTLatestDate varchar(30) null,
	SerumALTLatestValue varchar(30) null,
	SerumALTLatestUnit varchar(30) null,

	ASTSerumLatestCode varchar(30) null,
	ASTSerumLatestDate varchar(30) null,
	ASTSerumLatestValue varchar(30) null,
	ASTSerumLatestUnit varchar(30) null,

	T4LatestCode varchar(30) null,
	T4LatestDate varchar(30) null,
	T4LatestValue varchar(30) null,
	T4LatestUnit varchar(30) null,

	TSHLatestCode varchar(30) null,
	TSHLatestDate varchar(30) null,
	TSHLatestValue varchar(30) null,
	TSHLatestUnit varchar(30) null
);

alter table dataset2 add index pseudoIdIdx (pseudo_id);

insert into dataset2 (pseudo_id) select distinct group_by from cohort;

END//
DELIMITER ;
