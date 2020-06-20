
/*
 query to find Adastra observations (specifically for London Ambulance Service,
 which is the only 111 service published through DDS as yet)
*/
SELECT ob.*
FROM observation ob
INNER JOIN organization org
ON org.id = ob.organization_id
WHERE org.ods_code = 'RRU';

/*
example: to find patients with a “cough” symptom recorded by London Ambulance Service this year:
*/
SELECT ob.*
FROM observation ob
INNER JOIN organization org
ON org.id = ob.organization_id
WHERE org.ods_code = 'RRU'
and clinical_effective_date > '2020-01-01'
and original_code = 'R062.';