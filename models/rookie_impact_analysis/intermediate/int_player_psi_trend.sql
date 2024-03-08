WITH enumerated_seasons AS (
    SELECT
        player_id,
        psi,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY season) AS season_enum
    FROM
        {{ ref('int_player_psi_per_season') }}
)

SELECT
    player_id,
    COALESCE(REGR_SLOPE(psi, season_enum), 0) AS psi_trend
FROM
    enumerated_seasons
GROUP BY
    player_id
