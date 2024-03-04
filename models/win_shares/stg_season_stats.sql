SELECT 
    season,
    SUM(points) / SUM(poss) AS points_per_poss,
    AVG(points / poss) AS points_per_poss_2,
    AVG(points) AS points_per_game,
    AVG(poss) AS poss
FROM 
    {{ ref('stg_team_game_advanced_stats') }}
GROUP BY 
    season