drop procedure if exists get_earliest_matching_codes;

DELIMITER //
CREATE PROCEDURE get_earliest_matching_codes (
    IN codeSetId int
)
BEGIN

call create_matching_codes_table(codeSetId);

drop table if exists temp_interesting_codes;

create table temp_interesting_codes as  
select distinct  
  mc.id,  
  mc.patient_id,
  mc.clinical_effective_date, 
  mc.date_precision_id,  
  mc.practitioner_id,   
  mc.organization_id,   
  mc.original_code,  
  mc.original_term,    
  mc.result_value,  
  mc.result_value_units,  
  date_format(mc.result_date, '%d/%m/%Y') as result_date, 
  mc.result_text,  
  mc.result_concept_id  
 from matching_codes mc  
 left join matching_codes mcoo on mcoo.patient_id = mc.patient_id  
   and (mc.clinical_effective_date > mcoo.clinical_effective_date  
	 or (mc.clinical_effective_date = mcoo.clinical_effective_date and mc.id > mcoo.id))  
 where mcoo.patient_id is null;
  
drop table if exists matching_codes;
 
 END//
DELIMITER ;