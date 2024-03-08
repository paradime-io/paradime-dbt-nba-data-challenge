SELECT
    player_id,
    season,
    MIN(season) OVER (PARTITION BY player_id) AS rookie_season,
    total_points / NULLIF(total_field_goals_attempted, 0) AS scoring_efficiency,
    (total_assists + total_rebounds + total_steals + total_blocks) / NULLIF(games_played, 0) AS versatility_score,
    average_plus_minus AS impact_score,
    -- Player Success Index (PSI)
    scoring_efficiency * (versatility_score + impact_score) AS psi
FROM
    {{ ref('cstg_player_season_stats') }}
WHERE
    psi IS NOT NULL
