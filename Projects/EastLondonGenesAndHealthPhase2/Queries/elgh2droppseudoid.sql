USE data_extracts;

DROP PROCEDURE IF EXISTS elgh2droppseudoid;

DELIMITER //
CREATE PROCEDURE elgh2droppseudoid()
BEGIN

SET SQL_SAFE_UPDATES=0;

ALTER TABLE gh2_demographicsDataset DROP COLUMN Pseudo_id;

ALTER TABLE gh2_diagnoses1dataset DROP COLUMN Pseudo_id;
ALTER TABLE gh2_diagnoses1adataset DROP COLUMN Pseudo_id;

ALTER TABLE gh2_diagnoses2dataset DROP COLUMN Pseudo_id;
ALTER TABLE gh2_diagnoses2adataset DROP COLUMN Pseudo_id;

ALTER TABLE gh2_braindataset DROP COLUMN Pseudo_id;
ALTER TABLE gh2_brain2dataset DROP COLUMN Pseudo_id;

ALTER TABLE gh2_labdataset DROP COLUMN Pseudo_id;
ALTER TABLE gh2_measuresdataset DROP COLUMN Pseudo_id;

ALTER TABLE gh2_weightALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_heightALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_BMIALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_SBPALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_DBPALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_TotalCholALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_LDLCholALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_eGFRALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_TSHALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_T4ALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_ThyroidInhibALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_ThyrotropinBindALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_AntithyroperoxidaseALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_AntithyroglobulinALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_FastingGlucoseALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_RandomGlucoseALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_HBA1CALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_FerritinALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_HaemoglobinALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_FSHALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_LHALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_DHEAALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_SHBGALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_ProlactinALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_TestosteroneALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_AntiMullerianHormoneALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_OestradiolALLdataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_ProgesteroneALLdataset DROP COLUMN pseudo_id;

ALTER TABLE gh2_MedPsychDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_MedDiabetesDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_MedCardioDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_MedEndoDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_MedAsthmaDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_MedDermDataset DROP COLUMN pseudo_id;

ALTER TABLE gh2_asthmaEmergeDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_hypertensionEmergeDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_t2dEmergeDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_cadDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_HypothyroidismDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_AtopicDermDataset DROP COLUMN pseudo_id;
ALTER TABLE gh2_DepressionDataset DROP COLUMN pseudo_id;

ALTER TABLE gh2_MedPsychDataset DROP COLUMN med_id;
ALTER TABLE gh2_MedDiabetesDataset DROP COLUMN med_id;
ALTER TABLE gh2_MedCardioDataset DROP COLUMN med_id;
ALTER TABLE gh2_MedEndoDataset DROP COLUMN med_id;
ALTER TABLE gh2_MedAsthmaDataset DROP COLUMN med_id;
ALTER TABLE gh2_MedDermDataset DROP COLUMN med_id;

SET SQL_SAFE_UPDATES=1;

END //
DELIMITER ;