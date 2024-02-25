WITH final AS (
SELECT 
    season_id,
    team_id,
    game_id
FROM {{ ref('stg_games')}}
)

SELECT *
FROM final