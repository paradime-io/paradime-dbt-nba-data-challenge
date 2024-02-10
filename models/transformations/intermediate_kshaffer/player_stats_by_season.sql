    SELECT 
        player_id
      , player_name
      , season
      , COALESCE(CASE WHEN mins_played > 0 THEN COUNT(DISTINCT game_id) END,0) AS games_played
      , SUM(mins_played) AS mins_played
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
    FROM 
        {{ ref('stg_player_game_logs') }}
    GROUP BY player_id
           , player_name
           , season
           , mins_played