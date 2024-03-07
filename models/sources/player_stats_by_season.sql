SELECT 
a.player_id,
a.player_name, 
a.team_name, 
a.season, 
b.height, 
c.height_inches,
(CASE WHEN b.draft_year = 'Undrafted' THEN b.from_year ELSE b.draft_year END)::int AS draft_year, 
b.draft_number, 
CASE WHEN b.draft_year != 'Undrafted' THEN SUBSTRING(a.season, 0, 4) - b.draft_year ELSE SUBSTRING(season, 0, 4) - b.from_year END AS experience, 
COUNT(*) AS games_played, 
SUM(a.min)/COUNT(*) AS minutes_per_game, 
SUM(a.pts)/COUNT(*) AS points_per_game, 
SUM(a.pts)/SUM(a.min) AS points_per_minute, 
AVG(a.plus_minus) AS average_plus_minus
FROM {{ source('NBA', 'PLAYER_GAME_LOGS') }} a 
LEFT JOIN {{ source('NBA', 'COMMON_PLAYER_INFO') }} b ON a.player_id = b.person_id
LEFT JOIN {{ ref('height_normalized') }} c ON a.player_id = c.person_id
WHERE a.game_type = 'Regular Season'
AND min > 0
AND season != '2023-24'
GROUP BY a.player_id, a.player_name, a.team_name, a.season, b.height, c.height_inches, b.draft_year, b.draft_number, b.from_year
ORDER BY a.season DESC, average_plus_minus DESC
