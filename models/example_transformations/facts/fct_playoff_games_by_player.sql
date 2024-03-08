WITH playoff_stats AS (
    SELECT
        player_id,
        player_name,
        sum(games_played_counter) AS playoff_games,
        SUM(win_counter) AS playoff_wins,
        sum(field_goals_made) as field_goals_made,
        sum(field_goals_attempted) as field_goals_attempted,
        SUM(field_goals_made) / NULLIF(SUM(field_goals_attempted), 0) AS field_goal_pct,
        sum(three_point_made) as three_point_made,
        sum(three_point_attempted) as three_point_attempted,
        SUM(three_point_made) / NULLIF(SUM(three_point_attempted), 0) AS three_point_pct,
        sum(free_throws_made) as free_throws_made,
        sum(free_throws_attempted) as free_throws_attempted,
        SUM(free_throws_made) / NULLIF(SUM(free_throws_attempted), 0) AS free_throw_pct,
        sum(personal_fouls) as personal_fouls,
        sum(steals) as steals,
        sum(mins_played) as mins_played,
        sum(total_points) as total_points,
        (CAST(playoff_wins AS FLOAT) / playoff_games) AS win_percentage,
        corr(win_percentage, field_goal_pct) as corr1,
        corr(field_goal_pct, win_percentage) as corr2
    FROM
        {{ ref('player_game_logs_agg_example') }}
    WHERE
        game_type = 'Playoffs'
    AND
        mins_played > 0
    GROUP BY
        player_id,
        player_name
),

playoff_win_percentage AS (
    SELECT
        player_id,
        player_name,
        playoff_games,
        playoff_wins,
        win_percentage,
        corr1,
        corr2
    FROM
        playoff_stats
), 

nba_greatest AS (
    SELECT
        player_id,
        greatest_75_member
    FROM
        {{ ref('stg_common_player_info') }}
),

joined AS (
    SELECT
        pwp.*,
        ng.greatest_75_member
    FROM 
        playoff_win_percentage pwp
    JOIN nba_greatest ng ON
        pwp.player_id = ng.player_id
)

SELECT
    player_id,
    CASE 
        WHEN greatest_75_member = 'true' THEN player_name || '*'
        ELSE player_name
    END AS player_name,
    playoff_games,
    playoff_wins,
    win_percentage,
    corr1,
    corr2
FROM
    joined
ORDER BY
    playoff_games DESC, playoff_wins DESC
