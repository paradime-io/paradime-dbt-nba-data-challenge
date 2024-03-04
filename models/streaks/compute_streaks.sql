WITH ranked_games AS (
    SELECT 
        team_id,
        team_abbreviation,
        game_id,
        game_date,
        wl,
        ROW_NUMBER() OVER(PARTITION BY team_id, wl ORDER BY game_date) AS wl_rank,
        ROW_NUMBER() OVER(PARTITION BY team_id ORDER BY game_date) AS overall_rank
    FROM 
        {{ ref('stg_games') }}
    WHERE   
        game_type = 'Regular Season'
),
streaks AS (
    SELECT 
        team_id,
        game_id,
        game_date,
        wl,
        CONCAT(team_abbreviation, '-', wl, '-', overall_rank - wl_rank) AS streak_id -- add season_id to avoid counting running streaks between sessions
    FROM  
        ranked_games
)
SELECT 
    streak_id,
    wl,
    MIN(game_date) AS streak_start,
    MAX(game_date) AS streak_end,
    COUNT(DISTINCT game_id) AS streak_length
FROM 
    streaks
GROUP BY 
    streak_id, wl