use data_extracts;

drop table if exists dataset1a;

create table dataset1a (
    pseudo_id varchar(100) default NULL,
    AsthmaCode varchar(100) null,
    AsthmaDate varchar(100) null,
    COPDCode varchar(100) null,
    COPDDate varchar(100) null,
    IPFCode varchar(100) null,
    IPFDate varchar(100) null,
    AMDCode varchar(100) null,
    AMDDate varchar(100) null,
    GlaucomaCode varchar(100) null,
    GlaucomaDate varchar(100) null,
    RACode varchar(100) null,
    RADate varchar(100) null,
    LupusCode varchar(100) null,
    LupusDate varchar(100) null,
    CrohnsCode varchar(100) null,
    CrohnsDate varchar(100) null,

    UCCode varchar(100) null,
    UCDate varchar(100) null,

    EczemaCode varchar(100) null,
    EczemaDate varchar(100) null,

    PCDCode varchar(100) null,
    PCDDate varchar(100) null,

    MelanomaCode varchar(100) null,
    MelanomaDate varchar(100) null,

    ProstateCancerCode varchar(100) null,
    ProstateCancerDate varchar(100) null,

    LungCancerCode varchar(100) null,
    LungCancerDate varchar(100) null,

    ColonBowelCancerCode varchar(100) null,
    ColonBowelCancerDate varchar(100) null,

    BreastCancerCode varchar(100) null,
    BreastCancerDate varchar(100) null,

    MiscarriageCode varchar(100) null,
    MiscarriageDate varchar(100) null,

    StillbirthCode varchar(100) null,
    StillbirthDate varchar(100) null,

    PIHCode varchar(100) null,
    PIHDate varchar(100) null,

    PreEclampsiaCode varchar(100) null,
    PreEclampsiaDate varchar(100) null,

    CholestasisCode varchar(100) null,
    CholestasisDate varchar(100) null,

    GallstonesCode varchar(100) null,
    GallstonesDate varchar(100) null,

    GoutCode varchar(100) null,
    GoutDate varchar(100) null,

    AnkylosingSpondylitisCode varchar(100) null,
    AnkylosingSpondylitisDate varchar(100) null,

    JaundiceCode varchar(100) null,
    JaundiceDate varchar(100) null,

    PsoriasisCode varchar(100) null,
    PsoriasisDate varchar(100) null,

    AtopicDermatitisCode varchar(100) null,
    AtopicDermatitisDate varchar(100) null,

    DeafnessCode varchar(100) null,
    DeafnessDate varchar(100) null,

    HearingAidCode varchar(100) null,
    HearingAidDate varchar(100) null,

    TinnitusCode varchar(100) null,
    TinnitusDate varchar(100) null,

    IVFCode varchar(100) null,
    IVFDate varchar(100) null,

    AppendicitisCode varchar(100) null,
    AppendicitisDate varchar(100) null,

    HerniaCode varchar(100) null,
    HerniaDate varchar(100) null,

    FemoralHerniaCode varchar(100) null,
    FemoralHerniaDate varchar(100) null,

    InguinalHerniaCode varchar(100) null,
    InguinalHerniaDate varchar(100) null,

    UmbilicalHerniaCode varchar(100) null,
    UmbilicalHerniaDate varchar(100) null,

    AbdominalHerniaCode varchar(100) null,
    AbdominalHerniaDate varchar(100) null
);

alter table dataset1a add index patientIdIdx (pseudo_id);

insert into dataset1a (pseudo_id) select distinct group_by from cohort;
