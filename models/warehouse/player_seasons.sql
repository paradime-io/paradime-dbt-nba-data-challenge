with
    earnings as (
        select
            player_id,
            season,
            salary_usd as nominal_salary_earnings,
            _2024_adjusted_salary as inflation_adjusted_salary_earnings
        from {{ ref('player_salaries_adjusted_for_inflation') }}
    ),
    season_stats as (
        select
            season,
            player_id,
            player_name,
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
            avg_total_reboundsd,
            avg_assists,
            avg_turnovers,
            avg_steals,
            avg_blocks,
            avg_personal_fouls,
            avg_points,
            avg_plus_minus,
            team_name,
            team_conference_rank,
            team_division_rank,
            team_nba_finals_appearance,
            team_nba_champion
        from {{ ref('player_season_avg_game') }}
    )

select
    player_id,
    player_name,
    season,
    nominal_salary_earnings,
    inflation_adjusted_salary_earnings,
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
    avg_total_reboundsd,
    avg_assists,
    avg_turnovers,
    avg_steals,
    avg_blocks,
    avg_personal_fouls,
    avg_points,
    avg_plus_minus,
    team_name,
    team_conference_rank,
    team_division_rank,
    team_nba_finals_appearance,
    team_nba_champion
from season_stats
inner join earnings using (player_id, season)
