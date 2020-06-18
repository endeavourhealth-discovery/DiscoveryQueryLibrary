USE data_extracts;

DROP PROCEDURE IF EXISTS executeBartsPancreas11MedicationsBP1;

DELIMITER //
CREATE PROCEDURE executeBartsPancreas11MedicationsBP1()
BEGIN

-- All since 2010

-- CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '420804003,41549009,14601000,108914001,349917000,421552005,90332006,360204007,7947003,91107009,373265006,74674007,6425004,372813008,67507000,346325008,6369005,372862008,81839001,255632006,63094006,373253007,372576002,108925005,96308008,108616001,373267003,57952007,80229008,1039008,56602009,372560006,373293005,8696009,411399003,41193000,768625006,33252009,108899006,108836002,372580007,768451002,48698004,108812001,320933002,768769007,330811006,409391006,18037511000001105,385610007,372684006,30492008,372695000,384952006,764132007,444381000124107,444361000124102,354078009,312061002,407314008,61946003,349849001,416636000,432254002,767565001,86977007,60169008,45844004,373258003,116596006,350361002,10756001,266717002,109081006,330769006,318706009,108940007,81759008,39487003,350553008,421953007,61621000,372800002,116092004,116726003,87233003,116523008,108807002,10632007,26244009,77731008,323283001,372665008,16403005,346441008,327032007,324963001,764135009,135642004,765073001,373209002,418183005,10784006,36236003,15297811000001100,16047007,321174005,30125007,53640004,363560004,108418007,703677008,35476001,109054006,315053001,266715005,768759001,34012005,28028002,38076006,75770001,372881000,322822007,58944007,372787008,768761005,81064004,11563006,74226000,764877006,');

CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '420804003,41549009');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '14601000,108914001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '349917000,421552005');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '90332006,360204007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '7947003,91107009');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '373265006,74674007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '6425004,372813008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '67507000,346325008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '6369005,372862008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '81839001,255632006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '63094006,373253007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '372576002,108925005');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '96308008,108616001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '373267003,57952007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '80229008,1039008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '56602009,372560006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '373293005,8696009');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '411399003,41193000');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '768625006,33252009');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '108899006,108836002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '372580007,768451002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '48698004,108812001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '320933002,768769007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '330811006,409391006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '18037511000001105');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '385610007,372684006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '30492008,372695000');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '384952006,764132007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '444381000124107,444361000124102');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '354078009,312061002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '407314008,61946003');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '349849001,416636000');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '432254002,767565001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '86977007,60169008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '45844004,373258003');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '116596006,350361002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '10756001,266717002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '109081006,330769006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '318706009,108940007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '81759008,39487003');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '350553008,421953007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '61621000,372800002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '116092004,116726003');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '87233003,116523008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '108807002,10632007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '26244009,77731008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '323283001,372665008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '16403005,346441008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '327032007,324963001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '764135009,135642004');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '765073001,373209002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '418183005,10784006');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '36236003,15297811000001100');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '16047007,321174005');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '30125007,53640004');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '363560004,108418007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '703677008,35476001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '109054006,315053001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '266715005,768759001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '34012005,28028002');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '38076006,75770001');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '372881000,322822007');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '58944007,372787008');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '768761005,81064004');
CALL populateMedicationOrdersBP1('bp1_medications', 1, '2010-01-01', '11563006,74226000,764877006');


END//
DELIMITER ;
