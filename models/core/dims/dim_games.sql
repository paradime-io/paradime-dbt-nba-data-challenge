WITH final AS (
SELECT game_id,
    game_date,
    matchup,
    game_duration,
    
FROM {{ ref('stg_games') }}
WHERE wl='W'
)

SELECT *
FROM final 