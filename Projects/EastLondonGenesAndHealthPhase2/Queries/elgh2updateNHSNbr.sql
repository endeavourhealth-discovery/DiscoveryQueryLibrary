USE data_extracts;

DROP PROCEDURE IF EXISTS elgh2updateNHSNbr;

DELIMITER //
CREATE PROCEDURE elgh2updateNHSNbr()
BEGIN

SET SQL_SAFE_UPDATES=0;

UPDATE gh2_demographicsDataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;

UPDATE gh2_diagnoses1dataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;
UPDATE gh2_diagnoses1adataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;

UPDATE gh2_diagnoses2dataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;
UPDATE gh2_diagnoses2adataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;

UPDATE gh2_braindataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;
UPDATE gh2_brain2dataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;

UPDATE gh2_labdataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;
UPDATE gh2_measuresdataset g JOIN cohort_gh2 c ON g.Pseudo_id = c.group_by SET g.Pseudo_NHSNumber = c.pseudo_nhsnumber;

UPDATE gh2_weightALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_heightALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_BMIALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_SBPALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_DBPALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_TotalCholALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_LDLCholALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_eGFRALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_TSHALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_T4ALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_ThyroidInhibALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_ThyrotropinBindALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_AntithyroperoxidaseALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_AntithyroglobulinALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_FastingGlucoseALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_RandomGlucoseALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_HBA1CALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_FerritinALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_HaemoglobinALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_FSHALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_LHALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_DHEAALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_SHBGALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_ProlactinALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_TestosteroneALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_AntiMullerianHormoneALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_OestradiolALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_ProgesteroneALLdataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;

UPDATE gh2_MedPsychDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_MedDiabetesDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_MedCardioDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_MedEndoDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_MedAsthmaDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_MedDermDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;

UPDATE gh2_asthmaEmergeDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_hypertensionEmergeDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_t2dEmergeDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_cadDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_HypothyroidismDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_AtopicDermDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;
UPDATE gh2_DepressionDataset g JOIN cohort_gh2 c ON g.pseudo_id = c.group_by SET g.pseudo_nhsnumber = c.pseudo_nhsnumber;

SET SQL_SAFE_UPDATES=1;

END //
DELIMITER ;