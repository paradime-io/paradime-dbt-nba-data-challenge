with source as (
    select 
    s.* 
    , CAST((s.total_points / NULLIF((2*(s.field_goals_attempted + (0.44*s.free_throws_attempted))),0)) as DECIMAL(6,3)) as ts_percentage
    , CAST((((s.field_goals_attempted + (0.44*s.free_throws_attempted) + s.turnovers) * (g.mins_played/5))
        / NULLIF((s.mins_played * (g.field_goals_attempted + (0.44*g.free_throws_attempted) + g.turnovers)),0)) as DECIMAL(6,3)) as usg_percentage
    from {{ref('player_game_logs_agg')}} s
    join {{ref('game_logs_agg')}} g on g.team_name = s.team_name and g.season = s.season and g.game_type = s.game_type
)

select * from source
