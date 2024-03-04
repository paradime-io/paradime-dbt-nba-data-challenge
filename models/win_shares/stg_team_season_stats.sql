SELECT 
    season_id,
    season,
    team_id,
    AVG(poss) AS poss
FROM 
    {{ ref('stg_team_game_advanced_stats') }}
GROUP BY 
    season_id,
    season,
    team_id
