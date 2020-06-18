use jack;

drop table if exists dataset3;

create table dataset3 (

pseudo_id varchar(100) default NULL,

InsulinsShort12MonthName varchar(50),
InsulinsShort12MonthDate varchar(50),
InsulinsShortEarliestName varchar(50),
InsulinsShortEarliestDate varchar(50),

InsulinsLong12MonthName varchar(50),
InsulinsLong12MonthDate varchar(50),
InsulinsLongEarliestName varchar(50),
InsulinsLongEarliestDate varchar(50),

SulphonylureasEarliestName varchar(50),
SulphonylureasEarliestDate varchar(50),
Sulphonylureas12MonthName varchar(50),
Sulphonylureas12MonthDate varchar(50),

MetforminEarliestName varchar(50),
MetforminEarliestDate varchar(50),
Metformin12MonthName varchar(50),
Metformin12MonthDate varchar(50),

AGIsEarliestName varchar(50),
AGIsEarliestDate varchar(50),
AGIs12MonthName varchar(50),
AGIs12MonthDate varchar(50),

GliptinsEarliestName varchar(50),
GliptinsEarliestDate varchar(50),
Gliptins12MonthName varchar(50),
Gliptins12MonthDate varchar(50),

GLP1EarliestName varchar(50),
GLP1EarliestDate varchar(50),
GLP112MonthName varchar(50),
GLP112MonthDate varchar(50),

MeglitinidesEarliestName varchar(50),
MeglitinidesEarliestDate varchar(50),
Meglitinides12MonthName varchar(50),
Meglitinides12MonthDate varchar(50),

SGLT2EarliestName varchar(50),
SGLT2EarliestDate varchar(50),
SGLT212MonthName varchar(50),
SGLT212MonthDate varchar(50),

ThiazolidinedionesEarliestName varchar(50),
ThiazolidinedionesEarliestDate varchar(50),
Thiazolidinediones12MonthName varchar(50),
Thiazolidinediones12MonthDate varchar(50),

CombinationDrugsEarliestName varchar(50),
CombinationDrugsEarliestDate varchar(50),
CombinationDrugs12MonthName varchar(50),
CombinationDrugs12MonthDate varchar(50),

TestingStripsEarliestName varchar(50),
TestingStripsEarliestDate varchar(50),

InsulinPumpEarliestName varchar(50),
InsulinPumpEarliestDate varchar(50),

NeuropathyEarliestName varchar(50),
NeuropathyEarliestDate varchar(50),
Neuropathy12MonthName varchar(50),
Neuropathy12MonthDate varchar(50),

CardiacGlycosideEarliestName varchar(50),
CardiacGlycosideEarliestDate varchar(50),
CardiacGlycoside12MonthName varchar(50),
CardiacGlycoside12MonthDate varchar(50),

ThiazidesEarliestName varchar(50),
ThiazidesEarliestDate varchar(50),
Thiazides12MonthName varchar(50),
Thiazides12MonthDate varchar(50),

LoopDirueticsEarliestName varchar(50),
LoopDirueticsEarliestDate varchar(50),
LoopDiruetics12MonthName varchar(50),
LoopDiruetics12MonthDate varchar(50),

PotassiumSparingEarliestName varchar(50),
PotassiumSparingEarliestDate varchar(50),
PotassiumSparing12MonthName varchar(50),
PotassiumSparing12MonthDate varchar(50),

DiureticCombiEarliestName varchar(50),
DiureticCombiEarliestDate varchar(50),
DiureticCombi12MonthName varchar(50),
DiureticCombi12MonthDate varchar(50),

DiumideEarliestName varchar(50),
DiumideEarliestDate varchar(50),
Diumide12MonthName varchar(50),
Diumide12MonthDate varchar(50),

AntiArrhythmicsEarliestName varchar(50),
AntiArrhythmicsEarliestDate varchar(50),
AntiArrhythmics12MonthName varchar(50),
AntiArrhythmics12MonthDate varchar(50),

betaBlockersEarliestName varchar(50),
betaBlockersEarliestDate varchar(50),
betaBlockers12MonthName varchar(50),
betaBlockers12MonthDate varchar(50),

VasodilatorsEarliestName varchar(50),
VasodilatorsEarliestDate varchar(50),
Vasodilators12MonthName varchar(50),
Vasodilators12MonthDate varchar(50),

CentralantihypertensiveEarliestName varchar(50),
CentralantihypertensiveEarliestDate varchar(50),
Centralantihypertensive12MonthName varchar(50),
Centralantihypertensive12MonthDate varchar(50),

AlphaBlockersEarliestName varchar(50),
AlphaBlockersEarliestDate varchar(50),
AlphaBlockers12MonthName varchar(50),
AlphaBlockers12MonthDate varchar(50),

ACEInhibitorsEarliestName varchar(50),
ACEInhibitorsEarliestDate varchar(50),
ACEInhibitors12MonthName varchar(50),
ACEInhibitors12MonthDate varchar(50),

AngiotensinAntagonistsEarliestName varchar(50),
AngiotensinAntagonistsEarliestDate varchar(50),
AngiotensinAntagonists12MonthName varchar(50),
AngiotensinAntagonists12MonthDate varchar(50),

NitratesEarliestName varchar(50),
NitratesEarliestDate varchar(50),
Nitrates12MonthName varchar(50),
Nitrates12MonthDate varchar(50),

CalciumChannelEarliestName varchar(50),
CalciumChannelEarliestDate varchar(50),
CalciumChannel12MonthName varchar(50),
CalciumChannel12MonthDate varchar(50),

AntianginalEarliestName varchar(50),
AntianginalEarliestDate varchar(50),
Antianginal12MonthName varchar(50),
Antianginal12MonthDate varchar(50),

PeripheralVasodilatorsEarliestName varchar(50),
PeripheralVasodilatorsEarliestDate varchar(50),
PeripheralVasodilators12MonthName varchar(50),
PeripheralVasodilators12MonthDate varchar(50),

OralAnticoagulantsEarliestName varchar(50),
OralAnticoagulantsEarliestDate varchar(50),
OralAnticoagulants12MonthName varchar(50),
OralAnticoagulants12MonthDate varchar(50),

AntiplateletEarliestName varchar(50),
AntiplateletEarliestDate varchar(50),
Antiplatelet12MonthName varchar(50),
Antiplatelet12MonthDate varchar(50),

LipidRegulationEarliestName varchar(50),
LipidRegulationEarliestDate varchar(50),
LipidRegulation12MonthName varchar(50),
LipidRegulation12MonthDate varchar(50),

StatinAEEarliestCode varchar(50),
StatinAEEarliestDate varchar(50),

StatinMuscleEarliestCode varchar(50),
StatinMuscleEarliestDate varchar(50),

ErectileDysfunctionEarliestName varchar(50),
ErectileDysfunctionEarliestDate varchar(50),
ErectileDysfunction12MonthName varchar(50),
ErectileDysfunction12MonthDate varchar(50),

WeightLossEarliestName varchar(50),
WeightLossDate varchar(50),
WeightLoss12MonthName varchar(50),
WeightLoss12MonthDate varchar(50)
);

alter table dataset3 add index pseudoIdIdx (pseudo_id);

insert into dataset3 (pseudo_id) select distinct pseudo_id from cohort;
