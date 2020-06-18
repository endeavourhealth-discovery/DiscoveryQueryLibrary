USE data_extracts;

-- ahui 10/03/2020

DROP PROCEDURE IF EXISTS createLBHSocialCareDataset;

DELIMITER //

CREATE PROCEDURE createLBHSocialCareDataset()
BEGIN


DROP TABLE IF EXISTS lbhsc_dataset;

CREATE TABLE lbhsc_dataset (
Pseudo_Id                VARCHAR(255),
Pseudo_NHSNumber         VARCHAR(255),
PracticeCode             VARCHAR(100),
RegistrationDate         VARCHAR(100),
Gender                   VARCHAR(100),
AgeIndexDate             VARCHAR(100),
YearofDeath              VARCHAR(100),
Lsoa11                   VARCHAR(100),
EthnicityTerm            VARCHAR(200),
Interpreter              VARCHAR(1) DEFAULT 'N',
MainLanguageTerm         VARCHAR(200),
Housebound               VARCHAR(1) DEFAULT 'N',
CarehomeTerm             VARCHAR(200),
LivesAlone               VARCHAR(1) DEFAULT 'N',
HomelessTerm             VARCHAR(200),
Smoker                   VARCHAR(1) DEFAULT 'N',
AlcoholConsumptionTerm   VARCHAR(200),
AuditValue               VARCHAR(100),
AuditCValue              VARCHAR(100),
Substance                VARCHAR(1) DEFAULT 'N',
SubstanceDate            VARCHAR(100),
BmiValue                 VARCHAR(100),
BmiDate                  VARCHAR(100),
CholesterolValue         VARCHAR(100),
CholesterolDate          VARCHAR(100),
CholesterolUnit          VARCHAR(100),
Blind                    VARCHAR(1) DEFAULT 'N',
Deaf                     VARCHAR(1) DEFAULT 'N',
FrailtyTerm              VARCHAR(200),
Asthma                   VARCHAR(1) DEFAULT 'N',
AsthmaDate               VARCHAR(100),
Af                       VARCHAR(1) DEFAULT 'N',
AfDate                   VARCHAR(100),
Cancer                   VARCHAR(1) DEFAULT 'N',
CancerDate               VARCHAR(100),
Chd                      VARCHAR(1) DEFAULT 'N',
ChdDate                  VARCHAR(100),
Ckd                      VARCHAR(1) DEFAULT 'N',
CkdDate                  VARCHAR(100),
Copd                     VARCHAR(1) DEFAULT 'N',
CopdDate                 VARCHAR(100),
Dementia                 VARCHAR(1) DEFAULT 'N',
DementiaDate             VARCHAR(100),
Depression               VARCHAR(1) DEFAULT 'N',
DepressionDate           VARCHAR(100),
Diabetes                 VARCHAR(1) DEFAULT 'N',
DiabetesDate             VARCHAR(100),
Epilepsy                 VARCHAR(1) DEFAULT 'N',
EpilepsyDate             VARCHAR(100),
Hf                       VARCHAR(1) DEFAULT 'N',
HfDate                   VARCHAR(100),
Hypertension             VARCHAR(1) DEFAULT 'N',
HypertensionDate         VARCHAR(100),
Ld                       VARCHAR(1) DEFAULT 'N',
LdDate                   VARCHAR(100),
Smi                      VARCHAR(1) DEFAULT 'N',
SmiDate                  VARCHAR(100),
Obese                    VARCHAR(1) DEFAULT 'N',
ObeseDate                VARCHAR(100),
Osteporosis              VARCHAR(1) DEFAULT 'N',
OsteporosisDate          VARCHAR(100),
Palliative               VARCHAR(1) DEFAULT 'N',
PalliativeDate           VARCHAR(100),
Pad                      VARCHAR(1) DEFAULT 'N',
PadDate                  VARCHAR(100),
Ra                       VARCHAR(1) DEFAULT 'N',
RaDate                   VARCHAR(100),
Stroke                   VARCHAR(1) DEFAULT 'N',
StrokeDate               VARCHAR(100),
Glaucoma                 VARCHAR(1) DEFAULT 'N',
GlaucomaDate             VARCHAR(100),
Hiv                      VARCHAR(1) DEFAULT 'N',
HivDate                  VARCHAR(100),
Hepb                     VARCHAR(1) DEFAULT 'N',
HepbDate                 VARCHAR(100),
Hepc                     VARCHAR(1) DEFAULT 'N',
HepcDate                 VARCHAR(100),
Ibd                      VARCHAR(1) DEFAULT 'N',
IbdDate                  VARCHAR(100),
Liver                    VARCHAR(1) DEFAULT 'N',
LiverDate                VARCHAR(100),
Mnd                      VARCHAR(1) DEFAULT 'N',
MndDate                  VARCHAR(100),
Ms                       VARCHAR(1) DEFAULT 'N',
MsDate                   VARCHAR(100),
Md                       VARCHAR(1) DEFAULT 'N',
MdDate                   VARCHAR(100),
Parkinson                VARCHAR(1) DEFAULT 'N',
ParkinsonDate            VARCHAR(100),
Backpain                 VARCHAR(1) DEFAULT 'N',
BackpainDate             VARCHAR(100),
Gout                     VARCHAR(1) DEFAULT 'N',
GoutDate                 VARCHAR(100),
Sickle                   VARCHAR(1) DEFAULT 'N',
SickleDate               VARCHAR(100),
Thyroid                  VARCHAR(1) DEFAULT 'N',
ThyroidDate              VARCHAR(100),
Countltc                 VARCHAR(100),
GpsurgeryCount           VARCHAR(100),
GptelCount               VARCHAR(100),
GphomeCount              VARCHAR(100),
AedCount                 VARCHAR(100),
AdmissionsCount          VARCHAR(100)
);

ALTER TABLE lbhsc_dataset ADD INDEX lbhsc_pseudoid_idx (pseudo_id);

-- create store table 

DROP TABLE IF EXISTS store;

CREATE TABLE store (
   id         INT,
   code       VARCHAR(20)
);

ALTER TABLE store ADD INDEX store_code_idx (code);
ALTER TABLE store ADD INDEX store_id_idx (id);

-- create snomeds table 

DROP TABLE IF EXISTS snomeds;

CREATE TABLE snomeds (
   snomed_id   BIGINT,
   cat_id      INT
);

ALTER TABLE snomeds ADD INDEX snomedid_idx (snomed_id);

INSERT INTO lbhsc_dataset (pseudo_id) SELECT DISTINCT group_by FROM cohort_lbhsc;


END//
DELIMITER ;

