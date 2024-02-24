with
    player_games as (
        select
            player_id,
            team_id,
            game_id,
            player_name,
            season,
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
    aggregate_player_season as (
        select
            player_id,
            team_id,
            player_name,
            season,
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
            avg(total_rebounds) as avg_total_reboundsd,
            avg(assists) as avg_assists,
            avg(turnovers) as avg_turnovers,
            avg(steals) as avg_steals,
            avg(blocks) as avg_blocks,
            avg(personal_fouls) as avg_personal_fouls,
            avg(points) as avg_points,
            avg(plus_minus) as avg_plus_minus
        from player_games
        group by 1, 2, 3, 4
    ),
    team_season_stats as (
        select
            team_id,
            team_name,
            season,
            conference_rank,
            division_rank,
            case
                when nba_finals_appearance in ('LEAGUE CHAMPION', 'FINALS APPEARANCE')
                then 1
                else 0
            end as nba_finals_appearance,
            case
                when nba_finals_appearance = 'LEAGUE CHAMPION' then 1 else 0
            end as nba_champion
        from {{ ref('stg_team_stats_by_season') }}
    ),
    join_player_team_stats as (
        select
            aggregate_player_season.*,
            team_season_stats.team_name,
            team_season_stats.conference_rank as team_conference_rank,
            team_season_stats.division_rank as team_division_rank,
            team_season_stats.nba_finals_appearance as team_nba_finals_appearance,
            team_season_stats.nba_champion as team_nba_champion
        from aggregate_player_season
        left join team_season_stats using (team_id, season)
    )

select *
from join_player_team_stats
