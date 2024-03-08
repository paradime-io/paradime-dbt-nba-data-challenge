with injury_reports as (
    select *
    from {{ref('stg_player_injuries')}}
)

/* Here's the situation -- we want to connect names in this report to other attributes modeled elsewhere
    Connecting certain player attributes using name alone would be kind of janky
    We can't look up folks via player info because players switch teams
    We could use game logs, but not all players play.
    Annual salary would be helpful but we don't have teams in that model

    We're only using 14 years of injury data. Players with the same name during this period is rarer 
    than previous periods. For that reason -- we're doing things quick and dirty.
 */

, player_info as (
    select *
    from {{ref('stg_common_player_info')}}
    --where last_year_played::int >= 2010
)


, injured as (
    select *
    from injury_reports
    where relinquished is not null
)

, recovery_time as (
    select 
    injured.relinquished
    , injured.date as date_injured
    , injured.team
    , md5(date_injured || injured.team || injured.relinquished) as report_id
    , min(recovered.date) as date_recovered
    , datediff('day', date_injured, date_recovered) as time_to_recover_days
    from injury_reports recovered
    left join injured
    on injured.relinquished = recovered.acquired
    and injured.team = recovered.team
    and recovered.date >= injured.date
    where recovered.acquired is not null
    group by 1,2,3
)


select 
injury_reports.date
, injury_reports.team
, coalesce(injury_reports.acquired, injury_reports.relinquished) as player_name
, md5(injury_reports.date || injury_reports.team || player_name) as player_injury_report_id
, injury_reports.relinquished is not null as is_relinquished
, injury_reports.acquired is not null as is_acquired
, player_info.player_id
, injury_reports.notes
, case
    when is_relinquished and injury_reports.notes ilike '%out for season%' then 'out for season'
    when is_relinquished and injury_reports.notes ilike '%DTD%' then 'day-to-day'
    when is_relinquished and injury_reports.notes ilike '%out indefinitely%' then 'out indefinitely'
    when is_relinquished then 'other'
    else null end
    as severity_level
-- To refactor into a seed file
, case

    -- arm
    when is_relinquished and injury_reports.notes ilike any ('%shoulder%', '%rotator cuff%', '%bicep%', '%arm%')  then 'upper arm'
    when is_relinquished and injury_reports.notes ilike any ('%finger%', '%thumb%', '%hand%') then 'digit/hand'
    when is_relinquished and injury_reports.notes ilike any ('%forearm%','%wrist%')  then 'lower arm'
    when is_relinquished and injury_reports.notes ilike '%elbow%' then 'elbow'

    -- spinal column
    when is_relinquished and injury_reports.notes ilike any ('%back%', '%lumbar%', '%tailbone%', '%spine%', '%spinal%') then 'back'
    when is_relinquished and injury_reports.notes ilike any('%cervical%', '%neck%') then 'neck'

    -- legs
    when is_relinquished and injury_reports.notes ilike any ('%knee%', '%acl%') then 'knee'
    when is_relinquished and injury_reports.notes ilike any ('%hamstring%', '%thigh%', '%quadricep%', '%leg%', '%abductor%', '%adductor%') then 'upper leg'
    when is_relinquished and injury_reports.notes ilike any ('%achilles%', '%calf%', '%ankle%', '%shin%', '%tibia%', '%fibula%') then 'lower leg'
    when is_relinquished and injury_reports.notes ilike any ('%foot%', '%toe%', '%heel%') then 'foot'
    
    -- face
    when is_relinquished and injury_reports.notes ilike any ('%face%', '%eye%', '%nose%', '%mouth%', '%nasal%', '%chin%', '%facial%', '%jaw%', '%cornea%', '%orbital%') then 'face'
    
    -- upper torso
    when is_relinquished and injury_reports.notes ilike any ('%chest%', '%abdominal%', '%rib%', '%sternum%') then 'upper_torso'

    -- non-facial head injury
    when is_relinquished and injury_reports.notes ilike any ('%concussion%', '%head%') then 'head'

    -- pelvis
    when is_relinquished and injury_reports.notes ilike any ('%hip%', '%glute%') then 'hip'
    when is_relinquished and injury_reports.notes ilike '%groin%' then 'groin'

    when is_relinquished and injury_reports.notes ilike any ('%illness%', '%infection%', '%covid%', '%flu%', '%virus%', '%pneumonia%') then 'illness'
    when is_relinquished and injury_reports.notes ilike '%health and safety protocols%' then 'health and safety protocols'
    when is_relinquished then 'other'
    else null end
    as injury_type

    , case when injury_type in ('knee', 'upper leg', 'lower leg', 'foot') then 'leg'
        when injury_type in ('upper arm', 'digit/hand', 'lower arm', 'elbow') then 'arm'
        when injury_type in ('hip', 'groin') then 'pelvis'
        when injury_type in ('head') then 'head'
        when injury_type in ('face') then 'face'
        when injury_type in ('back', 'neck') then 'spinal column'
        when injury_type in ('upper torso') then 'upper_torso'
        -- ommitting illness, protocols and everything else
        else null end
    as major_body_part_group
, recovery_time.time_to_recover_days
        
from injury_reports
left join player_info
on player_name = player_info.full_name
left join recovery_time
on player_injury_report_id = recovery_time.report_id
where is_acquired = false
and player_name = 'Vitor Faverani'