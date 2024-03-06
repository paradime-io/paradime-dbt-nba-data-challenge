with source as (
    select 
    s.* 
    , CAST((s.total_points / NULLIF((2*(s.field_goals_attempted + (0.44*s.free_throws_attempted))),0)) as DECIMAL(6,3)) as ts_percentage
    , CAST((((s.field_goals_attempted + (0.44*s.free_throws_attempted) + s.turnovers) * (g.mins_played/5))
        / NULLIF((s.mins_played * (g.field_goals_attempted + (0.44*g.free_throws_attempted) + g.turnovers)),0)) as DECIMAL(6,3)) as usg_percentage
    from {{ref('player_game_logs_agg')}} s
    join {{ref('game_logs_agg')}} g on g.team_name = s.team_name and g.season = s.season and g.game_type = s.game_type
)

, final as (
    select 
    s.*
    , ((s.year - p.first_year_played) + 1) as year_in_league
    , case when  ((s.year - p.first_year_played) + 1) <=4 then 'Early'
           when ((s.year - p.first_year_played) + 1) > 4 and ((s.year - p.first_year_played) + 1) <= 9 then 'Established'
           when ((s.year - p.first_year_played) + 1) > 9 and ((s.year - p.first_year_played) + 1) <=14 then 'Veteran'
           when ((s.year - p.first_year_played) + 1) > 14 then 'Late Veteran' end as experience_cohort
    from source s
    left join {{ref('player_info')}} p on p.player_id = s.player_id

)

select * from final
