with agg_points as (
SELECT 
    season,
    height as height,
    SUM(points) points
FROM 
    {{ ref('stg_player_game_logs') }} player_logs
    JOIN {{ ref('stg_common_player_info') }} player
    ON player_logs.player_id = player.player_id
    GROUP BY 1, 2
)

SELECT 
    * ,
    points / SUM(points) OVER (PARTITION by season) season_points_percentage
FROM agg_points