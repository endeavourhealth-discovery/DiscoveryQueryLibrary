USE [subscriber_pi];
GO

DROP VIEW IF EXISTS patient_address_view;
GO

CREATE VIEW patient_address_view AS 
SELECT 
      padr.id address_id, 
      padr.address_line_1 address1, 
      padr.address_line_2 address2, 
      padr.address_line_3 address3, 
      padr.address_line_4 address4, 
      padr.city address5, 
      padr.postcode postcode, 
      parn.uprn,
      FORMAT(padr.start_date,'yyyymmdd') start_date,
      FORMAT(padr.end_date,'yyyymmdd') end_date, 
      padr.lsoa_2001_code, 
      padr.lsoa_2011_code, 
      padr.msoa_2001_code, 
      padr.msoa_2011_code,
      pat.nhs_number,
      parn.abp_address_number matched_address_1, 
      parn.abp_address_street matched_address_2, 
      parn.abp_address_locality matched_address_3, 
      parn.abp_address_town matched_address_4, 
      parn.abp_address_postcode matched_postcode,
      parn.classification,
      parn.abp_address_organization business_name,
      parn.match_date uprn_match_date,
      parn.status uprn_status,
      parn.latitude,
      parn.longitude,
      IIF(padr_evt.modified_date IS NULL, NULL, padr_evt.modified_date)  last_modified_date 
FROM patient_address padr JOIN patient pat ON padr.patient_id = pat.id
LEFT JOIN patient_address_match parn ON padr.id = parn.id
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 20
           GROUP BY etlg.table_id, etlg.record_id) padr_evt ON padr_evt.record_id = padr.id;
GO
                             