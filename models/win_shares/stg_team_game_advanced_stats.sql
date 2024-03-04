WITH add_opponent_stats AS (
    SELECT 
        t.season_id,
        t.season,
        t.team_id,
        t.game_id,
        t.game_duration_mins AS minutes,
        t.points,
        t.field_goals_made,
        t.field_goals_attempted,
        t.three_point_made,
        t.three_point_attempted,
        t.free_throws_made,
        t.free_throws_attempted,
        t.offensive_rebounds,
        t.defensive_rebounds,
        t.assists,
        t.steals,
        t.blocks,
        t.turnovers,
        t.personal_fouls,
        -- OPPONENT STATS
        o.team_id AS opp_team_id,
        o.points AS opp_points,
        o.field_goals_made AS opp_field_goals_made,
        o.field_goals_attempted AS opp_field_goals_attempted,
        o.three_point_made AS opp_three_point_made,
        o.three_point_attempted AS opp_three_point_attempted,
        o.free_throws_made AS opp_free_throws_made,
        o.free_throws_attempted AS opp_free_throws_attempted,
        o.offensive_rebounds AS opp_offensive_rebounds,
        o.defensive_rebounds AS opp_defensive_rebounds,
        o.assists AS opp_assists,
        o.steals AS opp_steals,
        o.blocks AS opp_blocks,
        o.turnovers AS opp_turnovers,
        o.personal_fouls AS opp_personal_fouls,
        -- ADVANCED STATS
        t.offensive_rebounds / (t.offensive_rebounds + o.defensive_rebounds) AS off_reb_pct,
        o.offensive_rebounds / (o.offensive_rebounds + t.defensive_rebounds) AS opp_off_reb_pct,

        o.field_goal_pct AS opp_fg_pct,

        t.field_goals_made + (1 - POW(1 - t.free_throws_made / t.free_throws_attempted, 2)) * t.free_throws_attempted * 0.4 AS succ_poss,
        t.field_goals_attempted + 0.4 * t.free_throws_attempted + t.turnovers AS poss,

        o.field_goals_made + (1 - POW(1 - o.free_throws_made / o.free_throws_attempted, 2)) * o.free_throws_attempted * 0.4 AS opp_succ_poss,
        o.field_goals_attempted + 0.4 * o.free_throws_attempted + o.turnovers AS opp_poss
    FROM 
        {{ ref('stg_games') }} AS t 
    LEFT JOIN 
        {{ ref('stg_games') }} AS o
    ON 
        t.game_id = o.game_id AND t.team_id <> o.team_id
    WHERE 
        t.season = '2022-23'
        --  AND t.game_id = 22200667
        --  AND t.team_id = 1610612743
        AND t.game_type = 'Regular Season'
)
SELECT
    a.*,
    (1 - off_reb_pct) * (succ_poss / poss) / ( (1 - off_reb_pct) * (succ_poss / poss) + (1 - succ_poss / poss) * off_reb_pct ) AS off_reb_w,
    100 * opp_points / poss AS def_rating
FROM 
    add_opponent_stats AS a