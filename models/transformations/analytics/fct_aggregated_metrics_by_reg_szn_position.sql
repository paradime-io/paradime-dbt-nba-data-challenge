select 
    pas.season,
    --consolidate positions into 3 cathegories
    case 
        when left(cpi.position, 6) = 'Center'
        then 'Center'
        when left(cpi.position, 7) = 'Forward'
        then 'Forward'
        when left(cpi.position, 5) = 'Guard'
        then 'Guard'
        else cpi.position
    end as position,
    avg(pas.field_goals_made) as field_goals_made_per_game,
    avg(pas.field_goals_attempted) as field_goals_attempted_per_game,
    avg(pas.field_goal_pct) as field_goal_pct,
    avg(pas.three_point_made) as three_points_made_per_game,
    avg(pas.three_point_attempted) as three_points_attempted_per_game,
    avg(pas.three_point_pct) as three_point_pct,
    avg(pas.free_throws_made) as free_throws_made_per_game,
    avg(pas.free_throws_attempted) as free_throws_attempted_per_game,
    avg(pas.free_throw_pct) as free_throw_pct, 
    avg(pas.offensive_rebounds) as offensive_rebounds_per_game,
    avg(pas.defensive_rebounds) as defensive_rebounds_per_game,
    avg(pas.total_rebounds) as total_rebounds_per_game,
    avg(pas.assists) as assists_per_game,
    avg(pas.turnovers) as turnovers_per_game,
    avg(pas.steals) as steals_per_game,
    avg(pas.blocks) as blocks_per_game,
    avg(pas.personal_fouls) as personal_fouls_per_game, 
    avg(pas.points) as points_per_game,
    avg(pas.effective_field_goal_percentage) as effective_field_goal_percentage,
    avg(pas.true_shooting_percentage) as true_shooting_percentage,
    avg(pas.rebound_percentage) as rebound_percentage,
    avg(pas.steal_percentage) as steal_percentage,
    avg(pas.block_percentage) as block_percentage, 
    avg(pas.per) as per,
    --data quality metrics
    count(pas.points) / count(*) as points_completeness,
    count(pas.effective_field_goal_percentage) / count(*) as efg_pct_completeness,
    count(pas.true_shooting_percentage) / count(*) as ts_pct_completeness,
    count(pas.rebound_percentage) / count(*) as rbd_pct_completeness,
    count(pas.steal_percentage) / count(*) as stl_pct_completeness,
    count(pas.block_percentage) / count(*) as blk_pct_completeness,
    count(pas.per) / count(*) as per_completeness
from {{ ref('player_advanced_stats')}} as pas
left join {{ ref('stg_common_player_info')}} as cpi
on pas.player_id = cpi.player_id
--since 3pt-line was introduced
where left(season,4) >= 1979
and game_type = 'Regular Season'
group by 
    pas.season,
    case 
        when left(cpi.position, 6) = 'Center'
        then 'Center'
        when left(cpi.position, 7) = 'Forward'
        then 'Forward'
        when left(cpi.position, 5) = 'Guard'
        then 'Guard'
        else cpi.position
    end