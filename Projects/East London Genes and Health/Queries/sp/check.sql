select d1.pseudo_id, d1.FHDiabetesCode, d11.FHDiabetesCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FHDiabetesCode != d11.FHDiabetesCode order by d1.pseudo_id;
select d1.pseudo_id, d1.FHDiabetesDate, d11.FHDiabetesDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FHDiabetesDate != d11.FHDiabetesDate order by d1.pseudo_id;
select d1.pseudo_id, d1.FHIHDCode, d11.FHIHDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FHIHDCode != d11.FHIHDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.FHIHDDate, d11.FHIHDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FHIHDDate != d11.FHIHDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.T1DiabetesCode, d11.T1DiabetesCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.T1DiabetesCode != d11.T1DiabetesCode order by d1.pseudo_id;
select d1.pseudo_id, d1.T1DiabetesDate, d11.T1DiabetesDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.T1DiabetesDate != d11.T1DiabetesDate order by d1.pseudo_id;

select d1.pseudo_id, d1.T2DiabetesCode, d11.T2DiabetesCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.T2DiabetesCode != d11.T2DiabetesCode order by d1.pseudo_id;
select d1.pseudo_id, d1.T2DiabetesCode, d11.T2DiabetesCode, d1.T2DiabetesDate, d11.T2DiabetesDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.T2DiabetesDate != d11.T2DiabetesDate order by d1.pseudo_id;

select d1.pseudo_id, d1.SecondaryCode, d11.SecondaryCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.SecondaryCode != d11.SecondaryCode order by d1.pseudo_id;
select d1.pseudo_id, d1.SecondaryDate, d11.SecondaryDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.SecondaryDate != d11.SecondaryDate order by d1.pseudo_id;

select d1.pseudo_id, d1.OtherCode, d11.OtherCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.OtherCode != d11.OtherCode order by d1.pseudo_id;
select d1.pseudo_id, d1.OtherDate, d11.OtherDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.OtherDate != d11.OtherDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PancreaticCode, d11.PancreaticCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PancreaticCode != d11.PancreaticCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PancreaticCode, d11.PancreaticCode, d1.PancreaticDate, d11.PancreaticDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PancreaticDate != d11.PancreaticDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PregnancyCode, d11.PregnancyCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PregnancyCode != d11.PregnancyCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PregnancyDate, d11.PregnancyDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PregnancyDate != d11.PregnancyDate order by d1.pseudo_id;

select d1.pseudo_id, d1.EmergenciesCode, d11.EmergenciesCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.EmergenciesCode != d11.EmergenciesCode order by d1.pseudo_id;
select d1.pseudo_id, d1.EmergenciesDate, d11.EmergenciesDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.EmergenciesDate != d11.EmergenciesDate order by d1.pseudo_id;

select d1.pseudo_id, d1.BariatricCode, d11.BariatricCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.BariatricCode != d11.BariatricCode order by d1.pseudo_id;
select d1.pseudo_id, d1.BariatricDate, d11.BariatricDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.BariatricDate != d11.BariatricDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PrediabetesEarliestCode, d11.PrediabetesEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PrediabetesEarliestCode != d11.PrediabetesEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PrediabetesEarliestDate, d11.PrediabetesEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PrediabetesEarliestDate != d11.PrediabetesEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.PrediabetesLatestCode, d11.PrediabetesLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PrediabetesLatestCode != d11.PrediabetesLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PrediabetesLatestDate, d11.PrediabetesLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PrediabetesLatestDate != d11.PrediabetesLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.AtRiskEarliestCode, d11.AtRiskEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AtRiskEarliestCode != d11.AtRiskEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.AtRiskEarliestDate, d11.AtRiskEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AtRiskEarliestDate != d11.AtRiskEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.AtRiskLatestCode, d11.AtRiskLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AtRiskLatestCode != d11.AtRiskLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.AtRiskLatestDate, d11.AtRiskLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AtRiskLatestDate != d11.AtRiskLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.HbA1cEarliestCode, d11.HbA1cEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cEarliestCode != d11.HbA1cEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cEarliestDate, d11.HbA1cEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cEarliestDate != d11.HbA1cEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cEarliestValue, d11.HbA1cEarliestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cEarliestValue != d11.HbA1cEarliestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cEarliestUnit, d11.HbA1cEarliestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cEarliestUnit != d11.HbA1cEarliestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.HbA1cLatestCode, d11.HbA1cLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cLatestCode != d11.HbA1cLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cLatestDate, d11.HbA1cLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cLatestDate != d11.HbA1cLatestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cLatestValue, d11.HbA1cLatestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cLatestValue != d11.HbA1cLatestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.HbA1cLatestUnit, d11.HbA1cLatestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HbA1cLatestUnit != d11.HbA1cLatestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.QDiabetesEarliestCode, d11.QDiabetesEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesEarliestCode != d11.QDiabetesEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesEarliestDate, d11.QDiabetesEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesEarliestDate != d11.QDiabetesEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesEarliestValue, d11.QDiabetesEarliestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesEarliestValue != d11.QDiabetesEarliestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesEarliestUnit, d11.QDiabetesEarliestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesEarliestUnit != d11.QDiabetesEarliestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.QDiabetesLatestCode, d11.QDiabetesLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesLatestCode != d11.QDiabetesLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesLatestDate, d11.QDiabetesLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesLatestDate != d11.QDiabetesLatestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesLatestValue, d11.QDiabetesLatestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesLatestValue != d11.QDiabetesLatestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.QDiabetesLatestUnit, d11.QDiabetesLatestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QDiabetesLatestUnit != d11.QDiabetesLatestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.QRiskEarliestCode, d11.QRiskEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskEarliestCode != d11.QRiskEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskEarliestDate, d11.QRiskEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskEarliestDate != d11.QRiskEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskEarliestValue, d11.QRiskEarliestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskEarliestValue != d11.QRiskEarliestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskEarliestUnit, d11.QRiskEarliestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskEarliestUnit != d11.QRiskEarliestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.QRiskLatestCode, d11.QRiskLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskLatestCode != d11.QRiskLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskLatestDate, d11.QRiskLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskLatestDate != d11.QRiskLatestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskLatestValue, d11.QRiskLatestValue from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskLatestValue != d11.QRiskLatestValue order by d1.pseudo_id;
select d1.pseudo_id, d1.QRiskLatestUnit, d11.QRiskLatestUnit from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.QRiskLatestUnit != d11.QRiskLatestUnit order by d1.pseudo_id;

select d1.pseudo_id, d1.RetinopathyScreenCode, d11.RetinopathyScreenCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyScreenCode != d11.RetinopathyScreenCode order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyScreenDate, d11.RetinopathyScreenDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyScreenDate != d11.RetinopathyScreenDate order by d1.pseudo_id;

select d1.pseudo_id, d1.RetinopathyLeftEarliestCode, d11.RetinopathyLeftEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyLeftEarliestCode != d11.RetinopathyLeftEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyLeftEarliestDate, d11.RetinopathyLeftEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyLeftEarliestDate != d11.RetinopathyLeftEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyLeftLatestCode, d11.RetinopathyLeftLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyLeftLatestCode != d11.RetinopathyLeftLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyLeftLatestDate, d11.RetinopathyLeftLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyLeftLatestDate != d11.RetinopathyLeftLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.NoRetinopathyLeftEarliestCode, d11.NoRetinopathyLeftEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyLeftEarliestCode != d11.NoRetinopathyLeftEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyLeftEarliestDate, d11.NoRetinopathyLeftEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyLeftEarliestDate != d11.NoRetinopathyLeftEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyLeftLatestCode, d11.NoRetinopathyLeftLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyLeftLatestCode != d11.NoRetinopathyLeftLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyLeftLatestDate, d11.NoRetinopathyLeftLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyLeftLatestDate != d11.NoRetinopathyLeftLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.RetinopathyRightEarliestCode, d11.RetinopathyRightEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyRightEarliestCode != d11.RetinopathyRightEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyRightEarliestDate, d11.RetinopathyRightEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyRightEarliestDate != d11.RetinopathyRightEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyRightLatestCode, d11.RetinopathyRightLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyRightLatestCode != d11.RetinopathyRightLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.RetinopathyRightLatestDate, d11.RetinopathyRightLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.RetinopathyRightLatestDate != d11.RetinopathyRightLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.NoRetinopathyRightEarliestCode, d11.NoRetinopathyRightEarliestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyRightEarliestCode != d11.NoRetinopathyRightEarliestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyRightEarliestDate, d11.NoRetinopathyRightEarliestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyRightEarliestDate != d11.NoRetinopathyRightEarliestDate order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyRightLatestCode, d11.NoRetinopathyRightLatestCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyRightLatestCode != d11.NoRetinopathyRightLatestCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NoRetinopathyRightLatestDate, d11.NoRetinopathyRightLatestDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NoRetinopathyRightLatestDate != d11.NoRetinopathyRightLatestDate order by d1.pseudo_id;

select d1.pseudo_id, d1.EDCode, d11.EDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.EDCode != d11.EDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.EDDate, d11.EDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.EDDate != d11.EDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PVDCode, d11.PVDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PVDCode != d11.PVDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PVDDate, d11.PVDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PVDDate != d11.PVDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PADCode, d11.PADCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PADCode != d11.PADCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PADDate, d11.PADDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PADDate != d11.PADDate order by d1.pseudo_id;

select d1.pseudo_id, d1.AAACode, d11.AAACode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AAACode != d11.AAACode order by d1.pseudo_id;
select d1.pseudo_id, d1.AAADate, d11.AAADate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AAADate != d11.AAADate order by d1.pseudo_id;

select d1.pseudo_id, d1.FootUlcerLeftCode, d11.FootUlcerLeftCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FootUlcerLeftCode != d11.FootUlcerLeftCode order by d1.pseudo_id;
select d1.pseudo_id, d1.FootUlcerLeftDate, d11.FootUlcerLeftDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FootUlcerLeftDate != d11.FootUlcerLeftDate order by d1.pseudo_id;

select d1.pseudo_id, d1.FootUlcerRightCode, d11.FootUlcerRightCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FootUlcerRightCode != d11.FootUlcerRightCode order by d1.pseudo_id;
select d1.pseudo_id, d1.FootUlcerRightDate, d11.FootUlcerRightDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FootUlcerRightDate != d11.FootUlcerRightDate order by d1.pseudo_id;

select d1.pseudo_id, d1.NeuropathyCode, d11.NeuropathyCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NeuropathyCode != d11.NeuropathyCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NeuropathyDate, d11.NeuropathyDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NeuropathyDate != d11.NeuropathyDate order by d1.pseudo_id;

select d1.pseudo_id, d1.IHDCode, d11.IHDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.IHDCode != d11.IHDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.IHDDate, d11.IHDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.IHDDate != d11.IHDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.AFFlutterCode, d11.AFFlutterCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AFFlutterCode != d11.AFFlutterCode order by d1.pseudo_id;
select d1.pseudo_id, d1.AFFlutterDate, d11.AFFlutterDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AFFlutterDate != d11.AFFlutterDate order by d1.pseudo_id;

select d1.pseudo_id, d1.HDCode, d11.HDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HDCode != d11.HDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.HDDate, d11.HDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HDDate != d11.HDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.StrokeCode, d11.StrokeCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.StrokeCode != d11.StrokeCode order by d1.pseudo_id;
select d1.pseudo_id, d1.StrokeDate, d11.StrokeDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.StrokeDate != d11.StrokeDate order by d1.pseudo_id;

select d1.pseudo_id, d1.HypertensionCode, d11.HypertensionCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HypertensionCode != d11.HypertensionCode order by d1.pseudo_id;
select d1.pseudo_id, d1.HypertensionDate, d11.HypertensionDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HypertensionDate != d11.HypertensionDate order by d1.pseudo_id;

select d1.pseudo_id, d1.CKDCode, d11.CKDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.CKDCode != d11.CKDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.CKDDate, d11.CKDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.CKDDate != d11.CKDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.PCSCode, d11.PCSCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PCSCode != d11.PCSCode order by d1.pseudo_id;
select d1.pseudo_id, d1.PCSDate, d11.PCSDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.PCSDate != d11.PCSDate order by d1.pseudo_id;

select d1.pseudo_id, d1.ObesityDisorderCode, d11.ObesityDisorderCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.ObesityDisorderCode != d11.ObesityDisorderCode order by d1.pseudo_id;
select d1.pseudo_id, d1.ObesityDisorderDate, d11.ObesityDisorderDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.ObesityDisorderDate != d11.ObesityDisorderDate order by d1.pseudo_id;

select d1.pseudo_id, d1.NAFLDCode, d11.NAFLDCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NAFLDCode != d11.NAFLDCode order by d1.pseudo_id;
select d1.pseudo_id, d1.NAFLDDate, d11.NAFLDDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NAFLDDate != d11.NAFLDDate order by d1.pseudo_id;

select d1.pseudo_id, d1.HypercholesterolCode, d11.HypercholesterolCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HypercholesterolCode != d11.HypercholesterolCode order by d1.pseudo_id;
select d1.pseudo_id, d1.HypercholesterolDate, d11.HypercholesterolDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.HypercholesterolDate != d11.HypercholesterolDate order by d1.pseudo_id;

select d1.pseudo_id, d1.AcanthosisCode, d11.AcanthosisCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AcanthosisCode != d11.AcanthosisCode order by d1.pseudo_id;
select d1.pseudo_id, d1.AcanthosisDate, d11.AcanthosisDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AcanthosisDate != d11.AcanthosisDate order by d1.pseudo_id;

select d1.pseudo_id, d1.ThyroidCode, d11.ThyroidCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.ThyroidCode != d11.ThyroidCode order by d1.pseudo_id;
select d1.pseudo_id, d1.ThyroidDate, d11.ThyroidDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.ThyroidDate != d11.ThyroidDate order by d1.pseudo_id;

select d1.pseudo_id, d1.AutoimmuneCode, d11.AutoimmuneCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AutoimmuneCode != d11.AutoimmuneCode order by d1.pseudo_id;
select d1.pseudo_id, d1.AutoimmuneDate, d11.AutoimmuneDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.AutoimmuneDate != d11.AutoimmuneDate order by d1.pseudo_id;

select d1.pseudo_id, d1.FrailtyindexCode, d11.FrailtyindexCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FrailtyindexCode != d11.FrailtyindexCode order by d1.pseudo_id;
select d1.pseudo_id, d1.FrailtyindexDate, d11.FrailtyindexDate from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.FrailtyindexDate != d11.FrailtyindexDate order by d1.pseudo_id;

select d1.pseudo_id, d1.NHSHCCode, d11.NHSHCCode from dataset1 d1 join dataset11 d11 on d1.pseudo_id = d11.pseudo_id where d1.NHSHCCode != d11.NHSHCCode order by d1.pseudo_id;