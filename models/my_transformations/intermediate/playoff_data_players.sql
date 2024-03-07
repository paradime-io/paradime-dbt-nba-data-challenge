with team_stats as (
    select
    team_id,
    team_name,
    season,
    case when nba_finals_appearance <> 'N/A' then 1 else 0 end as nba_finals_count,
    case when nba_finals_appearance = 'LEAGUE CHAMPION' then 1 else 0 end as nba_championship_count
    from {{ref('team_stats_by_season')}}

)

, player_stats as (
    select
    player_id,
    player_name,
    team_id,
    team_name,
    season,
    sum(case when game_type = 'Playoffs' then 1 else 0 end) as playoff_appearance
    from {{ref('player_game_logs_agg')}}
    group by 1,2,3,4,5

)

select 
p.player_id
, p.player_name
, t.team_id
, t.team_name
, t.season
, p.playoff_appearance
, t.nba_finals_count
, t.nba_championship_count
from player_stats p
join team_stats t on p.team_id = t.team_id and p.season = t.season 