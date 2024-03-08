WITH stats AS (
    SELECT
        AVG(player_success_index) AS avg_psi,
        STDDEV(player_success_index) AS stddev_psi
    FROM
        {{ ref('int_rookie_season_performance') }}
),
ranked_players AS (
    SELECT
        p.player_id,
        p.rookie_season,
        p.scoring_efficiency,
        p.versatility_score,
        p.impact_score,
        p.player_success_index,
        s.avg_psi,
        s.stddev_psi,
        (p.player_success_index - s.avg_psi) / NULLIF(s.stddev_psi, 0) AS z_score
    FROM
        {{ ref('int_rookie_season_performance') }} AS p
    CROSS JOIN
        stats AS s
),
enriched_players AS (
    SELECT
        rp.player_id,
        rp.rookie_season,
        rp.scoring_efficiency,
        rp.versatility_score,
        rp.impact_score,
        rp.player_success_index,
        rp.z_score,
        CONCAT(pi.first_name, ' ', pi.last_name) AS player_name
    FROM
        ranked_players AS rp
    JOIN
        {{ ref('cstg_rookie_player_stats') }} AS pi 
        ON rp.player_id = pi.player_id
)

SELECT
    DISTINCT 
    ep.player_id,
    ep.player_name,
    ep.rookie_season,
    ep.scoring_efficiency,
    ep.versatility_score,
    ep.impact_score,
    ep.player_success_index,
    CASE
        WHEN ep.z_score > 1 THEN 'Top Potential'
        WHEN ep.z_score <= 1 AND ep.z_score > 0 THEN 'High Potential'
        WHEN ep.z_score <= 0 AND ep.z_score > -1 THEN 'Medium Potential'
        ELSE 'Needs Development'
    END AS success_tier
FROM
    enriched_players AS ep
