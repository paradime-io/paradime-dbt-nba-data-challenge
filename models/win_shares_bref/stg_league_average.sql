SELECT 
    season,
    AVG(PACE) AS PACE,
    AVG(Team_PTS) AS PTS_GAME,
    SUM(Team_PTS) / SUM(Tm_Poss) AS PTS_POSS
FROM 
    {{ ref('stg_team_game_advanced_stats_bref') }} 
GROUP BY 
    season