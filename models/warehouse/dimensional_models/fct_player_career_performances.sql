with
    earnings as (
        select
            player_id,
            sum(salary_usd) as nominal_salary_earnings,
            rank() over (order by sum(salary_usd) desc) as nominal_salary_earnings_rank,
            sum(_2024_adjusted_salary) as inflation_adjusted_salary_earnings,
            rank() over (
                order by sum(_2024_adjusted_salary) desc
            ) as inflation_adjusted_salary_earnings_rank
        from {{ ref('player_salaries_adjusted_for_inflation') }}
        group by 1
    ),
    career_stats as (
        select
            player_id,
            most_common_team_id,
            most_recent_team_id,
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
        from {{ ref('player_career_avg_game') }}
    )

select
    player_id,
    nominal_salary_earnings,
    nominal_salary_earnings_rank,
    inflation_adjusted_salary_earnings,
    inflation_adjusted_salary_earnings_rank,
    most_common_team_id,
    most_recent_team_id,
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
from career_stats
inner join earnings using (player_id)
