WITH final AS (
SELECT player_id,
    rank,
    season
FROM {{ ref('stg_player_salaries_by_season') }}
ORDER BY player_id, season
)

SELECT *
FROM final