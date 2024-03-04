WITH add_opponent_stats AS (
    SELECT 
        t.season_id,
        t.season,
        t.team_id,
        t.game_id,
        t.min AS Team_MP,
        --t.pts,
        -- TEAM STATS
        t.pts AS Team_PTS,
        t.fgm AS Team_FGM,
        t.fga AS Team_FGA,
        t.ftm AS Team_FTM,
        t.fta AS Team_FTA,
        t.fg3m AS Team_FG3M,
        t.ast AS Team_AST,
        t.dreb AS Team_DRB,
        t.oreb AS Team_ORB,
        t.tov AS Team_TOV,
        t.blk AS Team_BLK,
        t.stl AS Team_STL,
        t.pf AS Team_PF,
        -- OPPONENT STATS
        o.min AS Opp_MP,
        o.pts AS Opp_PTS,
        o.fgm AS Opp_FGM,
        o.fga AS Opp_FGA,
        o.ftm AS Opp_FTM,
        o.fta AS Opp_FTA,
        o.dreb AS Opp_DRB,
        o.oreb AS Opp_ORB,
        o.tov AS Opp_TOV


        --  t.oreb,
        --  t.tov,
        -- ADVANCED STATS
        --  t.offensive_rebounds / (t.offensive_rebounds + o.defensive_rebounds) AS off_reb_pct,
        --  o.offensive_rebounds / (o.offensive_rebounds + t.defensive_rebounds) AS opp_off_reb_pct,

        --  o.field_goal_pct AS opp_fg_pct,

        --  t.field_goals_made + (1 - POW(1 - t.free_throws_made / t.free_throws_attempted, 2)) * t.free_throws_attempted * 0.4 AS succ_poss,
        --  t.field_goals_attempted + 0.4 * t.free_throws_attempted + t.turnovers AS poss,

        --  o.field_goals_made + (1 - POW(1 - o.free_throws_made / o.free_throws_attempted, 2)) * o.free_throws_attempted * 0.4 AS opp_succ_poss,
        --  o.field_goals_attempted + 0.4 * o.free_throws_attempted + o.turnovers AS opp_poss
    FROM 
        {{ source('NBA', 'GAMES') }} AS t 
    LEFT JOIN 
        {{ source('NBA', 'GAMES') }} AS o
    ON 
        t.game_id = o.game_id AND t.team_id <> o.team_id
    WHERE 
        t.season = '2008-09'
        --  t.season = '2022-23'
        --  AND t.game_id = 22200667
        --  AND t.team_id = 1610612743
        AND t.game_type = 'Regular Season'
),
first_step AS (
    SELECT 
        *,
        Team_FGM + (1 - POW(1 - (Team_FTM / Team_FTA), 2)) * Team_FTA * 0.4 AS Team_Scoring_Poss,
        Team_FGA + Team_FTA * 0.4 + Team_TOV AS Team_Poss,
        Team_ORB / (Team_ORB + Opp_DRB) AS Team_ORB_PCT,
        Opp_ORB / (Opp_ORB + Team_DRB) AS Opp_ORB_PCT,
        OPP_FGM / Opp_FGA AS Opp_FG_PCT,
        0.5 * ((Team_FGA + 0.4 * Team_FTA - 1.07 * (Team_ORB / (Team_ORB + Opp_DRB)) * (Team_FGA - Team_FGM) + Team_TOV) + (Opp_FGA + 0.4 * Opp_FTA - 1.07 * (Opp_ORB / (Opp_ORB + Team_DRB)) * (Opp_FGA - Opp_FGM) + Opp_TOV)) AS Poss,
        Team_FGA + 0.4 * Team_FTA - 1.07 * (Team_ORB / (Team_ORB + Opp_DRB)) * (Team_FGA - Team_FGM) + Team_TOV AS Tm_Poss,
        Opp_FGA + 0.4 * Opp_FTA - 1.07 * (Opp_ORB / (Opp_ORB + Team_DRB)) * (Opp_FGA - Opp_FGM) + Opp_TOV AS Opp_Poss
    FROM 
        add_opponent_stats
),
second_step AS (
    SELECT
        *,
        Team_Scoring_Poss / Team_Poss AS Team_Play_PCT,
        48 * (Tm_Poss + Opp_Poss) / (2 * Team_MP / 5) AS PACE,
        100 * (Opp_PTS / Tm_Poss) AS Team_Defensive_Rating
    FROM 
        first_step
)
SELECT
    *,
    ((1 - Team_ORB_PCT) * Team_Play_PCT) / ((1 - Team_ORB_PCT) * Team_Play_PCT + Team_ORB_PCT * (1 - Team_Play_PCT)) AS Team_ORB_Weight
FROM 
    second_step