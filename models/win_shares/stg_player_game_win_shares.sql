WITH win_shares AS (
    SELECT
        po.game_id,
        po.player_id,
        po.player_name,
        ( po.pts_gen - 0.92 * l.points_per_poss * po.poss_total ) / ( 0.32 * l.points_per_game * t.poss / l.poss ) AS ows,
        --( po.pts_gen - 0.92 * po.team_pts_per_poss * po.poss_total ) / ( 0.32 * po.team_points ) AS ows_game,
        pd.mins_played_pct * pd.opp_poss * ( 1.08 * l.points_per_poss - pd.def_rating /100 ) / ( 0.32 * l.points_per_game * t.poss / l.poss ) AS dws
        --AS dws_game
    FROM 
        {{ ref('stg_player_game_points_generated') }} AS po
    LEFT JOIN 
        {{ ref('stg_player_game_defensive_rating') }} AS pd ON pd.player_id = po.player_id AND po.game_id = pd.game_id
    LEFT JOIN 
        {{ ref('stg_team_season_stats') }} AS t ON t.team_id = po.team_id AND t.season = po.season
    LEFT JOIN 
        {{ ref('stg_season_stats') }} AS l ON po.season = l.season
)
SELECT 
    player_name,
    SUM(ows) AS off_win_shares,
    --SUM(ows_game) AS off_game_win_shares,
    SUM(dws) AS def_win_shares,
    SUM(ows + dws) AS win_shares
FROM 
    win_shares
GROUP BY 
    player_name
ORDER BY 
    off_win_shares DESC