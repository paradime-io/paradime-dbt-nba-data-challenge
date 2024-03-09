WITH top_playoff_performances AS (
    SELECT 
    a.player_id,
    a.player_name, 
    a.team_name, 
    a.season, 
    CASE WHEN d.nba_finals_appearance = 'N/A' THEN 'Playoff Contender' 
        WHEN d.nba_finals_appearance = 'FINALS APPEARANCE' THEN 'Finals Appearance'
        WHEN d.nba_finals_appearance = 'LEAGUE CHAMPION' THEN 'League Champion'
        END AS season_outcome,
    b.height, 
    c.height_inches,
    (CASE WHEN b.draft_year = 'Undrafted' THEN b.from_year ELSE b.draft_year END)::int AS draft_year, 
    b.draft_number, 
    CASE WHEN b.draft_year != 'Undrafted' THEN SUBSTRING(a.season, 0, 4) - b.draft_year ELSE SUBSTRING(season, 0, 4) - b.from_year END AS experience, 
    a.game_date, 
    a.pts
    FROM {{ source('NBA', 'PLAYER_GAME_LOGS') }} a 
    LEFT JOIN {{ source('NBA', 'COMMON_PLAYER_INFO') }} b ON a.player_id = b.person_id
    LEFT JOIN {{ ref('height_normalized') }} c ON a.player_id = c.person_id
    LEFT JOIN {{ source('NBA', 'TEAM_STATS_BY_SEASON') }} d ON a.team_name = d.team_name AND a.season = d.year
    WHERE a.game_type = 'Playoffs'
    AND a.season != '2023-24'
    AND a.pts >= 35
    ORDER BY a.season DESC, a.pts DESC
) 
SELECT
team_name, season, season_outcome, COUNT(*) AS top_performances
FROM top_playoff_performances 
WHERE season_outcome IS NOT NULL
GROUP BY all
ORDER BY season DESC, top_performances DESC 
