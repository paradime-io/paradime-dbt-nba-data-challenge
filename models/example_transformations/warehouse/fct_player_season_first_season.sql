with first_season as (
    select 
    player_id,
    DATE(min(first_year_played||'-01-01')) as first_year_played
    from 
    {{ ref('stg_common_player_info') }}
    group by 1
),

agg_points as (
SELECT 
    season,
    DATEDIFF('year', DATE(first_year_played), game_date) as age_in_nba,
    SUM(points) points
FROM 
    {{ ref('stg_player_game_logs') }} player_logs
    JOIN first_season player
    ON player_logs.player_id = player.player_id
    GROUP BY 1, 2
)

SELECT 
    * ,
    points / SUM(points) OVER (PARTITION by season) season_points_percentage
FROM agg_points