use data_extracts;

drop procedure if exists executeDataset2ELGH;

DELIMITER //
CREATE PROCEDURE executeDataset2ELGH ()
BEGIN

-- Age in years
UPDATE dataset2 d join cohort c on c.group_by = d.pseudo_id
 join ceg_compass_data.patient p ON c.pseudo_id_from_compass = p.pseudo_id SET d.age_years = p.age_years;

-- create temporary code set using unused code_set_id 201
delete from code_set_codes where code_set_id = 201;
call addCodesToCodesetFinal(201, 'C10E%,C10ER,C10F%,');
call removeCodesFromCodesetFinal(201, '21263,212H,C10F8,');

 -- T1/T2 pivot date for later T1T2Window calculations (filterType = 2)
 call filterObservations(201, 1, null, 0); -- latest T1 or T2
 update cohort c join filteredObservations f on f.group_by = c.group_by set c.pivot_date = f.clinical_effective_date;

-- ELGH Smoker
call populateCodeDate(1, 'Smoker', 'dataset2', 0, '137%, E25%,', null);

-- ELGH Weight
call populateCodeDateValueUnitAge(0, 'WeightEarliest', 'dataset2', 0, '22A,', 1, null);
call populateCodeDateValueUnitAge(1, 'WeightLatest', 'dataset2', 0, '22A,', 1, null);
call populateCodeDateValueUnitAge(3, 'WeightT1T2Window', 'dataset2', 0, '22A,', 1, null);

-- ELGH Height
call populateCodeDateValueUnitAge(0, 'HeightEarliest', 'dataset2', 0, '229,', 1, null);
call populateCodeDateValueUnitAge(1, 'HeightLatest', 'dataset2', 0, '229,', 1, null);
call populateCodeDateValueUnitAge(3, 'HeightT1T2Window', 'dataset2', 0, '229,', 1, null);

-- ELGH BMI
call populateCodeDateValueUnitAge(0, 'BMIEarliest', 'dataset2', 0, '22K,', 1, null);
call populateCodeDateValueUnitAge(1, 'BMILatest', 'dataset2', 0, '22K,', 1, null);
call populateCodeDateValueUnitAge(3, 'BMIT1T2Window', 'dataset2', 0, '22K,', 1, null);

-- ELGH HbA1c
call populateCodeDateValueUnit(0, 'HbA1cEarliest', 'dataset2', 0, '42W5, 42W4,', 1, null);
call populateCodeDateValueUnit(1, 'HbA1cLatest', 'dataset2', 0, '42W5, 42W4,', 1, null);
call populateCodeDateValueUnit(3, 'HbA1cT1T2Window', 'dataset2', 0, '42W5, 42W4,', 1, null);

-- ELGH Cholesterol
call populateCodeDateValueUnit(0, 'CholesterolEarliest', 'dataset2', 0, '44P,', 1, null);
call populateCodeDateValueUnit(1, 'CholesterolLatest', 'dataset2', 0, '44P,', 1, null);
call populateCodeDateValueUnit(3, 'CholesterolT1T2Window', 'dataset2', 0, '44P,', 1, null);

-- ELGH HDL
call populateCodeDateValueUnit(0, 'HDLEarliest', 'dataset2', 0, '44P5,', 1, null);
call populateCodeDateValueUnit(1, 'HDLLatest', 'dataset2', 0, '44P5,', 1, null);
call populateCodeDateValueUnit(3, 'HDLT1T2Window', 'dataset2', 0, '44P5,', 1, null);

-- ELGH LDL
call populateCodeDateValueUnit(0, 'LDLEarliest', 'dataset2', 0, '44P6,', 1, null);
call populateCodeDateValueUnit(1, 'LDLLatest', 'dataset2', 0, '44P6,', 1, null);
call populateCodeDateValueUnit(3, 'LDLT1T2Window', 'dataset2', 0, '44P6,', 1, null);


-- ELGH Triglycerides
call populateCodeDateValueUnit(0, 'TriglyceridesEarliest', 'dataset2', 0, '44Q%,', 1, null);
call populateCodeDateValueUnit(1, 'TriglyceridesLatest', 'dataset2', 0, '44Q%,', 1, null);
call populateCodeDateValueUnit(3, 'TriglyceridesT1T2Window', 'dataset2', 0, '44Q%,', 1, null);

-- ELGH Protein Creatinine
call populateCodeDateValueUnit(0, 'ProteinCreatinineEarliest', 'dataset2', 0, '44lD,', 1, null);
call populateCodeDateValueUnit(1, 'ProteinCreatinineLatest', 'dataset2', 0, '44lD,', 1, null);

-- ELGH Albumin Creatinine
call populateCodeDateValueUnit(0, 'AlbuminCreatinineEarliest', 'dataset2', 0, '46TC,', 1, null);
call populateCodeDateValueUnit(1, 'AlbuminCreatinineLatest', 'dataset2', 0, '46TC,', 1, null);

-- ELGH Albumin
call populateCodeDateValueUnit(0, 'AlbuminEarliest', 'dataset2', 0, '46N4,', 1, null);
call populateCodeDateValueUnit(1, 'AlbuminLatest', 'dataset2', 0, '46N4,', 1, null);

-- ELGH Sys BP
call populateCodeDateValueUnit(0, 'SysBPEarliest', 'dataset2', 0, '2469,', 1, null);
call populateCodeDateValueUnit(1, 'SysBPLatest', 'dataset2', 0, '2469,', 1, null);

-- ELGH Dia BP
call populateCodeDateValueUnit(0, 'DiaBPEarliest', 'dataset2', 0, '246A,', 1, null);
call populateCodeDateValueUnit(1, 'DiaBPLatest', 'dataset2', 0, '246A,', 1, null);

-- ELGH Creatinine
call populateCodeDateValueUnit(0, 'CreatinineEarliest', 'dataset2', 0, '44J3,', 1, null);
call populateCodeDateValueUnit(1, 'CreatinineLatest', 'dataset2', 0, '44J3,', 1, null);

-- ELGH EGFR
call populateCodeDateValueUnit(0, 'EGFREarliest', 'dataset2', 0, '451E,', 1, null);
call populateCodeDateValueUnit(1, 'EGFRLatest', 'dataset2', 0, '451E,', 1, null);

-- ELGH GAD
call populateCodeDateValueUnit(1, 'GADLatest', 'dataset2', 0, '43m8,', 1, null);

-- ELGH Islet cell
call populateCodeDateValueUnit(1, 'IsletCellLatest', 'dataset2', 0, '43a3,', 1, null);

-- ELGH IA2
call populateCodeDateValueUnit(1, 'IA2Latest', 'dataset2', 0, '43aw,', 1, null);

-- ELGH Coeliac autoantibody
call populateCodeDateValueUnit(1, 'CoeliacLatest', 'dataset2', 0, '68W3 , 68W4,', 1, null);

-- ELGH Peroxidase
call populateCodeDateValueUnit(1, 'PeroxidaseLatest', 'dataset2', 0, '43Gd%,', 1, null);

-- ELGH Cpeptide
call populateCodeDateValueUnit(1, 'CpeptideLatest', 'dataset2', 0, '44Za% ,', 1, null);
-- ELGH Serum insulin
call populateCodeDateValueUnit(1, 'SerumInsulinLatest', 'dataset2', 0, '4493,', 1, null);

-- ELGH Serum ALT
call populateCodeDateValueUnit(1, 'SerumALTLatest', 'dataset2', 0, '44GB.,', 1, null);

-- ELGH AST serum
call populateCodeDateValueUnit(1, 'ASTSerumLatest', 'dataset2', 0, '44HB.,', 1, null);

-- ELGH  T4
call populateCodeDateValueUnit(1, 'T4Latest', 'dataset2', 0, '442A%, 4426%,', 1, null);

-- ELGH TSH
call populateCodeDateValueUnit(1, 'TSHLatest', 'dataset2', 0, 'C10E% , C10ER, C10F%, C109J,', 1, '21263, 212H, C10F8, 21263, 212H,');

END//
DELIMITER ;
