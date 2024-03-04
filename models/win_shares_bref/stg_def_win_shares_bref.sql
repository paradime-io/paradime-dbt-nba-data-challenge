WITH player_totals AS (
    SELECT 
        pt.season,
        pt.team_id,
        pt.player_name,
        SUM(
            (MP / Team_MP) * Tm_Poss * (1.08 * l.PTS_POSS - DRtg / 100)
            --Tm_Poss / 5 * (1.08 * l.PTS_POSS - DRtg / 100)
        ) AS marginal_defense,
        SUM(Tm_Poss) AS Team_Poss,
        AVG(DRTg),
        AVG(l.PTS_POSS)
    FROM 
        {{ ref('stg_player_game_defensive_rating_bref') }} AS pt
    LEFT JOIN 
        {{ ref('stg_league_average') }} AS l 
    ON 
        pt.season = l.season 
    GROUP BY
        pt.season,
        pt.team_id,
        pt.player_name
),
compute_dws AS (
    SELECT  
        pt.player_name,
        pt.marginal_defense,
        pt.Team_Poss,
        marginal_defense / ( 0.3 * l.PTS_GAME * t.PACE / l.PACE ) AS dws
    FROM 
        player_totals AS pt
    LEFT JOIN 
        {{ ref('stg_league_average') }} AS l 
    ON 
        pt.season = l.season 
    LEFT JOIN 
        {{ ref('stg_team_season_average') }} AS t
    ON 
        pt.season = t.season AND pt.team_id = t.team_id
)
SELECT 
    SUM(dws)
FROM 
    compute_dws
