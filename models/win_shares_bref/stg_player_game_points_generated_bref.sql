WITH player_team_stats AS (
    SELECT 
        p.season,
        p.team_id,
        p.game_id,
        p.player_id,
        p.player_name,
        -- PLAYER STATS
        p.min AS MP,
        p.pts AS PTS,
        p.fgm AS FGM,
        p.fga AS FGA,
        p.fg3m AS FG3M,
        p.ftm AS FTM,
        p.fta AS FTA,
        p.ast AS AST,
        p.oreb AS ORB,
        p.tov AS TOV,
        -- TEAM STATS
        t.* EXCLUDE(season, season_id, game_id, team_id)
        -- 
        -- ( 5 * p.min / t.minutes ) AS pct_mins_played

        --( 5 * p.mins_played / t.minutes ) * 1.14 * ( (t.assists - p.assists) / t.field_goals_made ) + (1 - 5 * p.mins_played / t.minutes ) * ( t.assists * p.mins_played * 5 / t.minutes - p.assists ) / ( t.field_goals_made * p.mins_played * 5 / t.minutes - p.field_goals_made ) AS q_ast
    FROM 
        {{ source('NBA', 'PLAYER_GAME_LOGS') }} AS p
    INNER JOIN 
        {{ ref('stg_team_game_advanced_stats_bref') }} AS t
    ON 
        p.team_id = t.team_id
        AND 
        p.game_id = t.game_id
    WHERE 
        -- p.season = '2022-23'
        --AND p.game_id = 22200667
        -- AND p.team_id = 1610612743
        p.season = '2008-09'
        AND p.game_type = 'Regular Season'
        AND p.team_id = 1610612739
),
--  SELECT *
--  FROM player_team_stats
--  WHERE ((Team_FGM / Team_MP) * MP * 5 - FGM) = 0
compute_q_ast AS (
    SELECT
        *, 
        CASE
            WHEN MP = 0 THEN 0
            ELSE ((MP / (Team_MP / 5)) * (1.14 * ((Team_AST - AST) / Team_FGM))) + ((((Team_AST / Team_MP) * MP * 5 - AST) / ((Team_FGM / Team_MP) * MP * 5 - FGM)) * (1 - (MP / (Team_MP / 5)))) 
        END AS qAST
        --pct_mins_played * 1.14 * ( (team_assists - assists) / team_field_goals_made ) + (1 - pct_mins_played ) * ( team_assists * pct_mins_played - assists ) / ( team_field_goals_made * pct_mins_played - field_goals_made ) AS q_ast
    FROM 
        player_team_stats
),
first_step AS (
    SELECT 
        *,
        CASE 
            WHEN FGA = 0 THEN 0
            ELSE FGM * (1 - 0.5 * ((PTS - FTM) / (2 * FGA)) * qAST) 
        END AS FG_Part,
        0.5 * (((Team_PTS - Team_FTM) - (PTS - FTM)) / (2 * (Team_FGA - FGA))) * AST AS AST_Part,
        CASE 
            WHEN FTA = 0 THEN 0
            ELSE (1 - POW(1 - (FTM/FTA), 2)) * 0.4 * FTA 
        END AS FT_Part,
        ORB * Team_ORB_Weight * Team_Play_PCT AS ORB_Part
    FROM 
        compute_q_ast
),
second_step AS (
    SELECT
        *,
        (FG_Part + AST_Part + FT_Part) * (1 - (Team_ORB / Team_Scoring_Poss) * Team_ORB_Weight * Team_Play_PCT) + ORB_Part AS ScPoss,
        (FGA - FGM) * (1 - 1.07 * Team_ORB_PCT) AS FGxPoss,
        CASE
            WHEN FTA = 0 THEN 0
            ELSE POW(1 - (FTM / FTA), 2) * 0.4 * FTA 
        END AS FTxPoss,
        CASE 
            WHEN FGA = 0 THEN 0
            ELSE 2 * (FGM + 0.5 * FG3M) * (1 - 0.5 * ((PTS - FTM) / (2 * FGA)) * qAST) 
        END AS PProd_FG_Part,
        2 * ((Team_FGM - FGM + 0.5 * (Team_FG3M - FG3M)) / (Team_FGM - FGM)) * 0.5 * (((Team_PTS - Team_FTM) - (PTS - FTM)) / (2 * (Team_FGA - FGA))) * AST AS PProd_AST_Part,
        ORB * Team_ORB_Weight * Team_Play_PCT * (Team_PTS / (Team_FGM + (1 - POW(1 - (Team_FTM / Team_FTA), 2)) * 0.4 * Team_FTA)) AS PProd_ORB_Part
    FROM 
        first_step
)
SELECT 
    *,
    ScPoss + FGxPoss + FTxPoss + TOV AS TotPoss,
    (PProd_FG_Part + PProd_AST_Part + FTM) * (1 - (Team_ORB / Team_Scoring_Poss) * Team_ORB_Weight * Team_Play_PCT) + PProd_ORB_Part AS PProd
FROM 
    second_step

--  estimate_possessions AS (
--      SELECT 
--          *,
--          CASE
--              WHEN field_goals_made = 0 THEN 0
--              ELSE field_goals_made * (1 - 0.5 * (points - free_throws_made) * q_ast / (2 * field_goals_made)) 
--          END AS poss_fg,
--          0.5 * ( (team_points - team_field_goals_made) - (points - field_goals_made) ) / (2 * (team_field_goals_attempted - field_goals_attempted)) * assists AS poss_ast,
--          CASE 
--              WHEN free_throws_attempted = 0 THEN 0
--              ELSE (1 - POW(1 - free_throws_made / free_throws_attempted, 2)) * free_throws_attempted * 0.4 
--          END AS poss_ft,
--          offensive_rebounds * team_off_reb_w * team_pos_poss AS poss_or,
--          (field_goals_attempted - field_goals_made) * (1 - 1.07 * team_off_reb_pct) AS poss_missed_fg,
--          CASE
--              WHEN free_throws_attempted = 0 THEN 0
--              ELSE POW(1 - free_throws_made / free_throws_attempted, 2) * free_throws_attempted * 0.4 
--          END AS poss_missed_ft
--      FROM 
--          compute_q_ast
--  ),
--  single_contribution AS (
--      SELECT 
--          *,
--          -- POINTS GENERATED
--          CASE
--              WHEN field_goals_made = 0 THEN 0
--              ELSE (2 * ( field_goals_made + 0.5 * three_point_made ) / field_goals_made ) * poss_fg
--              -- ELSE 2 * ( field_goals_made + 0.5 * three_point_made ) * (1 - 0.5 * (points - free_throws_made) * q_ast / (2 * field_goals_made)) 
--          END AS pts_gen_fg,

--          2 * (( (team_field_goals_made - field_goals_made) + 0.5 * (team_three_point_made - three_point_made) ) / (team_field_goals_made - field_goals_made)) * poss_ast AS pts_gen_ast,
--          --  2 * (( (team_field_goals_made - field_goals_made) + 0.5 * (team_three_point_made - three_point_made) ) / (team_field_goals_made - field_goals_made)) 
--          --  * 0.5 * (( (team_points - team_field_goals_made) - (points - field_goals_made) ) / (2 * (team_field_goals_attempted - field_goals_attempted))) * assists AS pts_gen_ast,

--          1 - team_off_rebounds * team_off_reb_w * team_pos_poss / team_succ_poss AS a_coef,

--          offensive_rebounds * team_off_reb_w * team_points / team_poss AS pts_gen_or

--      FROM   
--          estimate_possessions
--  ),
--  compute_metrics AS (
--      SELECT 
--          season,
--          team_id,
--          game_id,
--          player_id,
--          player_name,

--          team_points,
--          team_points / team_poss AS team_pts_per_poss,

--          pts_gen_fg,
--          pts_gen_ast,
--          a_coef,
--          pts_gen_or,
--          (pts_gen_fg + pts_gen_ast + free_throws_made) * a_coef + pts_gen_or AS pts_gen,
--          turnovers,
--          poss_fg,
--          poss_ast,
--          poss_ft,
--          poss_or,
--          poss_missed_fg,
--          poss_missed_ft,
--          (poss_fg + poss_ast + poss_ft) * a_coef + poss_or + poss_missed_fg + poss_missed_ft + turnovers AS poss_total
--      FROM 
--          single_contribution
--  )
--  SELECT 
--      *,
--      CASE
--          WHEN poss_total = 0 THEN 0
--          ELSE 100 * pts_gen / poss_total
--      END AS off_rating
--  FROM 
--      compute_metrics