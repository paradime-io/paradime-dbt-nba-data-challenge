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


select 
injury_reports.date
, injury_reports.team
, coalesce(injury_reports.acquired, injury_reports.relinquished) as player_name
, md5(injury_reports.date || injury_reports.team || player_name) as report_id
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
, case
    when is_relinquished and injury_reports.notes ilike any ('%knee%', '%acl%') then 'knee'
    when is_relinquished and injury_reports.notes ilike '%hamstring%' then 'hamstring'
    when is_relinquished and injury_reports.notes ilike '%back%' then 'back'
    when is_relinquished and injury_reports.notes ilike any ('%finger%', '%thumb%') then 'digit'
    when is_relinquished and injury_reports.notes ilike any ('%shoulder%', '%rotator cuff%')  then 'shoulder'
    when is_relinquished and injury_reports.notes ilike any ('%achilles%', '%calf%', '%ankle%') then 'lower leg'
    when is_relinquished and injury_reports.notes ilike '%concsusion%' then 'concussion'
    when is_relinquished and injury_reports.notes ilike any ('%foot%', '%toe%') then 'foot'
    when is_relinquished and injury_reports.notes ilike '%hip%' then 'hip'
    when is_relinquished and injury_reports.notes ilike '%groin%' then 'groin'
    when is_relinquished and injury_reports.notes ilike '%wrist%' then 'wrist'
    when is_relinquished and injury_reports.notes ilike '%illness%' then 'illness'
    when is_relinquished then 'other'
    else null end
    as injury_type
from injury_reports
left join player_info
on player_name = player_info.full_name
order by date desc