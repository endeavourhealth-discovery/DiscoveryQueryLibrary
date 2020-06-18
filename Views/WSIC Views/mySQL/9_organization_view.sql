USE nwl_subscriber_pid; 

DROP VIEW IF EXISTS organization_view;

CREATE VIEW organization_view AS
SELECT
      org.id organization_id, 
      org.ods_code,
      org.name organization_name, 
      org.type_code, 
      org.type_desc, 
      org.postcode, 
      org.parent_organization_id,
      NULLIF(COALESCE(org_evt.modified_date,0),0)  last_modified_date 
FROM organization org
LEFT JOIN (SELECT MAX(etlg.dt_change) modified_date, etlg.table_id, etlg.record_id 
           FROM event_log etlg WHERE etlg.table_id = 12
           GROUP BY etlg.table_id, etlg.record_id) org_evt ON org_evt.record_id = org.id;