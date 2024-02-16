    SELECT 
        game_stats.player_id
      , game_stats.player_name
      , game_stats.season
      , SUM(mins_played) AS mins_played
      , SUM(field_goals_made) AS field_goals_made
      , SUM(field_goals_attempted) AS field_goals_attempted
      , AVG(field_goal_pct) AS avg_field_goal_percentage
      , SUM(three_point_made) AS three_point_made
      , SUM(three_point_attempted) AS three_point_attempted
      , AVG(three_point_pct) AS avg_three_pointer_percentage
      , SUM(free_throws_made) AS free_throws_made
      , SUM(free_throws_attempted) AS free_throws_attempted
      , AVG(free_throw_pct) AS avg_free_throw_percentage
      , SUM(offensive_rebounds) AS offensive_rebounds
      , SUM(defensive_rebounds) AS defensive_rebounds
      , SUM(total_rebounds) AS total_rebounds
      , SUM(assists) AS assists
      , SUM(personal_fouls) AS personal_fouls
      , SUM(steals) AS steals
      , SUM(turnovers) AS turnovers
      , SUM(blocks) AS blocks
      , SUM(points) AS points
      , salary
      , rank as salary_rank
    FROM 
        {{ ref('stg_player_game_logs') }} as game_stats
    LEFT JOIN  {{ ref('stg_player_salaries_by_season') }} as salaries ON game_stats.player_id = salaries.player_id
                                                                      AND game_stats.season = salaries.season
    GROUP BY game_stats.player_id
           , game_stats.player_name
           , game_stats.season
           , salaries.salary
           , salaries.rank