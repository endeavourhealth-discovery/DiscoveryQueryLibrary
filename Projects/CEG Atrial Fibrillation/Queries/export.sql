select CONCAT('\"',
coalesce(organization_id, ''),
'\",\"',
coalesce(medication_statement_id, ''),
'\",\"',
coalesce(original_term, ''),
'\",\"',
coalesce(result_value, ''),
'\",\"',
coalesce(result_value_units, ''),
'\"') as '\"organization_id\",\"medication_statement_id\",\"original_term\",\"result_value\",\"result_value_units\"'
from dataset;
