CREATE DEFINER=`endeavour`@`%` PROCEDURE `getKnowDiabetesObservationsDeltaOneOff`(
    IN p_noncoreconcept VARCHAR(255)
)
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	replace into data_extracts.filteredObservationsDelta

	select distinct o.id
    	from data_extracts.subscriber_cohort coh
	join nwl_subscriber_pid.observation o on o.patient_id = coh.patientId
	join nwl_subscriber_pid.concept_map cm on cm.legacy = o.non_core_concept_id
	join nwl_subscriber_pid.concept c on c.dbid = cm.core
	-- join data_extracts.snomed_code_set_codes scs on scs.snomedCode = c.code
    -- where o.non_core_concept_id=p_noncoreconcept; -- 1414658 (weight), 1414665 (height)
    where o.non_core_concept_id in (p_noncoreconcept);
END