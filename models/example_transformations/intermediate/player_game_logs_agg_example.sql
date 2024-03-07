WITH player_game_logs_agg AS (
    SELECT 
        player_id,
        player_name,
        season,
        game_type,
       
        SUM(field_goals_made) AS field_goals_made,
        SUM(field_goals_attempted) AS field_goals_attempted,
        SUM(field_goals_made) / NULLIF(SUM(field_goals_attempted), 0) AS field_goal_pct,
        SUM(three_point_made) AS three_point_made,
        SUM(three_point_attempted) AS three_point_attempted,
        SUM(three_point_made) / NULLIF(SUM(three_point_attempted), 0) AS three_point_pct,
        SUM(free_throws_made) AS free_throws_made,
        SUM(free_throws_attempted) AS free_throws_attempted,
        SUM(free_throws_made) / NULLIF(SUM(free_throws_attempted), 0) AS free_throw_pct,
        SUM(total_rebounds) AS total_rebounds,
        SUM(offensive_rebounds) AS offensive_rebounds,
        SUM(defensive_rebounds) AS defensive_rebounds,
        SUM(assists) AS assists,
        SUM(blocks) AS blocks,
        SUM(steals) AS steals,
        SUM(personal_fouls) AS personal_fouls,
        SUM(turnovers) AS turnovers,
        SUM(points) AS total_points,
        AVG(points) AS avg_points,
        SUM(plus_minus) AS plus_minus,
        SUM(mins_played) AS mins_played,
        SUM(CASE WHEN win_loss = 'L' THEN 1 ELSE 0 END) AS loss_counter,
        SUM(CASE WHEN win_loss = 'W' THEN 1 ELSE 0 END) AS win_counter,
        SUM(CASE WHEN mins_played > 0 THEN 1 ELSE 0 END) AS games_played_counter
    FROM 
        {{ ref('stg_player_game_logs') }}
    GROUP BY 
        player_id, player_name, season, game_type
)

SELECT
    * 
FROM
    player_game_logs_agg
