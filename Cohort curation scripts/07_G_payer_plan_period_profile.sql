/******* PAYER_PLAN_PERIOD *******/

select payer_concept_id, concept_name,
       count(distinct person_id) as [Num People],
       count(*) as [Num Records]
from [Results].[deident_CURE_ID_payer_plan_period] ppp
    join concept c on  c.concept_id = ppp.payer_concept_id
    group by payer_concept_id, concept_name order by count(distinct person_id) desc