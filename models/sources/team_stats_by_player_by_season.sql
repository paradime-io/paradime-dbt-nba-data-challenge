SELECT
a.team_name, 
a.year, 
a.wins, 
a.losses, 
a.nba_finals_appearance, 
b.player_name, 
b.height_inches, 
b.draft_year, 
CASE WHEN b.draft_number = 'Undrafted' OR b.draft_number IS NULL THEN c.max_draft_number+1 ELSE b.draft_number::int END AS draft_number_normalized, 
b.experience, 
b.games_played, 
b.minutes_per_game, 
b.points_per_game, 
b.points_per_minute, 
b.average_plus_minus
FROM {{ source('NBA', 'TEAM_STATS_BY_SEASON') }} a 
LEFT JOIN {{ ref('player_stats_by_season') }} b ON a.team_name = b.team_name AND a.year = b.season
LEFT JOIN {{ ref('undrafted_normalization') }} c ON b.draft_year = c.draft_year_updated
WHERE a.year != '2023-24'
ORDER BY a.year DESC, a.wins DESC, a.team_name, b.minutes_per_game DESC 
