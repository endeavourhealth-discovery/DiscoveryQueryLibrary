USE data_extracts;

DROP PROCEDURE IF EXISTS populatePregDelSnomeds;

DELIMITER //

CREATE PROCEDURE populatePregDelSnomeds()

BEGIN

INSERT INTO snomed_codes (GROUP_ID, SNOMED_ID, DESCRIPTION)
VALUES
(10,469431000000102,'Pregnancy Delivery Code'),
(10,427991000000106,'Pregnancy Delivery Code'), 
(10,416571000000106,'Pregnancy Delivery Code'), 
(10,480551000000102,'Pregnancy Delivery Code'), 
(10,427511000000106,'Pregnancy Delivery Code'), 
(10,439801000000103,'Pregnancy Delivery Code'), 
(10,411131000000109,'Pregnancy Delivery Code'), 
(10,463841000000106,'Pregnancy Delivery Code'), 
(10,426631000000100,'Pregnancy Delivery Code'), 
(10,452521000000103,'Pregnancy Delivery Code'), 
(10,424525001,'Pregnancy Delivery Code'), 
(10,276445008,'Pregnancy Delivery Code'), 
(10,370352001,'Pregnancy Delivery Code'), 
(10,364587008,'Pregnancy Delivery Code'), 
(10,199745000,'Pregnancy Delivery Code'), 
(10,609496007,'Pregnancy Delivery Code'), 
(10,451014004,'Pregnancy Delivery Code'), 
(10,198832001,'Pregnancy Delivery Code'), 
(10,118215003,'Pregnancy Delivery Code'), 
(10,236973005,'Pregnancy Delivery Code'), 
(10,72059007,'Pregnancy Delivery Code'), 
(10,55052008,'Pregnancy Delivery Code'), 
(10,362972006,'Pregnancy Delivery Code'), 
(10,362973001,'Pregnancy Delivery Code'), 
(10,236883005,'Pregnancy Delivery Code'), 
(10,118185001,'Pregnancy Delivery Code'), 
(10,366321006,'Pregnancy Delivery Code'), 
(10,386216000,'Pregnancy Delivery Code'), 
(10,177128002,'Pregnancy Delivery Code'), 
(10,176849008,'Pregnancy Delivery Code'), 
(10,169960003,'Pregnancy Delivery Code'),  
(10,84275009,'Pregnancy Delivery Code'), 
(10,450640001,'Pregnancy Delivery Code'), 
(10,236991000,'Pregnancy Delivery Code'), 
(10,236979009,'Pregnancy Delivery Code'), 
(10,133906008,'Pregnancy Delivery Code'),  
(10,237014000,'Pregnancy Delivery Code'),  
(10,363681007,'Pregnancy Delivery Code'),  
(10,18114009,'Pregnancy Delivery Code'),  
(10,82688001,'Pregnancy Delivery Code'),  
(10,372456005,'Pregnancy Delivery Code'), 
(10,9221009,'Pregnancy Delivery Code'), 
(10,386639001,'Pregnancy Delivery Code'), 
(11,439351000000106,'Pregnancy Delivery Minus Code'),  
(11,243828009,'Pregnancy Delivery Minus Code'),   
(11,49794002,'Pregnancy Delivery Minus Code'),   
(11,127376007,'Pregnancy Delivery Minus Code'),   
(11,289783000,'Pregnancy Delivery Minus Code'),  
(11,18909006,'Pregnancy Delivery Minus Code'), 
(11,206057002,'Pregnancy Delivery Minus Code'),   
(11,53881005,'Pregnancy Delivery Minus Code'),  
(11,237036002,'Pregnancy Delivery Minus Code'),   
(11,200101003,'Pregnancy Delivery Minus Code'),  
(11,200113008,'Pregnancy Delivery Minus Code'),   
(11,289257009,'Pregnancy Delivery Minus Code'),  
(11,60001007,'Pregnancy Delivery Minus Code'),  
(11,106109006,'Pregnancy Delivery Minus Code'), 
(11,200058004,'Pregnancy Delivery Minus Code'),   
(11,200065007,'Pregnancy Delivery Minus Code'),   
(11,200051005,'Pregnancy Delivery Minus Code'),   
(11,200107004,'Pregnancy Delivery Minus Code'),  
(11,64171002,'Pregnancy Delivery Minus Code'),  
(11,25053000,'Pregnancy Delivery Minus Code'),  
(11,65409004,'Pregnancy Delivery Minus Code'),  
(11,29847008,'Pregnancy Delivery Minus Code'),  
(11,51154004,'Pregnancy Delivery Minus Code'),   
(11,118212000,'Pregnancy Delivery Minus Code');

END//
DELIMITER ;
























