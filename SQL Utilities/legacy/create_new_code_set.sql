drop procedure if exists create_new_code_set;

DELIMITER //
CREATE PROCEDURE create_new_code_set (
    IN codeSetName varchar(255)
)
BEGIN

	select @new_id := max(id) + 1 from rf2.code_set;
    
    
    insert into rf2.code_set
    select @new_id, codeSetName;
    
    select @new_id;

END//
DELIMITER ;