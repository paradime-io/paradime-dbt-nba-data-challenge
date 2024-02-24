with
    source as (select * from {{ source('NBA', 'GAMES') }}),

    renamed as (
        select
            season_id,
            team_id,
            team_abbreviation,
            team_name,
            game_id,
            game_date,
            matchup,
            wl,
            min as game_duration_mins,
            pts as points,
            fgm as field_goals_made,
            fga as field_goals_attempted,
            fg_pct as field_goal_pct,
            fg3m as three_point_made,
            fg3a as three_point_attempted,
            fg3_pct as three_point_pct,
            ftm as free_throws_made,
            fta as free_throws_attempted,
            ft_pct as free_throw_pct,
            oreb as offensive_rebounds,
            dreb as defensive_rebounds,
            reb as total_rebounds,
            ast as assists,
            stl as steals,
            blk as blocks,
            tov as turnovers,
            pf as personal_fouls,
            plus_minus,
            season,
            game_type
        from source
    )

select *
from renamed
