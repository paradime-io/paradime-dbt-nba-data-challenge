-- The initial Common Table Expression (CTE) aggregates player game logs. It identifies players who have played more than 0 minutes, essentially filtering out players who have no playing time recorded.
with player_school as (
    select
        PLAYER_ID,
        SCHOOL
    from {{ ref('stg_common_player_info') }}
    qualify count(PLAYER_ID) over(partition by SCHOOL) > 20
),

game_logs_aggregated as (
    select
        PLAYER_ID,
        PLAYER_NAME,

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
        SUM(total_points) AS total_points,
        -- Plus-minus statistic for the player
        -- Plus-minus statistic for the player
        SUM(plus_minus) AS plus_minus,
        -- Total minutes played by the player
        SUM(mins_played) AS mins_played,
        -- Count of losses when the player participated
        SUM(loss_counter) AS loss_counter,
        -- Count of wins when the player participated
        SUM(win_counter) AS win_counter,
        -- Count of games played (excluding games with 0 minutes played)
        SUM(CASE WHEN mins_played > 0 THEN 1 ELSE 0 END) AS games_played_counter
    from {{ ref('player_game_logs_agg_example') }}
    where SEASON > '1970-71'
    group by 1, 2
),

--TODO: add height and country?
player_per_college as (
    select
        player_school.SCHOOL,
        game_logs_aggregated.*
    from player_school
    left join game_logs_aggregated on player_school.PLAYER_ID = game_logs_aggregated.PLAYER_ID
),

final as (
    select
        school,
        count(distinct PLAYER_ID) as count_player,
        avg(field_goal_pct) as avg_field_goal_pct,
        avg(free_throw_pct) as avg_free_throw_pct,
        avg(three_point_pct) as avg_three_point_pct,
        avg(steals) as avg_steals,
        avg(div0(steals, win_counter + loss_counter)) as avg_steals_per_game,
        avg(blocks) as avg_blocks,
        avg(div0(blocks, win_counter + loss_counter)) as avg_blocks_per_game,
        avg(personal_fouls) as avg_personal_fouls,
        avg(div0(personal_fouls, win_counter + loss_counter)) as avg_personal_fouls_per_game,
        avg(total_points) as avg_total_points,
        avg(div0(total_points, win_counter + loss_counter)) as avg_points_per_game,
        avg(total_rebounds) as avg_total_rebounds,
        avg(div0(total_rebounds, win_counter + loss_counter)) as avg_rebounds_per_game,
        avg(div0(win_counter, win_counter + loss_counter)) as avg_win_pct,
        avg(win_counter + loss_counter) as avg_games,
        sum(win_counter + loss_counter) as total_games
    from player_per_college
    group by 1
)

select * from final