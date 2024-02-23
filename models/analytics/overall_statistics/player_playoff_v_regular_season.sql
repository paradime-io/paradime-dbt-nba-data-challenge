WITH player_game_log AS (
    SELECT * FROM {{ ref('stg_player_game_logs')}}
),

player_game_log_clean AS (
    SELECT  
        player_id,
        player_name,
        game_type, 
        COUNT(CASE WHEN win_loss = 'W' THEN 1 END) AS win_count,
        COUNT(CASE WHEN win_loss = 'L' THEN 1 END) AS loss_count,
        AVG(mins_played) AS avg_mins_played,
        AVG(CASE WHEN field_goals_attempted > 0 THEN (field_goals_made / field_goals_attempted) * 100 END) AS avg_field_goal_percentage,
        AVG(CASE WHEN three_point_attempted > 0 THEN (three_point_made / three_point_attempted) * 100 END) AS avg_three_point_percentage,
        AVG(CASE WHEN free_throws_attempted > 0 THEN (free_throws_made / free_throws_attempted) * 100 END) AS avg_free_throw_percentage,
        COUNT(total_rebounds) as total_rebounds,
        COUNT(assists) as total_assists,
        COUNT(turnovers) as total_turnovers,
        COUNT(steals) as total_steals,
        COUNT(blocks) as total_blocks,
        COUNT(personal_fouls) as total_personal_fouls,
        AVG(points) as avg_points
    FROM player_game_log
    GROUP BY player_id, player_name, game_type
)

SELECT * FROM player_game_log_clean