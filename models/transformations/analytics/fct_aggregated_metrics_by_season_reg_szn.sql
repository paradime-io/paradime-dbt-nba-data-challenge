select 
    season,
    --count(game_id) as nr_of_games,
    count(distinct game_id) as nr_of_games,
    avg(field_goals_made) as field_goals_made_per_game,
    avg(field_goals_attempted) as field_goals_attempted_per_game,
    avg(field_goal_pct) as field_goals_percentage,
    avg(three_point_made) as three_points_made_per_game,
    avg(three_point_attempted) as three_points_attempted_per_game,
    avg(three_point_pct) as three_point_percentage,
    avg(free_throws_made) as free_throws_made_per_game,
    avg(free_throws_attempted) as free_throws_attempted_per_game,
    avg(free_throw_pct) as free_throws_percentage,
    avg(offensive_rebounds) as offensive_rebounds_per_game,
    avg(defensive_rebounds) as defensive_rebounds_per_game,
    avg(total_rebounds) as total_rebounds_per_game,
    avg(assists) as assists_per_game,
    avg(steals) as steals_per_game,
    avg(blocks) as blocks_per_game,
    avg(turnovers) as turnovers_per_game,
    avg(personal_fouls) as personal_fouls_per_game,
    avg(points) as points_per_game,
    avg(points_allowed) as points_allowed_per_game,
    avg(possessions) as avg_possessions,
    avg(pace) as avg_pace,
    avg(offensive_efficiency) as avg_offensive_efficiency,
    avg(defensive_efficiency) as avg_defensive_efficiency,
    avg(offensive_rebound_percentage) as avg_offensive_rebound_percentage,
    avg(defensive_rebound_percentage) as avg_defensive_rebound_percentage,
    avg(free_throw_rate) as avg_free_throw_rate
from {{ ref('team_advanced_stats')}}
where game_type = 'Regular Season'
group by 
    season
having 
    count(*) = count(offensive_efficiency)
order by
    season