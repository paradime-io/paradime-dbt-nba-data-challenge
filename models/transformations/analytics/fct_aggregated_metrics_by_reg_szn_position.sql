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
    round(avg(pas.field_goals_made),3) as field_goals_made_per_game,
    round(avg(pas.field_goals_attempted),3) as field_goals_attempted_per_game,
    round(avg(pas.field_goal_pct),3) as field_goal_pct,
    round(avg(pas.three_point_made),3) as three_points_made_per_game,
    round(avg(pas.three_point_attempted),3) as three_points_attempted_per_game,
    round(avg(pas.three_point_pct),3) as three_point_pct,
    round(avg(pas.free_throws_made),3) as free_throws_made_per_game,
    round(avg(pas.free_throws_attempted),3) as free_throws_attempted_per_game,
    round(avg(pas.free_throw_pct),3) as free_throw_pct, 
    round(avg(pas.offensive_rebounds),3) as offensive_rebounds_per_game,
    round(avg(pas.defensive_rebounds),3) as defensive_rebounds_per_game,
    round(avg(pas.total_rebounds),3) as total_rebounds_per_game,
    round(avg(pas.assists),3) as assists_per_game,
    round(avg(pas.turnovers),3) as turnovers_per_game,
    round(avg(pas.steals),3) as steals_per_game,
    round(avg(pas.blocks),3) as blocks_per_game,
    round(avg(pas.personal_fouls),3) as personal_fouls_per_game, 
    round(avg(pas.points),3) as points_per_game,
    round(avg(pas.effective_field_goal_percentage),3) as effective_field_goal_percentage,
    round(avg(pas.true_shooting_percentage),3) as true_shooting_percentage,
    round(avg(pas.rebound_percentage),3) as rebound_percentage,
    round(avg(pas.steal_percentage),3) as steal_percentage,
    round(avg(pas.block_percentage),3) as block_percentage, 
    round(avg(pas.per),3) as per,
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