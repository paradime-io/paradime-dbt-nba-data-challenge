WITH player_totals AS (
    SELECT 
        season,
        team_id,
        player_name,
        SUM(PProd) AS PProd,
        SUM(TotPoss) AS TotPoss
    FROM 
        {{ ref('stg_player_game_points_generated_bref') }}
    GROUP BY
        season,
        team_id,
        player_name
),
compute_ows AS (
    SELECT  
        pt.player_name,
        pt.PProd,
        pt.TotPoss,
        l.PTS_POSS,
        l.PTS_GAME,
        t.PACE,
        l.PACE,
        ( pt.PProd - 0.92 * l.PTS_POSS * pt.TotPoss ) / ( 0.3 * l.PTS_GAME * t.PACE / l.PACE ) AS ows
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
    SUM(ows)
FROM 
    compute_ows