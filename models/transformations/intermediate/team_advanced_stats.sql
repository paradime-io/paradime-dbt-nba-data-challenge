with games_home_away as (
    select 
        season_id,
        team_id,
        team_abbreviation,
        team_name,
        game_id,
        game_date,
        matchup,
        case 
            when matchup like '%vs.%'
            then 'home'
            else 'away'
        end as home_away,
        wl,
        game_duration_mins,
        points,
        field_goals_made,
        field_goals_attempted,
        case 
            when field_goals_attempted = 0
            then 0
            else round(100 * field_goals_made / field_goals_attempted, 2) 
        end as field_goal_pct,
        three_point_made,
        three_point_attempted,
        case 
            when three_point_attempted = 0
            then 0
            else round(100 * three_point_made / three_point_attempted, 2)
        end as three_point_pct,
        free_throws_made,
        free_throws_attempted,
        case 
            when free_throws_attempted = 0
            then 0
            else round(100 * free_throws_made / free_throws_attempted, 2) 
        end as free_throw_pct,
        offensive_rebounds,
        defensive_rebounds,
        total_rebounds,
        assists,
        steals,
        blocks,
        turnovers,
        personal_fouls,
        plus_minus,
        season,
        game_type
    from istvanmozes902dyzy_analytics.staging.stg_games
    where field_goals_attempted is not null
    and turnovers is not null
    and free_throws_attempted is not null
    and offensive_rebounds is not null
    and nullif(game_duration_mins,0) is not null
),
opponent_metrics as (
    select
        gha1.*,
        gha2.points as points_allowed,
        gha2.field_goals_made as opponent_field_goals_made,
        gha2.field_goals_attempted as opponent_field_goals_attempted,
        gha2.three_point_made as opponent_three_point_made,
        gha2.three_point_attempted as opponent_three_point_attempted,
        gha2.free_throws_made as opponent_free_throw_made,
        gha2.free_throws_attempted as opponent_free_throws_attempted,
        gha2.offensive_rebounds as opponent_offensive_rebounds,
        gha2.defensive_rebounds as opponent_defensive_rebounds,
        gha2.assists as opponent_assists,
        gha2.blocks as opponent_blocks,
        gha2.turnovers as opponent_turnovers,
        gha2.personal_fouls as opponent_personal_fouls
    from games_home_away as gha1
    left join games_home_away as gha2 
    on gha1.game_id = gha2.game_id
    where gha1.team_name <> gha2.team_name
),
possessions as (
    select 
        *,
        round((field_goals_attempted + 0.44 * free_throws_attempted - 1.07 * (offensive_rebounds/(offensive_rebounds + opponent_defensive_rebounds)) * (field_goals_attempted - field_goals_made) + turnovers),2) as possessions
    from opponent_metrics
)
select
    p1.*,
    p2.possessions as opponent_possessions,
    round(((240 / p1.game_duration_mins) * (p1.possessions + p2.possessions) / 2), 2) as pace,
    round((100 * p1.points / p1.possessions), 2) as offensive_efficiency,
    round((100 * p1.points_allowed / p1.possessions), 2) as defensive_efficiency,
    round((p1.offensive_rebounds / (p1.offensive_rebounds + p1.opponent_defensive_rebounds)), 2) as offensive_rebound_percentage,
    round((p1.defensive_rebounds / (p1.defensive_rebounds + p1.opponent_offensive_rebounds)), 2) as defensive_rebound_percentage,
    round((p1.free_throws_attempted / p1.field_goals_attempted), 2) as free_throw_rate
from possessions as p1
left join possessions as p2
on p1.game_id = p2.game_id
where p1.team_name <> p2.team_name
order by p1.game_id