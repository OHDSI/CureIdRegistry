/******* OBSERVATION *******/
  SELECT
  observation_concept_id,
  c.concept_name,
  COUNT(distinct person_id) as [Num People],
  COUNT(*) as [Num Records]
  from [Results].[deident_CURE_ID_observation] o
  left outer join concept c on o.observation_concept_id = c.concept_id
  group by observation_concept_id, c.concept_name
  order by COUNT(distinct person_id) as [Num People]
;