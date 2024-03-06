-- Aggregate player game logs for regular season games
WITH player_game_logs_agg AS (
    SELECT 
        player_id,
        player_name,
        season,
        game_type,
        -- Total field goals made by the player
        SUM(field_goals_made) AS field_goals_made,
        -- Total field goals attempted by the player
        SUM(field_goals_attempted) AS field_goals_attempted,
        -- Field goal percentage (made attempts over total attempts)
        SUM(field_goals_made) / NULLIF(SUM(field_goals_attempted), 0) AS field_goal_pct,
        -- Total three-point field goals made by the player
        SUM(three_point_made) AS three_point_made,
        -- Total three-point field goals attempted by the player
        SUM(three_point_attempted) AS three_point_attempted,
        -- Three-point field goal percentage
        SUM(three_point_made) / NULLIF(SUM(three_point_attempted), 0) AS three_point_pct,
        -- Total free throws made by the player
        SUM(free_throws_made) AS free_throws_made,
        -- Total free throws attempted by the player
        SUM(free_throws_attempted) AS free_throws_attempted,
        -- Free throw percentage
        SUM(free_throws_made) / NULLIF(SUM(free_throws_attempted), 0) AS free_throw_pct,
        -- Total rebounds grabbed by the player
        SUM(total_rebounds) AS total_rebounds,
        -- Total offensive rebounds grabbed by the player
        SUM(offensive_rebounds) AS offensive_rebounds,
        -- Total defensive rebounds grabbed by the player
        SUM(defensive_rebounds) AS defensive_rebounds,
        -- Total assists made by the player
        SUM(assists) AS assists,
        -- Total blocks made by the player
        SUM(blocks) AS blocks,
        -- Total steals made by the player
        SUM(steals) AS steals,
        -- Total personal fouls committed by the player
        SUM(personal_fouls) AS personal_fouls,
        -- Total turnovers committed by the player
        SUM(turnovers) AS turnovers,
        -- Total points scored by the player
        SUM(points) AS total_points,
        -- Plus-minus statistic for the player
        AVG(points) AS avg_points,
        -- Plus-minus statistic for the player 
        SUM(plus_minus) AS plus_minus,
        -- Total minutes played by the player
        SUM(mins_played) AS mins_played,
        -- Count of losses when the player participated
        SUM(CASE WHEN win_loss = 'L' THEN 1 ELSE 0 END) AS loss_counter,
        -- Count of wins when the player participated
        SUM(CASE WHEN win_loss = 'W' THEN 1 ELSE 0 END) AS win_counter,
        -- Count of games played (excluding games with 0 minutes played)
        SUM(CASE WHEN mins_played > 0 THEN 1 ELSE 0 END) AS games_played_counter
    FROM 
        -- Reference to the source data table containing player game logs
        {{ ref('stg_player_game_logs') }}
    GROUP BY 
        player_id, player_name, season, game_type
)

-- Select all aggregated player game statistics
SELECT
    * 
FROM
    player_game_logs_agg
    
