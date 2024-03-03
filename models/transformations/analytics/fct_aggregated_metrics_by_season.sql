select 
    season,
    --count(game_id) as nr_of_games,
    count(distinct game_id) as nr_of_games,
    sum(field_goals_made) / count(game_id) as field_goals_made_per_game,
    sum(field_goals_attempted) / count(game_id) as field_goals_attempted_per_game,
    div0(sum(field_goals_made), sum(field_goals_attempted)) as field_goals_percentage,
    sum(three_point_made) / count(game_id) as three_points_made_per_game,
    sum(three_point_attempted) / count(game_id) as three_points_attempted_per_game, 
    div0(sum(three_point_made), sum(three_point_attempted)) as three_point_percentage,
    sum(free_throws_made) / count(game_id) as free_throws_made_per_game,
    sum(free_throws_attempted) / count(game_id) as free_throws_attempted_per_game,
    div0(sum(free_throws_made), sum(free_throws_attempted)) as free_throws_percentage,
    sum(offensive_rebounds) / count(game_id) as offensive_rebounds_per_game,
    sum(defensive_rebounds) / count(game_id) as defensive_rebounds_per_game,
    sum(total_rebounds) / count(game_id) as total_rebounds_per_game,
    sum(assists) / count(game_id) as assists_per_game,
    sum(steals) / count(game_id) as steals_per_game,
    sum(blocks) / count(game_id) as blocks_per_game,
    sum(turnovers) / count(game_id) as turnovers_per_game,
    sum(personal_fouls) / count(game_id) as personal_fouls_per_game,
    sum(points) / count(game_id) as point_per_game,
    sum(points_allowed) / count(game_id) as points_allowed_per_game,
    avg(possessions) as avg_possessions,
    avg(pace) as avg_pace,
    avg(offensive_efficiency) as avg_offensive_efficiency,
    avg(defensive_efficiency) as avg_defensive_efficiency,
    avg(offensive_rebound_percentage) as avg_offensive_rebound_percentage,
    avg(defensive_rebound_percentage) as avg_defensive_rebound_percentage,
    avg(free_throw_rate) as avg_free_throw_rate
from intermediate.team_advanced_stats
where game_type = 'Regular Season'
group by 
    season
order by
    season