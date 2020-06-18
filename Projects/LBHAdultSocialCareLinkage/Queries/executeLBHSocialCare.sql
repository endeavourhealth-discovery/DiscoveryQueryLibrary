USE data_extracts;

-- ahui 10/03/2020

DROP PROCEDURE IF EXISTS executeLBHSocialCare;

DELIMITER //
CREATE PROCEDURE executeLBHSocialCare()
BEGIN
           
-- Latest PracticeCode             
-- Latest RegistrationDate 

DROP TEMPORARY TABLE IF EXISTS reg_sort;
DROP TEMPORARY TABLE IF EXISTS qry_reg;

CREATE TEMPORARY TABLE qry_reg AS
SELECT c.group_by,
       c.person_id,
       e.date_registered,
       e.date_registered_end,
       o.name,
       o.ods_code
FROM cohort_lbhsc c 
  JOIN enterprise_pseudo.episode_of_care e ON e.person_id = c.person_id 
  JOIN enterprise_pseudo.organization o ON o.id = e.organization_id
WHERE EXISTS (SELECT 'x' FROM lbhsc_eastlondonccg_codes ccgs
              WHERE ccgs.parent IN ('City & Hackney CCG','Newham CCG','Tower Hamlets CCG', 'Waltham Forest CCG') AND ccgs.local_id = o.ods_code);

CREATE TEMPORARY TABLE reg_sort AS
SELECT a.group_by,
       a.person_id,
       a.date_registered,
       a.date_registered_end,
       a.ods_code,       
       a.name,
       a.rnk
FROM (SELECT q.group_by, 
             q.person_id, 
             q.date_registered, 
             q.date_registered_end, 
             q.name, 
             q.ods_code,
             @currank := IF(@curperson = q.person_id, @currank + 1, 1) AS rnk,
             @curperson := q.person_id AS cur_person
      FROM qry_reg q, (SELECT @currank := 0, @curperson := 0) r 
      ORDER BY q.person_id, q.date_registered DESC ) a
WHERE a.rnk = 1;

UPDATE lbhsc_dataset l JOIN reg_sort reg ON l.pseudo_id = reg.group_by
SET l.RegistrationDate = reg.date_registered,
    l.PracticeCode = reg.ods_code;

DROP TEMPORARY TABLE IF EXISTS reg_sort;
DROP TEMPORARY TABLE IF EXISTS qry_reg;

-- Gender   
-- 0 = Male 
-- 1 = Female 
-- 2 = Other 
-- 3 = Unknown
-- AgeIndexDate    
-- Lsoa11  
-- YearofDeath    

UPDATE lbhsc_dataset l
  JOIN enterprise_pseudo.patient p ON p.pseudo_id = l.pseudo_id
 SET
     l.AgeIndexDate = p.age_years - (YEAR(now()) - YEAR(DATE_FORMAT("2017-04-01", "%Y-%m-%d"))),  -- age at index date 1/4/2017
     l.Lsoa11 = p.lsoa_code,
     l.gender = CASE p.patient_gender_id WHEN 0 THEN 'M' WHEN 1 THEN 'F' WHEN 2 THEN 'O' ELSE 'U' END,
     l.YearofDeath = YEAR(p.date_of_death)
WHERE EXISTS (SELECT 'x' FROM lsoa_lookup lso WHERE lso.code = p.lsoa_code);

-- EthnicityCode            
CALL populateLBHSCValueDateUnitDataset(1,'Ethnicity','lbhsc_dataset','92381000000106,976571000000100',null,null,'92381000000106,976571000000100','N','N','N','Y','Y');

-- Interpreter  
CALL populateBHSCBinDataset(1,'Interpreter','lbhsc_dataset',null,'315593009',null,null,'N','Y','N');

-- MainLanguage
CALL populateLBHSCValueDateUnitDataset(1,'MainLanguage','lbhsc_dataset','370157003',null,null,'370157003','N','N','N','Y','Y');

-- Housebound 
CALL populateBHSCBinDataset(1,'Housebound','lbhsc_dataset',null,'160689007',null,null,'N','Y','N');

-- Carehome                 
CALL populateLBHSCValueDateUnitDataset(1,'Carehome','lbhsc_dataset',null,'250560019,394923006',null,null,'N','N','N','Y','Y');

-- LivesAlone 
CALL populateBHSCBinDataset(1,'LivesAlone','lbhsc_dataset','105529008',null,null,null,'N','Y','N');

-- Homeless    
CALL populateLBHSCValueDateUnitDataset(1,'Homeless','lbhsc_dataset','224228000,365510008,160701002','381751000000106',null,'365510008,160701002','N','N','N','Y','Y');

-- Smoker
CALL populateBHSCBinDataset(1,'Smoker','lbhsc_dataset',null,'446172000,160612007,413173009,394873005,394872000,401159003,77176002,225934006,134406006,394871007,266918002,365982000,160616005,203191000000107,56771006,230060001,56578002,230059006,449868002,401201003,1092481000000104,266927001',null,'401201003,1092481000000104,266927001','N','Y','N');

-- AlcoholConsumption      
CALL populateLBHSCValueDateUnitDataset(1,'AlcoholConsumption','lbhsc_dataset',null,'105542008,266917007,228276006,160575005,160576006,160577002,160578007,160579004,160580001,413968004,160582009,777631000000108,160583004,228310006,15167005,198431000000105,198421000000108,228315001,228279004,43783005,228277002,105542008,160593006,160592001,160587003,160588008,160589000,160591008,160590009,858861000000101',null,null,'N','N','N','Y','Y');

-- Audit
CALL populateLBHSCValueDateUnitDataset(1,'Audit','lbhsc_dataset',null,'273265007',null,null,'N','Y','N','N','Y');

-- AuditC    
CALL populateLBHSCValueDateUnitDataset(1,'AuditC','lbhsc_dataset',null,'335811000000106',null,null,'N','Y','N','N','Y');              

-- Substance
CALL populateBHSCBinDataset(0, 'Substance', 'lbhsc_dataset',null,'441681009,268641003,724656006,75544000,442406005,741063003,228388006,365985003,266707007,268640002,21647008,31956009,191829009,191877009,231470001',null,null,'Y','Y','N');

-- BMI
CALL populateLBHSCValueDateUnitDataset(1,'BMI','lbhsc_dataset',null,'301331008',null,null,'Y','Y','N','N','Y');   

-- Cholesterol
CALL populateLBHSCValueDateUnitDataset(1,'Cholesterol','lbhsc_dataset',null,'1005671000000105',null,null,'Y','Y','Y','N','Y');   

-- Blind
CALL populateBHSCBinDataset(0, 'Blind', 'lbhsc_dataset',null,'170727003',null,null,'N','Y','N');
-- Deaf
CALL populateBHSCBinDataset(0, 'Deaf', 'lbhsc_dataset',null,'737050003,737049003,61947007,95828007,164062007,164063002,310542003,285055002,285055002,281656009,761591000000105,95828007',null,null,'N','Y','N');

-- Frailty
CALL populateLBHSCValueDateUnitDataset(0,'Frailty','lbhsc_dataset','248279007','713634000',null,null,'N','N','N','Y','Y'); 

-- LONG TERM CONDITIONS

-- Asthma
CALL populateBHSCBinDataset(0, 'Asthma', 'lbhsc_dataset','195967001,312453004,401193004,395022009,233691007,89099002,11944003,641000119106,1064821000000109,10676031000119106,10676151000119101,10676071000119109,10676191000119106,1064811000000103,10676551000119105,10676631000119100,10676351000119103,10676711000119103,10675591000119109,10675671000119107,162660004',null,'162660004',null,'Y','Y','Y');

-- Af  starts --

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('49436004,5370000,762247006,196371000000102', 1);   
CALL getAllSnomeds (1);

-- snomeds to exclude
CALL storeString ('715560009', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Af', 'lbhsc_dataset',null,null,'196371000000102',null,'Y','N','Y');

-- Af ends --

-- Cancer starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('425111000000106,397141000000100,462461000000100,409231000000104,397641000000107,408911000000106,409171000000109,462401000000104,396181000000106,815011000000107,445105005,884601000000103,373627005,237833006,35868009,92767001,416712009,93450001,188526000,188251003,275524009,427374007,93147005,93148000,93149008,255127006,236005001,235965006,956331000000107,956351000000100,956371000000109,956391000000108,956411000000108,956431000000100,956451000000107,956471000000103,956511000000107,956531000000104,956551000000106,188009001,1090931000000108,363346000,255044008,254855000,30664006,425333006,762316003,404146005,416274001,446643000,448922007,1092831000000100,278065000,16341002,134421000,766752000,253006001,277605001,734065009,713577007,609519004,414823004,421418009,414824005,707594002,721194008,702406000,254624009,236740006,254464000', 1);   
CALL getAllSnomeds (1);

CALL storeString ('416402001,767544007,65399007,129000002,277466009,127021009,126885006,126909004,302835009,767814002,767812003,767818004,767817009,387922007,387927001,767813008,126724001,126906006,126667002,126879004', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude

CALL storeString ('4135001,254654004,238637007,403742006,402524007,402525008,402526009,402527000,402528005,402536001,423463003,423535002,402820007,402519009,402522006,402509003,399897004,403915004,402523001,402521004,254710004,402531006,402530007,402532004,402533009,402534003,254702000,92197001,92408009,92415001,92437008,92487001,447799001,254640007,189140003,92524007,92581002,92637002,92642005,254639005,255131000,92754004,92803008,255068000,254909003,449416001,286891000,372125008,403910009,254652000,403912001,275265005,372129002,423349005,722955006,254703005,254820002,314975005,1090321000000107,188090007,188107002,188127001,188099008,449309003,188089003,188119005,1090311000000101,402652009,402537005,277577000,307340003,403905005,447596005,127270003,127268007,127251008,127252001,127273001,127253006,127240008,127247006,94727003,94902003,94908004,94921006,95111006,95136000,95184009,716274007,403911008,722712000,403946000,447738006,276738009,1082191000119100,403712008,403729006,402538000,422676009,422378004,422572002,403893006,402817004,424260006,403468003,403891008,276860003,285309005,285307007,425148008,423896007,403897007,403914000,403909004,715904005,20447006,237865009,707397008,1079101000119105,94025004,94026003,94028002,94029005,94030000,94032008,449634005,94034009,94035005,94038007,94040002,94041003,94042005,94046008,403898002,285308002,423284006,94007006,94010004,94011000,94013002,94014008,94016005,94017001,94018006,94020009,92178001,234088000', 3);   
CALL getAllSnomeds (3);

CALL storeString ('734065009,713577007,609519004,414823004,421418009,414824005,707594002,721194008,702406000,254624009,236740006,254464000,254701007,276808007,448315008,449211009,372127000,109993000,254727007,239940004,429114002,722688002,254650008,271467005,188103003,372130007,372122006,188110009,188095002,188091006,423425006,443136000,372124007,188100000,372126009,372128005,255096006,363450006,254908006,276750003,445738007,127228008,127255004,127246002,127259005,127260000,127264009,127243005,127262008,127249009,127250009,127267002,127245003,127256003,127229000,127232002,127234001,127233007,127261001,127235000,127274007,127254000,443495005,127248001,127269004,127236004,127258002,127271004,127272006,127237008,127257007,127265005,127238003,127242000,127244004,127230005,127239006,127263003,127241007,127231009,127266006,127227003,126810008,127226007,254898001,415111003,93663003,735917000,93956001,94047004,372123001,94012007,94015009,94021008,94022001,94033003,94036006,94043000,94045007', 4);   
CALL getAllSnomeds (4);

DELETE FROM snomeds WHERE snomed_id IN (92178001,234088000,94902003,92637002) AND cat_id = 3;-- removed the parents from being excluded

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Cancer', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Cancer ends

-- Chd starts -- 

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('314463006,49844009,18352002,198091000000104,723232008,12763006,42689008,24184005,271870002,163033001,723235005,852291000000105,723236006,852301000000109,723237002,2004005,163020007,163023009,313005002,251078009,335661000000109,163035008,163034007,271649006', 1);   -- snomed to include
CALL getAllSnomeds (1);

CALL storeString ('386534000,75367002,271650006,6797001,364090009,386536003,1091811000000102', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('12377007,310357009,310356000,163021006,274283008,708502007,315612005', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Chd', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Chd ends -- 

-- Ckd
CALL populateBHSCBinDataset(0, 'Ckd', 'lbhsc_dataset','433144002,431857002,433146000,939211000000104',null,'939211000000104',null,'Y','Y','Y');
-- Copd
CALL populateBHSCBinDataset(0, 'Copd', 'lbhsc_dataset','195963002,266356006,233723008,89549007,68328006,195957006,360470001,32544004,47895001,233673002,135836000,866901000000103,84409004,77690003,313296004,313297008,49691004,4981000,233674008,233677001,313299006,61937009,233675009,45145000,293991000000106,195959009,941201000000103','10692761000119107,195949008,63480004,13645005,52571006,66987001,185086009,40100001,87433001,196027008','941201000000103',null,'Y','Y','Y');

-- Dementia starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('419261000000107,192818008,279982005,52448006,83157008,278855005,230274000,67155006,13092008,45864009,230284004,713060000,304603007', 1);   -- snomed to include
CALL getAllSnomeds (1);

CALL storeString ('20484008,792004,230273006,230270009', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('40425004,268612007', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Dementia', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Dementia ends

-- Depression starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('467361000000105,455731000000100,401211000000106,430421000000104,465441000000108,397711000000100,397701000000102,83458005,191632009,357705009,698957003,300706003,36923009,231500002,310495003,231504006,310496002,231485007,192049004,765176007,87414006,1086661000000108,191676002,40568001,1089641000000100,1089511000000100,1089631000000109,16265301000119106,268621008,191615005,16264821000119108,84760002,75084000,268620009,191606003,191601008,191602001,764631000000108,196381000000100', 1);   -- snomed to include
CALL getAllSnomeds (1);

CALL storeString ('191659001,192080009,35489007,78667006,370143000,191455000,191616006,247803002,191459006,310497006,73867007,28475009', 2);   -- snomed to include
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('764701000000109', 4);   
CALL getAllSnomeds (4);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Depression', 'lbhsc_dataset',null,null,'196381000000100',null,'Y','N','Y');

-- Depression ends

-- Diabetes starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('11530004,70694009,426705001,75682002,703136005,408540003,385041000000108,111552007,237619009,268519009,421165007,420486006,421779007,368561000119102,237613005,719216001,237599002,237618001,420270002,421750000,735538002,609572000,735539005,426875007,127012008,335621000000101,609562003,237604008,420918009,420436000,422228004,71771000119100,314903002,190390000,190388001,314902007,190389009,190372001,314893005,190369008,314771006,401110002,190368000,237601000,82581000119105,420715001,420514000,421986006,713705003,713706002,43959009,26298008,310505005,422275004,713704004,315051004', 1);   -- snomed to include
CALL getAllSnomeds (1);

CALL storeString ('284449005,73211009,5969009,51002006,737212004,230577008,201724008,127014009,49455004,127013003,4855003,739681000,422099009,5368009,609561005,421326000,421468001,421365002,421893009,420279001,420789003,422034002,8801005,46635009,44054006', 2);   -- snomed to include
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('472699005', 3);   
CALL getAllSnomeds (3);

CALL storeString ('43959009,26298008,310505005,422275004,713704004', 4);   
CALL getAllSnomeds (4);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Diabetes', 'lbhsc_dataset',null,null,'315051004',null,'Y','N','Y');

-- Diabetes ends

-- Epilepsy
CALL populateBHSCBinDataset(0, 'Epilepsy', 'lbhsc_dataset','230391003,230397004,230387008,230405003,230396008,230427007,230416005,230399001,230441003,44423001,230435005,193004006,189198006,192982004,192981006,192991000,192993002,764522009,765089003,13973009,230407006,230428002,290741000119102,307357004,230425004,230418006,230408001,230406002,193022009,193003000,267592003,16873003,230422001,230421008,307356008,230426003,442512002,230400008,230398009,193009001,509341000000107,763349002,361123003,193002005,734434007,230191005,7689009,116401000119105,79745005,230392005,765093009,765170001,230455006,199451000000106,193008009,193011005,230423006,230395007,71831005,230417001,193000002,89525009,162658001','407675009,230415009,241006,84757009,313307000,230394006,65120008,19598007,192979009,230381009,230390002,230404004,230403005,192999003,75023009,267581004,230456007,352818000,28055006','162658001',null,'Y','Y','Y');

-- Hf
CALL populateBHSCBinDataset(0, 'Hf', 'lbhsc_dataset','195114002,92506005,195112003,426611007,233924009,446221000,421518007,314206003,43736008,','10633002,56675007,88805009,42343007,195111005,84114007,703272007,275514001,85232009,128404006,367363000',null,'421518007','Y','Y','N');

-- Hypertension starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('471521000000108,38341003,162659009', 1);  
CALL getAllSnomeds (1);

-- snomeds to exclude
CALL storeString ('429198000,541000119105,237282002,697930002,288250001,41114007,237281009,206596003,307632004,23130000,5501000119106,765182005,40521000119100,46764007,15394000,52698002', 3);   
CALL getAllSnomeds (3);

CALL storeString ('198941007,367390009,697929007,398254007,48194001', 4);   
CALL getAllSnomeds (4);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Hypertension', 'lbhsc_dataset',null,null,'162659009',null,'Y','N','Y');

-- Hypertension ends

-- Ld
CALL populateBHSCBinDataset(0, 'Ld', 'lbhsc_dataset','984661000000105,984671000000103,416075005,984681000000101,508171000000105,931001000000105,889211000000104','1855002',null,null,'Y','Y','N');

-- Smi starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('417601000000102,397711000000100,191538001,191530008,191677006,268624000,274953007,1089691000000105,441704009,191627008,192362008,191632009,767632000,31446002,268622001,61831009,278506006,77475008,63249007,191643001,191525009,307504004,191672000,231487004,60401000119104,231485007,191680007,191683009,231437006,1089511000000100,191613003,1086471000000103,68890003,58214004,31027006,61403008,162004,191670008,191668004,191604000,21071000119101', 1);  
CALL getAllSnomeds (1);

CALL storeString ('278853003,231489001,767633005,13746004,41836007,85248005,767631007,371596008,767636002,83225003,48500005,53607008,231449007,280949006,13313007,191636007,16506000,79584002,69322001,191676002,88975006,4441000,53049002,73867007,28663008,28475009', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('53936005,238978007,238979004,441833000,403595006', 3);   
CALL getAllSnomeds (3);

CALL storeString ('21071000119101', 4);   
CALL getAllSnomeds (4);

DELETE FROM snomeds WHERE cat_id = 3 AND snomed_id = 53936005;

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Smi', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Smi ends

-- Obese starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('414915002', 1);  
CALL getAllSnomeds (1);

-- snomeds to exclude
CALL storeString ('414916001', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Obese', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Obese ends

-- Osteporosis starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('425371000000103,311890007,311891006,53174001,14651005,3345002,268028001,735618008,203437004,309745002,203657009,240198002,203433000,203434006,276661002,240157009,203438009', 1);  
CALL getAllSnomeds (1);

CALL storeString ('64859006,203452006,203450003,203451004,443165006', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('240156000', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Osteporosis', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Osteporosis ends

-- Palliative starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('854021000000106,718898004,718904006,718899007,718895001,718890006,718893008,718901003,718903000,1099101000000108,514591000000108,846841000000101,840351000000109,1095081000000100,1095161000000105,1095091000000103,847771000000100,1025611000000105,713058002,395103003,1095151000000107,1034241000000106,719238004,719240009,713673000,874311000000104,511401000000102,707988003,968211000000101,955231000000109,873411000000105,783941000000105,1095131000000100,526631000000108,414937009,818221000000103,103735009,846161000000108,1841000124106,901741000000103,1092801000000106,902471000000105,845021000000105,840071000000102,840331000000102,761866001,871021000000106,183595007,183569005,783841000000101,1091311000000108,306288008,306237005,25411000000109,305824005,305686008,162608008,305496007,201511000000105,850951000000107', 1);  
CALL getAllSnomeds (1);

CALL storeString ('182964004', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('845701000000104', 3);   
CALL getAllSnomeds (3);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Palliative', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Palliative ends

-- Pad
CALL populateBHSCBinDataset(0, 'Pad', 'lbhsc_dataset','275520000,836711000000108','63491006,233961000,399957001,233958001,400047006',null,null,'Y','Y','N');

-- Ra starts

-- clear out snomeds table
DELETE FROM snomeds WHERE cat_id IN (1,2,3,4);
-- clear out store table
DELETE FROM store WHERE id IN (1,2,3,4);

-- snomeds to include
CALL storeString ('96531000119109,1073891000119106,1073881000119108,10713006,69896004,201788009,398726004,195136004',1);  
CALL getAllSnomeds (1);

CALL storeString ('33719002', 2);   
CALL getAllSnomeds (2);

-- snomeds to exclude
CALL storeString ('143441000119108', 3);   
CALL getAllSnomeds (3);

CALL storeString ('96531000119109', 4);   
CALL getAllSnomeds (4);

CREATE TEMPORARY TABLE snomeds_tmp AS
SELECT cat_id, snomed_id
FROM snomeds 
WHERE cat_id IN (3,4);

DELETE t1 FROM snomeds t1 JOIN snomeds_tmp t2 ON t1.snomed_id = t2.snomed_id
WHERE t1.cat_id IN (1,2);

DELETE FROM snomeds WHERE cat_id IN (3,4);

DROP TEMPORARY TABLE snomeds_tmp;

CALL populateBHSCBinDataset(0, 'Ra', 'lbhsc_dataset',null,null,null,null,'Y','N','N');

-- Ra ends

-- Stroke
CALL populateBHSCBinDataset(0, 'Stroke', 'lbhsc_dataset','195210002,230693009,195212005,195230003,1089411000000104,1089421000000105,329461000119102,25133001,49422009,230691006,371041009,297138001,734961002,734963004,281240008,195167002,732923001,230706003,230692004,140921000119102,230712008,230698000,413102000,52201006,276722003,195169004,195216008,307766002,230710000,230709005,195209007,111297002,329491000119109,329571000119107,329481000119106,329561000119101,373606000,116288000,195211003,230696001,57981008,444172003,195217004,307767006,308128006,291541000119104,291531000119108,724429004,275434003,230713003,20908003,90099008,15978431000119106,371040005,426814001,195200006,195205001,195206000,195201005,751371000000107,34781003,195199008,230717002,699706000,705129007','16218291000119100,195165005,95454007,75038005,16371781000119100,20059004,75543006,274100004,432504007,195190007,125081000119106,195189003,71444005,7713009,230704000,230690007,230711001,230716006,15258001,266257000',null,'699706000,705129007','Y','Y','N');
-- Glaucoma
CALL populateBHSCBinDataset(0, 'Glaucoma', 'lbhsc_dataset','23986001',null,null,null,'Y','Y','N');
-- Hiv
CALL populateBHSCBinDataset(0, 'Hiv', 'lbhsc_dataset',null,'165816005,86406008,81000119104',null,null,'Y','Y','N');
-- Hepb
CALL populateBHSCBinDataset(0, 'Hepb', 'lbhsc_dataset','61977001,66071002',null,null,null,'Y','Y','N');
-- Hepc
CALL populateBHSCBinDataset(0, 'Hepc', 'lbhsc_dataset','128302006,50711007',null,null,null,'Y','Y','N');
-- Ibd
CALL populateBHSCBinDataset(0, 'Ibd', 'lbhsc_dataset','24526004',null,null,null,'Y','Y','N');
-- Liver
CALL populateBHSCBinDataset(0, 'Liver', 'lbhsc_dataset',null,'303376017,197279005,50325005, 9953008,420054005,76301009,419728003,41309000,76783007,419728003,4044018,235875008,79720007,197269008,197274000,59927004,34742003,27916005,67656006,235856003',null,null,'Y','Y','N');
-- Mnd
CALL populateBHSCBinDataset(0, 'Mnd', 'lbhsc_dataset','37340000',null,null,null,'Y','Y','N');
-- Ms
CALL populateBHSCBinDataset(0, 'Ms', 'lbhsc_dataset','24700007',null,null,null,'Y','Y','N');
-- Md
CALL populateBHSCBinDataset(0, 'Md', 'lbhsc_dataset','240070002','111501005,193225000,78468005,193222002,43152001,82077006,82077006,75072002,73297009,76670001,76670001,193227008,93153005,387732009,67747009',null,null,'Y','Y','N');
-- Parkinson
CALL populateBHSCBinDataset(0, 'Parkinson', 'lbhsc_dataset','49049000','907151000000108,862081000000106,341551000000108',null,null,'Y','Y','N');
-- Backpain
CALL populateBHSCBinDataset(0, 'Backpain', 'lbhsc_dataset','278860009,134407002,136791000119103,247366003,631000119102',null,null,null,'Y','Y','N');
-- Gout
CALL populateBHSCBinDataset(0, 'Gout', 'lbhsc_dataset','90560007',null,null,null,'Y','Y','N');
-- Sickle
CALL populateBHSCBinDataset(0, 'Sickle', 'lbhsc_dataset','417357006',null,null,null,'Y','Y','N');
-- Thyroid
CALL populateBHSCBinDataset(0, 'Thyroid', 'lbhsc_dataset','14304000',null,null,null,'Y','Y','N');
   
-- Countltc (count of long term conditions)

DROP TEMPORARY TABLE IF EXISTS cnt_qry;

CREATE TEMPORARY TABLE cnt_qry (
  pseudo_id      VARCHAR(255),
  countltc       INT, INDEX pseudo_idx (pseudo_id))
SELECT cnt.pseudo_id AS pseudo_id,
       (cnt.Asthma + cnt.Af + cnt.Cancer + cnt.Chd + cnt.Ckd + cnt.Copd + cnt.Dementia + cnt.Depression + cnt.Diabetes + 
        cnt.Epilepsy + cnt.Hf + cnt.Hypertension + cnt.Ld + cnt.Smi + cnt.Obese + cnt.Osteporosis + cnt.Palliative + cnt.Pad + 
        cnt.Ra + cnt.Stroke + cnt.Glaucoma + cnt.Hiv + cnt.Hepb + cnt.Hepc + cnt.Ibd + cnt.Liver + 
        cnt.Mnd + cnt.Ms + cnt.Md + cnt.Parkinson + cnt.Backpain + cnt.Gout + cnt.Sickle + cnt.Thyroid ) AS countltc
FROM (
SELECT
 pseudo_id
,IF(Asthma = 'Y',1,0)Asthma       
,IF(Af = 'Y',1,0) Af            
,IF(Cancer = 'Y',1,0) Cancer        
,IF(Chd = 'Y',1,0) Chd          
,IF(Ckd = 'Y',1,0) Ckd          
,IF(Copd = 'Y',1,0) Copd         
,IF(Dementia = 'Y',1,0) Dementia     
,IF(Depression = 'Y',1,0) Depression   
,IF(Diabetes = 'Y',1,0) Diabetes     
,IF(Epilepsy = 'Y',1,0) Epilepsy     
,IF(Hf = 'Y',1,0) Hf           
,IF(Hypertension = 'Y',1,0) Hypertension 
,IF(Ld = 'Y',1,0) Ld           
,IF(Smi = 'Y',1,0) Smi          
,IF(Obese = 'Y',1,0) Obese         
,IF(Osteporosis = 'Y',1,0) Osteporosis  
,IF(Palliative = 'Y',1,0) Palliative    
,IF(Pad = 'Y',1,0) Pad           
,IF(Ra = 'Y',1,0) Ra            
,IF(Stroke = 'Y',1,0) Stroke       
,IF(Glaucoma = 'Y',1,0) Glaucoma     
,IF(Hiv = 'Y',1,0) Hiv          
,IF(Hepb = 'Y',1,0) Hepb          
,IF(Hepc = 'Y',1,0) Hepc          
,IF(Ibd = 'Y',1,0)  Ibd          
,IF(Liver = 'Y',1,0) Liver        
,IF(Mnd = 'Y',1,0) Mnd           
,IF(Ms = 'Y',1,0) Ms           
,IF(Md = 'Y',1,0) Md           
,IF(Parkinson = 'Y',1,0) Parkinson    
,IF(Backpain = 'Y',1,0) Backpain     
,IF(Gout = 'Y',1,0) Gout         
,IF(Sickle = 'Y',1,0) Sickle       
,IF(Thyroid = 'Y',1,0) Thyroid
FROM lbhsc_dataset) cnt;

UPDATE lbhsc_dataset ld JOIN cnt_qry c ON ld.pseudo_id = c.pseudo_id
SET ld.Countltc = c.countltc;

DROP TEMPORARY TABLE IF EXISTS cnt_qry;

-- HEALTHCARE USE

-- GpsurgeryCount 

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM ( SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
       FROM cohort_lbhsc_encounter_raw e JOIN cohort_lbhsc cr ON e.person_id = cr.person_id
       WHERE EXISTS (SELECT 'x' FROM gpEncounters f WHERE f.term = e.fhir_original_term) 
       AND e.clinical_effective_date IS NOT NULL
       AND e.fhir_original_term IS NOT NULL   
       GROUP BY cr.group_by) b, (SELECT @row_no := 0) t; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE lbhsc_dataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by 
        SET d.GpsurgeryCount = q.visits WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000; 
        
        SET @row_id = @row_id + 1000;
        
END WHILE;

-- GptelCount   

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM ( SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
       FROM cohort_lbhsc_encounter_raw e JOIN cohort_lbhsc cr ON e.person_id = cr.person_id
       WHERE EXISTS (SELECT 'x' FROM phoneEncounters f WHERE f.term = e.fhir_original_term) 
       AND e.clinical_effective_date IS NOT NULL
       AND e.fhir_original_term IS NOT NULL   
       GROUP BY cr.group_by) b, (SELECT @row_no := 0) t; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE lbhsc_dataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by 
        SET d.GptelCount = q.visits WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000; 
        
        SET @row_id = @row_id + 1000;
        
END WHILE;
   
-- GphomeCount

DROP TEMPORARY TABLE IF EXISTS qry_tmp;

CREATE TEMPORARY TABLE qry_tmp (
       row_id      INT,
       group_by    VARCHAR(255),
       visits      INT, PRIMARY KEY(row_id) ) AS
SELECT (@row_no := @row_no + 1) AS row_id, 
       b.group_by,
       b.visits
FROM ( SELECT cr.group_by AS group_by, COUNT(DISTINCT e.clinical_effective_date) AS visits
       FROM cohort_lbhsc_encounter_raw e JOIN cohort_lbhsc cr ON e.person_id = cr.person_id
       WHERE EXISTS (SELECT 'x' FROM homeEncounters f WHERE f.term = e.fhir_original_term) 
       AND e.clinical_effective_date IS NOT NULL
       AND e.fhir_original_term IS NOT NULL   
       GROUP BY cr.group_by) b, (SELECT @row_no := 0) t; 

SET @row_id = 0;

WHILE EXISTS (SELECT row_id from qry_tmp WHERE row_id > @row_id AND row_id <= @row_id + 1000) DO

        UPDATE lbhsc_dataset d JOIN qry_tmp q ON d.pseudo_id = q.group_by 
        SET d.GphomeCount = q.visits WHERE q.row_id > @row_id AND q.row_id <= @row_id + 1000; 
        
        SET @row_id = @row_id + 1000;
        
END WHILE;

-- AedCount       
-- AdmissionsCount 

END//
DELIMITER ;
