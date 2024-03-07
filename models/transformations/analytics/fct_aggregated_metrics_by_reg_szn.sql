select 
    season,
    --count(game_id) as nr_of_games,
    count(distinct game_id) as nr_of_games,
    round(avg(field_goals_made),3) as field_goals_made_per_game,
    round(avg(field_goals_attempted),3) as field_goals_attempted_per_game,
    round(avg(field_goal_pct),3) as field_goals_percentage,
    round(avg(three_point_made),3) as three_points_made_per_game,
    round(avg(three_point_attempted),3) as three_points_attempted_per_game,
    round(avg(three_point_pct),3) as three_point_percentage,
    round(avg(free_throws_made),3) as free_throws_made_per_game,
    round(avg(free_throws_attempted),3) as free_throws_attempted_per_game,
    round(avg(free_throw_pct),3) as free_throws_percentage,
    round(avg(offensive_rebounds),3) as offensive_rebounds_per_game,
    round(avg(defensive_rebounds),3) as defensive_rebounds_per_game,
    round(avg(total_rebounds),3) as total_rebounds_per_game,
    round(avg(assists),3) as assists_per_game,
    round(avg(steals),3) as steals_per_game,
    round(avg(blocks),3) as blocks_per_game,
    round(avg(turnovers),3) as turnovers_per_game,
    round(avg(personal_fouls),3) as personal_fouls_per_game,
    round(avg(points),3) as points_per_game,
    round(avg(points_allowed),3) as points_allowed_per_game,
    round(avg(possessions),3) as avg_possessions,
    round(avg(pace),3) as avg_pace,
    round(avg(offensive_efficiency),3) as avg_offensive_efficiency,
    round(avg(defensive_efficiency),3) as avg_defensive_efficiency,
    round(avg(offensive_rebound_percentage),3) as avg_offensive_rebound_percentage,
    round(avg(defensive_rebound_percentage),3) as avg_defensive_rebound_percentage,
    round(avg(free_throw_rate),3) as avg_free_throw_rate,
    --data quality metrics
    count(points) / count(*) as points_completeness,
    count(three_point_attempted) / count(*) as three_pa_completeness,
    count(pace) / count(*) as pace_completeness,
    count(offensive_efficiency) / count(*) as offensive_efficiency_completeness,
    count(defensive_efficiency) / count(*) as defensive_efficiency_completeness,
    count(offensive_rebound_percentage) / count(*) as orbd_pct_completeness,
    count(defensive_rebound_percentage) / count(*) as drbd_pct_completeness,
    count(free_throw_rate) / count(*) as free_throw_rate_completeness
from {{ ref('team_advanced_stats')}}
where game_type = 'Regular Season'
group by 
    season
/*
having 
    count(*) = count(offensive_efficiency)
*/
order by
    season