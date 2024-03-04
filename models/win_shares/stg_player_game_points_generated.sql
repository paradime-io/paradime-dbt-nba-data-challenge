WITH player_team_stats AS (
    SELECT 
        p.season,
        p.team_id,
        p.game_id,
        p.player_id,
        p.player_name,
        -- PLAYER STATS
        p.points,
        p.field_goals_made,
        p.field_goals_attempted,
        p.three_point_made,
        p.free_throws_made,
        p.free_throws_attempted,
        p.assists,
        p.offensive_rebounds,
        p.turnovers,
        -- TEAM STATS
        t.field_goals_made AS team_field_goals_made,
        t.field_goals_attempted AS team_field_goals_attempted,
        t.three_point_made AS team_three_point_made,
        t.assists AS team_assists,
        t.offensive_rebounds AS team_off_rebounds,
        t.points AS team_points,
        t.succ_poss / t.poss AS team_pos_poss,
        t.succ_poss AS team_succ_poss,
        t.off_reb_w AS team_off_reb_w,
        t.off_reb_pct AS team_off_reb_pct,
        t.poss AS team_poss,
        -- 
        ( 5 * p.mins_played / t.minutes ) AS pct_mins_played

        --( 5 * p.mins_played / t.minutes ) * 1.14 * ( (t.assists - p.assists) / t.field_goals_made ) + (1 - 5 * p.mins_played / t.minutes ) * ( t.assists * p.mins_played * 5 / t.minutes - p.assists ) / ( t.field_goals_made * p.mins_played * 5 / t.minutes - p.field_goals_made ) AS q_ast
    FROM 
        {{ ref('stg_player_game_logs') }} AS p
    INNER JOIN 
        {{ ref('stg_team_game_advanced_stats') }} AS t
    ON 
        p.team_id = t.team_id
        AND 
        p.game_id = t.game_id
    WHERE 
        p.season = '2022-23'
        --AND p.game_id = 22200667
        AND p.team_id = 1610612743
),
compute_q_ast AS (
    SELECT  
        *, 
        pct_mins_played * 1.14 * ( (team_assists - assists) / team_field_goals_made ) + (1 - pct_mins_played ) * ( team_assists * pct_mins_played - assists ) / ( team_field_goals_made * pct_mins_played - field_goals_made ) AS q_ast
    FROM 
        player_team_stats
),
estimate_possessions AS (
    SELECT 
        *,
        CASE
            WHEN field_goals_made = 0 THEN 0
            ELSE field_goals_made * (1 - 0.5 * (points - free_throws_made) * q_ast / (2 * field_goals_made)) 
        END AS poss_fg,
        0.5 * ( (team_points - team_field_goals_made) - (points - field_goals_made) ) / (2 * (team_field_goals_attempted - field_goals_attempted)) * assists AS poss_ast,
        CASE 
            WHEN free_throws_attempted = 0 THEN 0
            ELSE (1 - POW(1 - free_throws_made / free_throws_attempted, 2)) * free_throws_attempted * 0.4 
        END AS poss_ft,
        offensive_rebounds * team_off_reb_w * team_pos_poss AS poss_or,
        (field_goals_attempted - field_goals_made) * (1 - 1.07 * team_off_reb_pct) AS poss_missed_fg,
        CASE
            WHEN free_throws_attempted = 0 THEN 0
            ELSE POW(1 - free_throws_made / free_throws_attempted, 2) * free_throws_attempted * 0.4 
        END AS poss_missed_ft
    FROM 
        compute_q_ast
),
single_contribution AS (
    SELECT 
        *,
        -- POINTS GENERATED
        CASE
            WHEN field_goals_made = 0 THEN 0
            ELSE (2 * ( field_goals_made + 0.5 * three_point_made ) / field_goals_made ) * poss_fg
            -- ELSE 2 * ( field_goals_made + 0.5 * three_point_made ) * (1 - 0.5 * (points - free_throws_made) * q_ast / (2 * field_goals_made)) 
        END AS pts_gen_fg,

        2 * (( (team_field_goals_made - field_goals_made) + 0.5 * (team_three_point_made - three_point_made) ) / (team_field_goals_made - field_goals_made)) * poss_ast AS pts_gen_ast,
        --  2 * (( (team_field_goals_made - field_goals_made) + 0.5 * (team_three_point_made - three_point_made) ) / (team_field_goals_made - field_goals_made)) 
        --  * 0.5 * (( (team_points - team_field_goals_made) - (points - field_goals_made) ) / (2 * (team_field_goals_attempted - field_goals_attempted))) * assists AS pts_gen_ast,

        1 - team_off_rebounds * team_off_reb_w * team_pos_poss / team_succ_poss AS a_coef,

        offensive_rebounds * team_off_reb_w * team_points / team_poss AS pts_gen_or

    FROM   
        estimate_possessions
),
compute_metrics AS (
    SELECT 
        season,
        team_id,
        game_id,
        player_id,
        player_name,

        team_points,
        team_points / team_poss AS team_pts_per_poss,

        pts_gen_fg,
        pts_gen_ast,
        a_coef,
        pts_gen_or,
        (pts_gen_fg + pts_gen_ast + free_throws_made) * a_coef + pts_gen_or AS pts_gen,
        turnovers,
        poss_fg,
        poss_ast,
        poss_ft,
        poss_or,
        poss_missed_fg,
        poss_missed_ft,
        (poss_fg + poss_ast + poss_ft) * a_coef + poss_or + poss_missed_fg + poss_missed_ft + turnovers AS poss_total
    FROM 
        single_contribution
)
SELECT 
    *,
    CASE
        WHEN poss_total = 0 THEN 0
        ELSE 100 * pts_gen / poss_total
    END AS off_rating
FROM 
    compute_metrics