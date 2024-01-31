-- Calculate playoff appearances and percentages for NBA teams

-- Common Table Expressions (CTEs)
-- Select relevant team stats and identify the most recent season for each team
WITH recent_team_stats AS (
    SELECT
        team_id,
        team_name,
        season,
        -- Use ROW_NUMBER() to assign a unique rank (rn) to each row within a team's partition
        -- The rows are ordered by season in descending order for each team
        -- This ensures that the most recent season gets rn = 1 for each team
        ROW_NUMBER() OVER (PARTITION BY team_id ORDER BY season DESC) AS rn,
        -- Check if both playoff_wins and playoff_losses are equal to zero
        -- If true, set playoff_appearance to 0; otherwise, set it to 1
        CASE WHEN playoff_wins = 0 AND playoff_losses = 0 THEN 0 ELSE 1 END AS playoff_appearance
    FROM
        {{ ref('stg_team_stats_by_season') }}
    WHERE 
        season NOT IN ('2023-2024')
),

-- Determine the most recent team name for each team
most_recent_team_names AS (
    SELECT
        team_id,
        team_name
    FROM
        recent_team_stats
    WHERE
        rn = 1
),

-- Count seasons played and sum playoff appearances for each team
seasons_played AS (
    SELECT
        team_id,
        COUNT(team_id) AS seasons_played,
        SUM(playoff_appearance) AS playoff_appearances
    FROM
        recent_team_stats
    GROUP BY
        team_id
),

-- Calculate playoff appearance percentage for each team
playoff_appearance_pct AS (
    SELECT 
        sp.team_id,
        sp.seasons_played,
        sp.playoff_appearances,
        -- Calculate playoff appearance percentage (playoff_appearances / seasons_played)
        sp.playoff_appearances / sp.seasons_played AS playoff_appearance_pct
    FROM
        seasons_played sp
)

-- Final query to retrieve results
SELECT 
    pat.team_id,
    mrt.team_name,
    pat.seasons_played,
    pat.playoff_appearances,
    pat.playoff_appearance_pct
FROM
    playoff_appearance_pct pat
JOIN
    most_recent_team_names mrt ON pat.team_id = mrt.team_id
ORDER BY 
    pat.playoff_appearances DESC
