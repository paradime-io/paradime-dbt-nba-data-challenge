SELECT 
    season,
    team_id,
    AVG(PACE) AS pace,
    48 * (SUM(Tm_Poss) + SUM(Opp_Poss)) / (2 * SUM(Team_MP) / 5) AS pace_2
FROM 
    {{ ref('stg_team_game_advanced_stats_bref') }} 
--  WHERE 
--      team_id = 1610612739
GROUP BY 
    season,
    team_id
