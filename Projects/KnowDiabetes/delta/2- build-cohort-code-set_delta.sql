use data_extracts;

drop procedure if exists buildCohortCodeSetDelta;

DELIMITER //
CREATE PROCEDURE buildCohortCodeSetDelta()
BEGIN

	if not exists(select * from data_extracts.snomed_code_set where codeSetId = 2) then
		insert into data_extracts.snomed_code_set (codeSetId, codeSetName)
		values
		(1, 'Know Diabetes Cohort');
	end if;    
    
	delete from data_extracts.snomed_code_set_codes where codeSetId = 1;
    
	insert into data_extracts.snomed_code_set_codes (codeSetId, snomedCode)
	values
	(1, 5368009),
(1, 5969009),
(1, 8801005),
(1, 11530004),
(1, 44054006),
(1, 46635009),
(1, 51002006),
(1, 70694009),
(1, 73211009),
(1, 75682002),
(1, 127012008),
(1, 190368000),
(1, 190369008),
(1, 190372001),
(1, 190388001),
(1, 190389009),
(1, 190390000),
(1, 237599002),
(1, 237601000),
(1, 237604008),
(1, 237613005),
(1, 237618001),
(1, 237619009),
(1, 284449005),
(1, 290002008),
(1, 313435000),
(1, 313436004),
(1, 314771006),
(1, 314893005),
(1, 314902007),
(1, 314903002),
(1, 314904008),
(1, 395204000),
(1, 401110002),
(1, 408540003),
(1, 413183008),
(1, 420270002),
(1, 420279001),
(1, 420436000),
(1, 420486006),
(1, 420514000),
(1, 420715001),
(1, 420756003),
(1, 420789003),
(1, 420918009),
(1, 421075007),
(1, 421165007),
(1, 421326000),
(1, 421365002),
(1, 421468001),
(1, 421750000),
(1, 421779007),
(1, 421847006),
(1, 421893009),
(1, 421920002),
(1, 421986006),
(1, 422034002),
(1, 422099009),
(1, 422228004),
(1, 426705001),
(1, 426875007),
(1, 443694000),
(1, 444073006),
(1, 609561005),
(1, 609562003),
(1, 609572000),
(1, 703136005),
(1, 703137001),
(1, 703138006),
(1, 713702000),
(1, 713703005),
(1, 713705003),
(1, 713706002),
(1, 719216001),
-- start of new concept codes
(1, 421895002),
(1, 268519009),
(1, 111552007),
(1, 237632004),
(1, 39710007),
(1, 739681000),
(1, 385041000000108),
(1, 422183001),
-- PS 20/05/2020
(1, 700449008), -- Non-diabetic hyperglycemia (disorder)
(1, 11687002); -- Gestational diabetes mellitus (disorder)

END//
DELIMITER ;



