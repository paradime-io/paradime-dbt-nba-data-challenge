WITH rookie_performance AS (
    SELECT
        player_id,
        rookie_season,
        -- Scoring Efficiency
        COALESCE(SUM(points) / NULLIF(SUM(field_goals_attempted), 0), 0) AS scoring_efficiency,
        -- Versatility Score
        (
            AVG(COALESCE(assists, 0)) + 
            AVG(COALESCE(total_rebounds, 0)) + 
            AVG(COALESCE(steals, 0)) + 
            AVG(COALESCE(blocks, 0))
        ) AS versatility_score,
        -- Impact on Team Success
        COALESCE(AVG(plus_minus), 0) AS impact_score,
        -- Count of games played
        COUNT(game_id) AS games_played
    FROM
        {{ ref('cstg_rookie_player_stats') }}
    WHERE
        -- Optional: Filter for a minimum number of games played or other criteria, if needed
        game_id IS NOT NULL
    GROUP BY
        player_id,
        rookie_season
)

SELECT
    rp.player_id,
    rp.rookie_season,
    rp.scoring_efficiency,
    rp.versatility_score,
    rp.impact_score,
    rp.games_played,
    -- Player Success Index
    (
        rp.scoring_efficiency * (rp.versatility_score + rp.impact_score)
    ) AS player_success_index
FROM
    rookie_performance rp
