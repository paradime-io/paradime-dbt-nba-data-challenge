-- Aggregate player game logs for regular season games
with
    player_game_logs_agg as (
        select
            player_id,
            player_name,
            season,
            game_type,
            -- Total field goals made by the player
            sum(field_goals_made) as field_goals_made,
            -- Total field goals attempted by the player
            sum(field_goals_attempted) as field_goals_attempted,
            -- Field goal percentage (made attempts over total attempts)
            sum(field_goals_made)
            / nullif(sum(field_goals_attempted), 0) as field_goal_pct,
            -- Total three-point field goals made by the player
            sum(three_point_made) as three_point_made,
            -- Total three-point field goals attempted by the player
            sum(three_point_attempted) as three_point_attempted,
            -- Three-point field goal percentage
            sum(three_point_made)
            / nullif(sum(three_point_attempted), 0) as three_point_pct,
            -- Total free throws made by the player
            sum(free_throws_made) as free_throws_made,
            -- Total free throws attempted by the player
            sum(free_throws_attempted) as free_throws_attempted,
            -- Free throw percentage
            sum(free_throws_made)
            / nullif(sum(free_throws_attempted), 0) as free_throw_pct,
            -- Total rebounds grabbed by the player
            sum(total_rebounds) as total_rebounds,
            -- Total offensive rebounds grabbed by the player
            sum(offensive_rebounds) as offensive_rebounds,
            -- Total defensive rebounds grabbed by the player
            sum(defensive_rebounds) as defensive_rebounds,
            -- Total assists made by the player
            sum(assists) as assists,
            -- Total blocks made by the player
            sum(blocks) as blocks,
            -- Total steals made by the player
            sum(steals) as steals,
            -- Total personal fouls committed by the player
            sum(personal_fouls) as personal_fouls,
            -- Total turnovers committed by the player
            sum(turnovers) as turnovers,
            -- Total points scored by the player
            sum(points) as total_points,
            -- Plus-minus statistic for the player
            avg(points) as avg_points,
            -- Plus-minus statistic for the player 
            sum(plus_minus) as plus_minus,
            -- Total minutes played by the player
            sum(mins_played) as mins_played,
            -- Count of losses when the player participated
            sum(case when win_loss = 'L' then 1 else 0 end) as loss_counter,
            -- Count of wins when the player participated
            sum(case when win_loss = 'W' then 1 else 0 end) as win_counter,
            -- Count of games played (excluding games with 0 minutes played)
            sum(case when mins_played > 0 then 1 else 0 end) as games_played_counter
        from
            -- Reference to the source data table containing player game logs
            {{ ref('stg_player_game_logs') }}
        group by player_id, player_name, season, game_type
    )

-- Select all aggregated player game statistics
select *
from player_game_logs_agg
