SELECT 
    season,
    DATEDIFF('year', DATE(birthdate), game_date) as age,
    sum(points) points
FROM 
    {{ ref('stg_player_game_logs') }} player_logs
    JOIN {{ ref('stg_common_player_info') }} player
    ON player_logs.player_id = player.player_id
    GROUP BY 1, 2