with
    player_games as (
        select
            player_id,
            game_id,
            player_name,
            team_name,
            game_date,
            win_loss,
            mins_played,
            field_goals_made,
            field_goals_attempted,
            field_goal_pct,
            three_point_made,
            three_point_attempted,
            three_point_pct,
            free_throws_made,
            free_throws_attempted,
            free_throw_pct,
            offensive_rebounds,
            defensive_rebounds,
            total_rebounds,
            assists,
            turnovers,
            steals,
            blocks,
            personal_fouls,
            points,
            plus_minus
        from {{ ref('stg_player_game_logs') }}
    ),
    latest_player_team as (
        select distinct player_id, team_name as most_recent_team
        from player_games
        where
            game_date = (
                select max(game_date)
                from player_games pg2
                where player_games.player_id = pg2.player_id
            )
    ),
    aggregate_player as (
        select
            player_id,
            player_name,
            mode(team_name) as most_common_team,
            count(distinct game_id) as games_played,
            sum(case when win_loss = 'W' then 1 when win_loss = 'L' then 0 end)
            / sum(case when win_loss in ('W', 'L') then 1 end) as win_probability,
            avg(mins_played) as avg_mins_played,
            avg(field_goals_made) as avg_field_goals_made,
            avg(field_goals_attempted) as avg_field_goals_attempted,
            avg(field_goal_pct) as avg_field_goal_pct,
            avg(three_point_made) as avg_three_point_made,
            avg(three_point_attempted) as avg_three_point_attempted,
            avg(three_point_pct) as avg_three_point_pct,
            avg(free_throws_made) as avg_free_throws_made,
            avg(free_throws_attempted) as avg_free_throws_attempted,
            avg(free_throw_pct) as avg_free_throw_pct,
            avg(offensive_rebounds) as avg_offensive_rebounds,
            avg(defensive_rebounds) as avg_defensive_rebounds,
            avg(total_rebounds) as avg_total_rebounds,
            avg(assists) as avg_assists,
            avg(turnovers) as avg_turnovers,
            avg(steals) as avg_steals,
            avg(blocks) as avg_blocks,
            avg(personal_fouls) as avg_personal_fouls,
            avg(points) as avg_points,
            avg(plus_minus) as avg_plus_minus
        from player_games
        group by 1, 2
    ),
    join_all_player_data as (
        select
            player_id,
            player_name,
            most_common_team,
            most_recent_team,
            games_played,
            win_probability,
            avg_mins_played,
            avg_field_goals_made,
            avg_field_goals_attempted,
            avg_field_goal_pct,
            avg_three_point_made,
            avg_three_point_attempted,
            avg_three_point_pct,
            avg_free_throws_made,
            avg_free_throws_attempted,
            avg_free_throw_pct,
            avg_offensive_rebounds,
            avg_defensive_rebounds,
            avg_total_rebounds,
            avg_assists,
            avg_turnovers,
            avg_steals,
            avg_blocks,
            avg_personal_fouls,
            avg_points,
            avg_plus_minus
        from aggregate_player
        inner join latest_player_team using (player_id)
    )

select *
from join_all_player_data
