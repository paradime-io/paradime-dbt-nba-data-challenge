with agg_points as (
SELECT 
    season,
    DATEDIFF('year', DATE(birthdate), game_date) as age,
    SUM(mins_played) mins_played
FROM 
    {{ ref('stg_player_game_logs') }} player_logs
    JOIN {{ ref('stg_common_player_info') }} player
    ON player_logs.player_id = player.player_id
    GROUP BY 1, 2
    HAVING SUM(mins_played)>0
)

SELECT 
    * ,
    mins_played / SUM(mins_played) OVER (PARTITION by season) season_points_percentage
FROM agg_points