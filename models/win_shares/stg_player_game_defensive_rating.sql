WITH player_team_stats AS (
    SELECT 
        p.season,
        p.team_id,
        p.game_id,
        p.player_id,
        p.player_name,
        -- PLAYER STATS
        p.steals,
        p.blocks,
        p.defensive_rebounds,
        p.personal_fouls,
        -- TEAM STATS
        t.steals AS team_steals,
        t.blocks AS team_blocks,
        t.personal_fouls AS team_personal_fouls,
        t.poss AS team_poss,
        t.def_rating AS team_def_rating,
        -- OPPONENT STATS
        t.opp_off_reb_pct,
        t.opp_fg_pct,
        t.opp_poss,
        t.opp_succ_poss,
        t.opp_points,
        t.opp_field_goals_attempted,
        t.opp_field_goals_made,
        t.opp_free_throws_attempted,
        t.opp_free_throws_made,
        t.opp_turnovers,
        -- 
        p.mins_played / t.minutes AS mins_played_pct

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
compute_fm_wt AS (
    SELECT  
        *, 
        ( opp_fg_pct * (1 - opp_off_reb_pct) ) / ( opp_fg_pct * ( 1 - opp_off_reb_pct) + opp_off_reb_pct * (1 - opp_fg_pct) ) AS fm_wt
    FROM 
        player_team_stats
),
estimate_stops AS (
    SELECT 
        *,
        steals + blocks * fm_wt * ( 1 - 1.07 * opp_off_reb_pct ) + defensive_rebounds * ( 1 - fm_wt ) AS stop_1,

        ( opp_field_goals_attempted - opp_field_goals_made - team_blocks ) * fm_wt * ( 1 - 1.07 * opp_off_reb_pct ) * mins_played_pct AS stop_2_fg,
        ( opp_turnovers - team_steals ) * mins_played_pct AS stop_2_to,
        ( personal_fouls / team_personal_fouls ) * 0.4 * opp_free_throws_attempted * POW( 1 - opp_free_throws_made / opp_free_throws_attempted , 2) AS stop_2_ft

    FROM 
        compute_fm_wt
),
single_contribution AS (
    SELECT 
        *,
        CASE
            WHEN mins_played_pct = 0 THEN 0
            ELSE (stop_1 + stop_2_fg + stop_2_to + stop_2_ft ) / ( team_poss * mins_played_pct )
        END AS stop_pct
    FROM   
        estimate_stops
)
SELECT 
    season,
    team_id,
    game_id,
    player_id,
    player_name,
    mins_played_pct,
    opp_poss,
    team_def_rating + 0.2 * ( 100 * (opp_points / opp_succ_poss) * (1 - stop_pct) - team_def_rating ) AS def_rating
FROM 
    single_contribution