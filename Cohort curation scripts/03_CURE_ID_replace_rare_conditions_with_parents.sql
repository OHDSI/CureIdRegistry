/*
Filename:
03_CURE_ID_replace_rare_conditions_with_parents.sql

Purpose:
Replace conditions occurring 10 or less times in the dataset with parent concepts
that have at least 10 counts.

Description:

Dependencies:
01_CURE_ID_Cohort.sql
02_CURE_ID_All_Tables.sql
*/

USE YOUR_DATABASE;

DROP TABLE IF EXISTS Results.CURE_ID_Condition_Occurrence_Rare_Removed

---Condition roll up
drop table if exists #condition_rollup
select distinct
    person_id,
    condition_concept_id as original_concept_id,
    concept_name as ancestor_concept_name,
    ancestor_concept_id,
    min_levels_of_separation
into
#condition_rollup
from
    Results.CURE_ID_Condition_Occurrence
left join
    CONCEPT_ancestor
    on
        descendant_concept_id = Results.CURE_ID_Condition_Occurrence.condition_concept_id
left join
    concept on concept.concept_id = CONCEPT_ancestor.ancestor_concept_id



--Create table that counts the ancestor concepts
drop table if exists #condition_rollup_counts
select
    ancestor_concept_name,
    ancestor_concept_id,
    count(ancestor_concept_id) as ancestor_concept_count
into #condition_rollup_counts
from #condition_rollup
group by ancestor_concept_id, ancestor_concept_name



--Create table that counts the original concepts
drop table if exists #original_condition_counts
select
    condition_concept_id as original_concept_id,
    concept_name as original_concept_name,
    count(condition_concept_id) as original_concept_count
into
#original_condition_counts
from (
    select distinct
        person_id,
        condition_concept_id,
        concept_name
    from
        Results.CURE_ID_Condition_Occurrence
    left join
        concept on concept.concept_id = Results.CURE_ID_Condition_Occurrence.condition_concept_id
) as x1
group by condition_concept_id, concept_name




--limit conditions to those that have more than 10
drop table if exists #condition_rollup_morethan10
select
    person_id,
    #condition_rollup.original_concept_id,
    #condition_rollup.ancestor_concept_id,
    #condition_rollup.ancestor_concept_name,
    #condition_rollup_counts.ancestor_concept_count,
    #condition_rollup.min_levels_of_separation
into #condition_rollup_morethan10
from #condition_rollup
left join
    #condition_rollup_counts
    on
        #condition_rollup_counts.ancestor_concept_id = #condition_rollup.ancestor_concept_id
where
    ancestor_concept_count > 10

--Get just the most specfic condition
drop table if exists #condition_rollup_morethan10_min_counts
select distinct
    #condition_rollup_morethan10.person_id,
    #condition_rollup_morethan10.original_concept_id,
    #condition_rollup_morethan10.ancestor_concept_id,
    #condition_rollup_morethan10.ancestor_concept_name,
    #condition_rollup_morethan10.ancestor_concept_count,
    #condition_rollup_morethan10.min_levels_of_separation
into #condition_rollup_morethan10_min_counts
from #condition_rollup_morethan10
inner join
    (
        select distinct
            #condition_rollup_morethan10.person_id,
            #condition_rollup_morethan10.original_concept_id,
            min(ancestor_concept_count) as min_ancestor_concept_count
        from #condition_rollup_morethan10
        group by person_id, original_concept_id
    ) tb1
    on
        #condition_rollup_morethan10.person_id = tb1.person_id
        and #condition_rollup_morethan10.original_concept_id = tb1.original_concept_id
where
    #condition_rollup_morethan10.ancestor_concept_count = tb1.min_ancestor_concept_count



drop table if exists #condition_rollup_morethan10_min_counts_and_levels
select distinct
    #condition_rollup_morethan10_min_counts.person_id,
    #condition_rollup_morethan10_min_counts.original_concept_id,
    #condition_rollup_morethan10_min_counts.ancestor_concept_id as revised_concept_id,
    #condition_rollup_morethan10_min_counts.ancestor_concept_name as revised_concept_name,
    #condition_rollup_morethan10_min_counts.ancestor_concept_count,
    #condition_rollup_morethan10_min_counts.min_levels_of_separation
into #condition_rollup_morethan10_min_counts_and_levels
from #condition_rollup_morethan10_min_counts
inner join
    (
        select distinct
            person_id,
            original_concept_id,
            min(min_levels_of_separation) as min_min_levels_of_separation
        from #condition_rollup_morethan10_min_counts
        group by person_id, original_concept_id
    ) tb1
    on
        #condition_rollup_morethan10_min_counts.person_id = tb1.person_id
        and #condition_rollup_morethan10_min_counts.original_concept_id = tb1.original_concept_id
where
    #condition_rollup_morethan10_min_counts.min_levels_of_separation = tb1.min_min_levels_of_separation



drop table if exists #condition_rollup_morethan10_min_counts_and_levels_forced_unique
select
    x1.person_id,
    x1.original_concept_id,
    #original_condition_counts.original_concept_name,
    #original_condition_counts.original_concept_count,
    x1.revised_concept_id,
    x1.revised_concept_name,
    x1.min_levels_of_separation,
    x1.ancestor_concept_count
into #condition_rollup_morethan10_min_counts_and_levels_forced_unique
from (
    select
        *,
        ROW_NUMBER() over (partition by person_id, original_concept_id order by revised_concept_id desc) as row_number
    from #condition_rollup_morethan10_min_counts_and_levels
) x1
left join
    #original_condition_counts
    on
        x1.original_concept_id = #original_condition_counts.original_concept_id
where row_number = 1;



--select top 10 * from #condition_rollup_morethan10_min_counts_and_levels_forced_unique where original_concept_id != revised_concept_id;

SELECT
    c.condition_occurrence_id, c.person_id, rare.revised_concept_id as condition_concept_id, c.condition_start_date, c.condition_start_datetime, c.condition_end_date, c.condition_end_datetime, c.condition_type_concept_id, c.condition_status_concept_id, c.stop_reason, c.provider_id, c.visit_occurrence_id, c.visit_detail_id, c.condition_source_value, c.condition_source_concept_id,
    c.condition_status_source_value
INTO Results.CURE_ID_Condition_Occurrence_Rare_Removed
FROM Results.CURE_ID_Condition_Occurrence c
INNER JOIN #condition_rollup_morethan10_min_counts_and_levels_forced_unique rare on
    c.condition_concept_id = rare.original_concept_id
    and c.person_id = rare.person_id;

DROP TABLE IF EXISTS Results.CURE_ID_Condition_Occurrence;
