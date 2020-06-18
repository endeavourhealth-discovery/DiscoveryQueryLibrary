USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas11MedicationsBP2;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas11MedicationsBP2()
BEGIN

-- All since 2002  

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '420804003,14601000,108914001,349917000,421552005,90332006,7947003,91107009,85990009,31684002,360204007,74674007,6425004,796001,46576005,67507000,324643005,346325008,6369005,442539005,768600002,81839001,63094006,40820003,108402001,96195007,768602005,10049011000001109,13965000,768611005,108430001,32823007,96308008,108616001,319937007,320016006,72824008,108603001,57952007,80229008,56602009,108979001,66859009,443312008,704464003,108972005,8696009,85417000,411399003,32249005,768625006,33252009,320073005,108899006,108836002,768451002,48698004,108812001,320933002,768769007,330811006,409391006,18037511000001105,385610007,12236006,48647005,30492008,384952006,764132007,444381000124107,444361000124102,354078009,312061002,407314008,61946003,349849001,416636000,432254002,767565001,86977007,60169008,45844004,116596006,350361002,10756001,266717002,109081006,330769006,318706009,108940007,81759008,39487003,350553008,421953007,13565005,356076006,350108002,111137007,418528006,16599811000001100,61621000,116092004,116726003,87233003,116523008,108807002,10632007,26244009,77731008,323283001,16403005,363598004,38268001,11847009,350324006,350320002,346441008,327032007,324963001,764135009,135642004,765073001,407035002,349854005,767562003,10784006,36236003,96220002,321506004,108441004,108443001,15297811000001100,16047007,321174005,30125007,363560004,108418007,703677008,35476001,109054006,266715005,768759001,34012005,28028002,38076006,75770001,363560004,58944007,350631001,319304004,108478001,768761005,81064004,11563006,74226000,764877006,9693501000001103,9427501000001100,9429101000001103');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '420804003,14601000,108914001,349917000,421552005,90332006,7947003,91107009,85990009,31684002');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '420804003,14601000');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108914001,349917000');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '421552005,90332006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '7947003,91107009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '85990009,31684002');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '360204007,74674007,6425004,796001,46576005,67507000,324643005,346325008,6369005,442539005');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '360204007,74674007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '6425004,796001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '46576005,67507000');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '324643005,346325008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '6369005,442539005');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768600002,81839001,63094006,40820003,108402001,96195007,768602005,10049011000001109,13965000');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768600002,81839001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '63094006,40820003');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108402001,96195007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768602005,10049011000001109');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '13965000');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768611005,108430001,32823007,96308008,108616001,319937007,320016006,72824008,108603001,57952007');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768611005,108430001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '32823007,96308008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108616001,319937007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '320016006,72824008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108603001,57952007');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '80229008,56602009,108979001,66859009,443312008,704464003,108972005,8696009,85417000,411399003');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '80229008,56602009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108979001,66859009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '443312008,704464003');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108972005,8696009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '85417000,411399003');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '32249005,768625006,33252009,320073005,108899006,108836002,768451002,48698004,108812001,320933002');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '32249005,768625006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '33252009,320073005');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108899006,108836002');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768451002,48698004');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108812001,320933002');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768769007,330811006,409391006,18037511000001105,385610007,12236006,48647005,30492008,384952006');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768769007,330811006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '409391006,18037511000001105');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '385610007,12236006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '48647005,30492008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '384952006');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '764132007,444381000124107,444361000124102,354078009,312061002,407314008,61946003,349849001,416636000');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '764132007,444381000124107');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '444361000124102,354078009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '312061002,407314008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '61946003,349849001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '416636000');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '432254002,767565001,86977007,60169008,45844004,116596006,350361002,10756001,266717002,109081006,330769006');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '432254002,767565001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '86977007,60169008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '45844004,116596006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '350361002,10756001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '266717002,109081006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '330769006');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '318706009,108940007,81759008,39487003,350553008,421953007,13565005,356076006,350108002,111137007,418528006');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '318706009,108940007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '81759008,39487003');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '350553008,421953007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '13565005,356076006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '350108002,111137007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '418528006');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '16599811000001100,61621000,116092004,116726003,87233003,116523008,108807002,10632007,26244009,77731008,323283001');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '16599811000001100,61621000');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '116092004,116726003');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '87233003,116523008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108807002,10632007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '26244009,77731008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '323283001');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '16403005,363598004,38268001,11847009,350324006,350320002,346441008,327032007,324963001,764135009,135642004,765073001');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '16403005,363598004');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '38268001,11847009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '350324006,350320002');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '346441008,327032007');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '324963001,764135009');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '135642004,765073001');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '407035002,349854005,767562003,10784006,36236003,96220002,321506004,108441004,108443001,15297811000001100,16047007,321174005');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '407035002,349854005');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '767562003,10784006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '36236003,96220002');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '321506004,108441004');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108443001,15297811000001100');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '16047007,321174005');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '30125007,363560004,108418007,703677008,35476001,109054006,266715005,768759001,34012005,28028002,38076006,75770001,363560004');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '30125007,363560004');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '108418007,703677008');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '35476001,109054006');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '266715005,768759001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '34012005,28028002');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '38076006,75770001,363560004');

-- call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '58944007,350631001,319304004,108478001,768761005,81064004,11563006,74226000,764877006,9693501000001103,9427501000001100,9429101000001103');

call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '58944007,350631001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '319304004,108478001');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '768761005,81064004');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '11563006,74226000');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '764877006,9693501000001103');
call populateMedicationOrdersBP2('bp2_medications', 1, '2002-01-01', '9427501000001100,9429101000001103');

END//
DELIMITER ;
