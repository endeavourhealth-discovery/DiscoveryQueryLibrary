USE data_extracts;

-- ahui 28/2/2020

DROP PROCEDURE IF EXISTS populateEastLondonCCGCodesLBHSC;

DELIMITER //

CREATE PROCEDURE populateEastLondonCCGCodesLBHSC()
BEGIN

DROP TABLE IF EXISTS lbhsc_eastlondonccg_codes;

CREATE TABLE lbhsc_eastlondonccg_codes (
name         VARCHAR(100),
local_id     VARCHAR(100),
parent       VARCHAR(100)
);

ALTER TABLE lbhsc_eastlondonccg_codes ADD INDEX ccg_local_idx(local_id);

INSERT INTO lbhsc_eastlondonccg_codes (name, local_id, parent)
VALUES
('Allerton Road Medical Centre','F84716','City & Hackney CCG'),
('Athena Medical Centre','F84060','City & Hackney CCG'),
('Barretts Grove Surgery','F84636','City & Hackney CCG'),
('Barton House Group Practice','F84008','City & Hackney CCG'),
('BEECHWOOD MEDICAL CENTRE','F84038','City & Hackney CCG'),
('Cranwich Road Surgery','F84686','City & Hackney CCG'),
('De Beauvoir Surgery','F84072','City & Hackney CCG'),
('Dr Tahalani and Partners','F84041','City & Hackney CCG'),
('Elm Practice','F84685','City & Hackney CCG'),
('Elsdale Street Surgery','F84601','City & Hackney CCG'),
('GADHVI PRACTICE','F84080','City & Hackney CCG'),
('Greenhouse','F84632','City & Hackney CCG'),
('HEALY MEDICAL CENTRE','F84720','City & Hackney CCG'),
('KINGSMEAD HEALTHCARE','F84015','City & Hackney CCG'),
('Latimer Health Centre','F84719','City & Hackney CCG'),
('London Fields Medical Centre','F84021','City & Hackney CCG'),
('Lower Clapton Group Practice','F84003','City & Hackney CCG'),
('Nightingale Practice','F84018','City & Hackney CCG'),
('Queensbridge Group Practice','F84117','City & Hackney CCG'),
('Richmond Road Medical Centre','F84035','City & Hackney CCG'),
('Rosewood Practice','F84711','City & Hackney CCG'),
('Sandringham Practice','F84621','City & Hackney CCG'),
('Shoreditch Park Surgery','F84635','City & Hackney CCG'),
('Somerford Grove Practice','F84033','City & Hackney CCG'),
('Spring Hill Practice','Y03049','City & Hackney CCG'),
('Stamford Hill Group Practice','F84013','City & Hackney CCG'),
('The Cedar Practice','F84036','City & Hackney CCG'),
('The Clapton Surgery','F84668','City & Hackney CCG'),
('The Dalston Practice','F84063','City & Hackney CCG'),
('The Heron Practice','F84119','City & Hackney CCG'),
('THE HOXTON SURGERY','F84692','City & Hackney CCG'),
('The Lawson Practice','F84096','City & Hackney CCG'),
('The Lea Surgery','F84105','City & Hackney CCG'),
('The Neaman Practice','F84640','City & Hackney CCG'),
('The Riverside Practice','F84619','City & Hackney CCG'),
('The Statham Grove Surgery','F84115','City & Hackney CCG'),
('The Surgery (Brooke Road)','F84694','City & Hackney CCG'),
('The Wick Health Centre','F84620','City & Hackney CCG'),
('Trowbridge Surgery','Y00403','City & Hackney CCG'),
('Well Street Surgery','F84069','City & Hackney CCG'),
('Abbey Road Medical Practice','F84111','Newham CCG'),
('Albert Road Surgery','Y02928','Newham CCG'),
('BALAAM STREET PRACTICE','F84681','Newham CCG'),
('Birchdale Road Medical Centre','F84641','Newham CCG'),
('BOLEYN MEDICAL CENTRE','F84050','Newham CCG'),
('Boleyn Road Practice','F84734','Newham CCG'),
('Claremont Clinic','F84097','Newham CCG'),
('Cumberland Medical Centre','F84657','Newham CCG'),
('CUSTOM HOUSE SURGERY','F84047','Newham CCG'),
('Dr Bhadra''S Surgery','F84729','Newham CCG'),
('DR CM PATEL''S SURGERY','F84660','Newham CCG'),
('DR N DRIVER AND PARTNERS','F84086','Newham CCG'),
('DR PCL KNIGHT','F84730','Newham CCG'),
('DR PI ABIOLA','F84631','Newham CCG'),
('Dr R Samuel & Partner','F84077','Newham CCG'),
('DR SKS SWEDAN','F84706','Newham CCG'),
('DR T KRISHNAMURTHY','F84741','Newham CCG'),
('DR T LWIN','F84708','Newham CCG'),
('E12 HEALTH','F84121','Newham CCG'),
('E12 MEDICAL CENTRE','F84739','Newham CCG'),
('EAST END MEDICAL CENTRE','F84677','Newham CCG'),
('ESSEX LODGE','F84052','Newham CCG'),
('Glen Road Medical Centre','F84092','Newham CCG'),
('GREENGATE MEDICAL CENTRE','F84053','Newham CCG'),
('LANTERN HEALTH-CARPENTERS PRACTICE','F84749','Newham CCG'),
('Lathom Road Medical Centre','F84070','Newham CCG'),
('Leytonstone Road Medical Centre','F84672','Newham CCG'),
('Lucas Avenue Practice','F84642','Newham CCG'),
('MARKET STREET HEALTH GROUP','F84004','Newham CCG'),
('NEWHAM MEDICAL CENTRE','F84669','Newham CCG'),
('NEWHAM TRANSITIONAL PRACTICE','F84740','Newham CCG'),
('Plashet Medical Centre','F84088','Newham CCG'),
('Royal Docks Medical Practice','F84717','Newham CCG'),
('SANGAM SURGERY','F84658','Newham CCG'),
('Shrewsbury Road Surgery','F84006','Newham CCG'),
('Sir Ludwig Guttmann Health Centre','Y04273','Newham CCG'),
('St Luke''S Medical Centre','F84666','Newham CCG'),
('ST. BARTHOLOMEWS SURGERY','F84010','Newham CCG'),
('Star Lane Medical Centre','F84017','Newham CCG'),
('STRATFORD HEALTH CENTRE','F84022','Newham CCG'),
('Stratford Village Surgery','F84009','Newham CCG'),
('The Azad Practice','F84735','Newham CCG'),
('The Project Surgery','F84124','Newham CCG'),
('THE SUMMIT PRACTICE','F84742','Newham CCG'),
('The Upton Lane Medical Centre','F84014','Newham CCG'),
('The Westbury Road Medical Practice','F84670','Newham CCG'),
('TOLLGATE MEDICAL CENTRE','F84093','Newham CCG'),
('Venugopal RS','F84673','Newham CCG'),
('Woodgrange Medical Practice','F84724','Newham CCG'),
('Wordsworth Health Centre','F84074','Newham CCG'),
('Aberfeldy Practice','F84698','Tower Hamlets CCG'),
('ALBION HEALTH CENTRE','F84012','Tower Hamlets CCG'),
('Bethnal Green Health Centre','F84083','Tower Hamlets CCG'),
('Brayford Square Surgery','F84046','Tower Hamlets CCG'),
('Chrisp Street Health Centre','F84062','Tower Hamlets CCG'),
('CITY WELLBEING PRACTICE','F84114','Tower Hamlets CCG'),
('DOCKLANDS MEDICAL CENTRE','F84656','Tower Hamlets CCG'),
('EAST ONE HEALTH','F84682','Tower Hamlets CCG'),
('Globe Town Surgery','F84123','Tower Hamlets CCG'),
('Gough Walk Practice','F84025','Tower Hamlets CCG'),
('Harford Health Centre','F84087','Tower Hamlets CCG'),
('HARLEY GROVE MEDICAL CTR.','F84044','Tower Hamlets CCG'),
('Health E1','F84733','Tower Hamlets CCG'),
('ISLAND HEALTH','F84710','Tower Hamlets CCG'),
('JUBILEE STREET PRACTICE','F84031','Tower Hamlets CCG'),
('Merchant Street Surgery','F84118','Tower Hamlets CCG'),
('Pollard Row Practice APMS','Y00212','Tower Hamlets CCG'),
('ROSERTON STREET SURGERY','F84647','Tower Hamlets CCG'),
('Ruston Street Clinic','F84030','Tower Hamlets CCG'),
('St Andrews Health Centre','Y03023','Tower Hamlets CCG'),
('St Pauls Way Medical Centre','F84714','Tower Hamlets CCG'),
('St Stephen''S Health Centre','F84034','Tower Hamlets CCG'),
('ST. KATHERINE''S DOCK PRACTICE','F84731','Tower Hamlets CCG'),
('Stroudley Walk Health Centre','F84676','Tower Hamlets CCG'),
('STROUTS PLACE MEDICAL CENTRE','F84051','Tower Hamlets CCG'),
('THE BARKANTINE PRACTICE','F84747','Tower Hamlets CCG'),
('The Blithehale Medical Centre','F84718','Tower Hamlets CCG'),
('The Grove Road Surgery','F84055','Tower Hamlets CCG'),
('The Limehouse Practice','F84054','Tower Hamlets CCG'),
('The Mission Practice','F84016','Tower Hamlets CCG'),
('THE SPITALFIELDS PRACTICE','F84081','Tower Hamlets CCG'),
('The Tredegar Practice','F84696','Tower Hamlets CCG'),
('THE WAPPING GROUP PRACTICE','F84079','Tower Hamlets CCG'),
('Whitechapel Health Centre','F84039','Tower Hamlets CCG'),
('XX Place Surgery','F84122','Tower Hamlets CCG'),
('Addison Road Medical Practice','F86607','Waltham Forest CCG'),
('Chingford Medical Practice','Y01291','Waltham Forest CCG'),
('CHURCHILL MEDICAL CENTRE','F86627','Waltham Forest CCG'),
('Claremont Medical Centre','F86708','Waltham Forest CCG'),
('Crawley Road Medical Centre','F86044','Waltham Forest CCG'),
('Dr Dhital Practice','F86086','Waltham Forest CCG'),
('Dr Mohamed Green Man Medical Centre','F86621','Waltham Forest CCG'),
('Dr Shantir Practice','F86626','Waltham Forest CCG'),
('Francis Road Medical Centre','F86696','Waltham Forest CCG'),
('Hampton Medical Practice','F86712','Waltham Forest CCG'),
('Harrow Road GP Practice','F86666','Waltham Forest CCG'),
('High Road Surgery','F86045','Waltham Forest CCG'),
('Higham Hill Medical Centre','F86679','Waltham Forest CCG'),
('KINGS HEAD MEDICAL PRACTICE','F86700','Waltham Forest CCG'),
('Kiyani Medical Practice','F86701','Waltham Forest CCG'),
('Langthorne Health Centre','F86625','Waltham Forest CCG'),
('Langthorne Sharma Family Practice','F86705','Waltham Forest CCG'),
('Larkshall Medical Centre','F86664','Waltham Forest CCG'),
('Lime Tree Surgery','F86650','Waltham Forest CCG'),
('Orient Practice','Y02585','Waltham Forest CCG'),
('Queens Road Medical Centre','F86030','Waltham Forest CCG'),
('Seymour Medical Centre','F86006','Waltham Forest CCG'),
('Sinnott Road Surgery','Y01839','Waltham Forest CCG'),
('SMA Medical Practice','F86038','Waltham Forest CCG'),
('The Allum Medical Centre','F86036','Waltham Forest CCG'),
('The Bailey Practice','F86689','Waltham Forest CCG'),
('The Firs','F86001','Waltham Forest CCG'),
('The Grove Medical Centre','F86062','Waltham Forest CCG'),
('The Lyndhurst Surgery','F86088','Waltham Forest CCG'),
('The Manor Practice','F86011','Waltham Forest CCG'),
('The Old Church Surgery','F86616','Waltham Forest CCG'),
('The Penrhyn Surgery','F86005','Waltham Forest CCG'),
('The Ridgeway Surgery','F86078','Waltham Forest CCG'),
('The St James Practice','F86058','Waltham Forest CCG'),
('WALTHAM FOREST COMM & FAM HTH SERV LTD','F86644','Waltham Forest CCG'),
('Handsworth Medical Practice','F86004','Waltham Forest CCG'),
('LEYTON HEALTHCARE 4TH FLOOR','F86074','Waltham Forest CCG'),
('THE ECCLESBOURNE PRACTICE','F86018','Waltham Forest CCG'),
('THE FOREST SURGERY','F86026','Waltham Forest CCG'),
('The Microfaculty','F86638','Waltham Forest CCG');

END//
DELIMITER ;