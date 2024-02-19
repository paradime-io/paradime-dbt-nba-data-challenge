-- Aggregate team game logs for regular season and playoff games
WITH team_game_logs_agg AS (
    SELECT 
        team_id,
        team_name,
        season,
        game_type,
        -- Total number of minutes played in minutes
        SUM(game_duration_mins) AS total_game_duration_mins,
        -- Average number of minutes played per game
        AVG(game_duration_mins) AS avg_game_duration_mins,
        -- Total number of points scored by the team
        SUM(points) AS total_points,
        -- Average number of points scored per game
        AVG(points) AS avg_points,
        -- Total number of field goals made by the team
        SUM(field_goals_made) AS total_field_goals_made,
        -- Average number of field goals made per game
        AVG(field_goals_made) AS avg_field_goals_made,
        -- Total number of field goals attempted by the team
        SUM(field_goals_attempted) AS total_field_goals_attempted,
        -- Average number of field goals attempted per game
        AVG(field_goals_attempted) AS avg_field_goals_attempted,
        -- Average field goal percentage, calculated by sum of field goals made over attempted
        SUM(field_goals_made) / NULLIF(SUM(field_goals_attempted), 0) AS avg_field_goal_pct,
        -- Average field goal percentage by averaging percentages
        AVG(field_goal_pct) AS field_goal_pct_averaged,
        -- Total number of three-point field goals made by the team
        SUM(three_point_made) AS total_three_pt_made,
        -- Average number of three-point field goals made per game
        AVG(three_point_made) AS avg_three_pt_made,
        -- Total number of three-point field goals attempted by the team
        SUM(three_point_attempted) AS total_three_pt_attempted,
        -- Average number of three-point field goals attempted per game
        AVG(three_point_attempted) AS avg_three_pt_attempted,
        -- Average three-point field goal percentage, calculated by sum of field goals made over attempted
        SUM(three_point_made) / NULLIF(SUM(three_point_attempted), 0) AS avg_three_ptl_pct,
        -- Average three-point field goal percentage by averaging percentages
        AVG(three_point_pct) AS three_pt_pct_averaged,
        -- Total number of free throws made by the team
        SUM(free_throws_made) AS total_free_throws__made,
        -- Average number of free throws made per game
        AVG(free_throws_made) AS avg_free_throws_made,
        -- Total number of free throws attempted by the team
        SUM(free_throws_attempted) AS total_free_throws_attempted,
        -- Average number of free throws attempted per game
        AVG(free_throws_attempted) AS avg_free_throws_attempted,
        -- Average free throws percentage, calculated by sum of free throws made over attempted
        SUM(free_throws_made) / NULLIF(SUM(free_throws_attempted), 0) AS avg_free_throws_pct,
        -- Average free throw percentage by averaging percentages
        AVG(free_throw_pct) AS free_throws_pct_averaged,
        -- Total rebounds grabbed by the team
        SUM(total_rebounds) AS total_rebounds,
        -- Average rebounds grabbed by the team
        AVG(total_rebounds) AS avg_rebounds,
        -- Total offensive rebounds grabbed by the team
        SUM(offensive_rebounds) AS total_offensive_rebounds,
        -- Average offensive rebounds grabbed by the team per game
        AVG(offensive_rebounds) AS avg_offensive_rebounds,
        -- Total defensive rebounds grabbed by the team per game
        SUM(defensive_rebounds) AS total_defensive_rebounds,
        -- Average rebounds grabbed by the team per game
        AVG(defensive_rebounds) AS avg_defensive_rebounds,
        -- Total assists made by the team
        SUM(assists) AS total_assists,
        -- Average rebounds grabbed by the team per game
        AVG(assists) AS avg_assists,
        -- Total blocks made by the player
        SUM(blocks) AS total_blocks,
        -- Average blocks grabbed by the team per game
        AVG(blocks) AS avg_blocks,        
        -- Total steals made by the player
        SUM(steals) AS total_steals,
        -- Average steals grabbed by the team per game
        AVG(steals) AS avg_steals,
        -- Total personal fouls committed by the player
        SUM(personal_fouls) AS personal_fouls,
        -- Average personal fouls by the team per game
        AVG(personal_fouls) AS avg_personal_fouls,
        -- Total turnovers committed by the player
        SUM(turnovers) AS turnovers,
        -- Average turnovers grabbed by the team per game
        AVG(turnovers) AS avg_turnovers,
        -- Assists to turnover ratio
        SUM(assists) / NULLIF(SUM(turnovers), 0) assist_to_turnover_ratio,
        -- Count of losses
        SUM(CASE WHEN wl = 'L' THEN 1 ELSE 0 END) AS loss_counter,
        -- Count of wins
        SUM(CASE WHEN wl = 'W' THEN 1 ELSE 0 END) AS win_counter
    FROM 
        -- Reference to the source data table containing game logs
        {{ ref('stg_games') }}
    GROUP BY 
        team_id, team_name, season, game_type
)

-- Select all aggregated team game statistics
SELECT
    * 
FROM
    team_game_logs_agg
    
