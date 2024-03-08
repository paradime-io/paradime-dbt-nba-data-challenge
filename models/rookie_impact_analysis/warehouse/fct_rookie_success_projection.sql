WITH rookie_score AS (
    SELECT
        player_id,
        (psi - AVG(psi) OVER ()) / NULLIF(STDDEV(psi) OVER (), 0) AS z_score,
        CASE
            WHEN z_score > 3 THEN 'Top Potential'
            WHEN z_score > 1 THEN 'High Potential'
            WHEN z_score > 0 THEN 'Medium Potential'
            ELSE 'Needs Development'
        END AS success_tier
    FROM
        {{ ref('int_player_psi_per_season') }}
    WHERE
        season = rookie_season
)
SELECT
    DISTINCT
    player_id,
    CONCAT(first_name, ' ', last_name) AS player_name,
    rookie_season,
    scoring_efficiency,
    versatility_score,
    impact_score,
    psi,
    psi_trend, 
    z_score,
    success_tier
FROM
    {{ ref('stg_common_player_info') }}
JOIN
    {{ ref('int_player_psi_per_season') }}
    USING (player_id)
JOIN
    {{ ref('int_player_psi_trend') }}
    USING (player_id)
JOIN
    rookie_score
    USING (player_id)
WHERE
    season = rookie_season
