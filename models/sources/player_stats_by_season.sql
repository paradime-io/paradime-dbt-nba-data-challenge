SELECT 
player_name, 
a.team_name, 
season, 
height, 
draft_year, 
draft_number, 
CASE WHEN draft_year != 'Undrafted' THEN SUBSTRING(season, 0, 4) - draft_year ELSE SUBSTRING(season, 0, 4) - from_year END AS exp, 
COUNT(*) AS games_played, 
SUM(MIN)/COUNT(*) AS minutes_per_game, 
SUM(pts)/COUNT(*) AS points_per_game, 
SUM(pts)/SUM(MIN) AS points_per_minute, 
AVG(plus_minus) AS average_plus_minus
FROM {{ source('NBA', 'PLAYER_GAME_LOGS') }} a 
LEFT JOIN {{ source('NBA', 'COMMON_PLAYER_INFO') }} b ON a.player_id = b.person_id
WHERE game_type = 'Regular Season'
AND min > 0
AND season != '2023-24'
GROUP BY player_name, a.team_name, season, height, draft_year, draft_number, from_year
ORDER BY season DESC, average_plus_minus DESC
