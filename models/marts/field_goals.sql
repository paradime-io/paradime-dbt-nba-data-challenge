with shots as (
    select *
    from {{ref('stg_player_shots')}}
    )

, final as (
    select 
        *
        , md5(player||quarter||time_remaining) as field_goal_id
        , made as is_made
        -- Centering shot coordinate sysem
        --, shotx - 25 as shot_coordinate_x
        --, shoty as shot_coordinate_y
        , left(shot_type, 1)::int as points_attempted
        , substr(match_id, 0, 4)::int as game_year
        , substr(match_id, 5, 2)::int as game_month
        , substr(match_id, 7, 2)::int as game_day
        , date_from_parts(game_year, game_month, game_day) as date_of_field_goal_attempt
        -- To refactor
        , case 
            when team = 'PHO' then 'PHX'
            when team = 'BRK' then 'BKN'
            when team = 'CHO' then 'CHA'
            else team end
        as clean_team
        , clean_team || '-' || game_year || '-' || game_month || '-' || game_day as team_game_date
        , split_part(time_remaining, ':', 1)::int as minutes_remaining
        , split_part(time_remaining, ':', 2)::int as seconds_remaining
        --, lead(status, 1, null) over (partition by match_id, team, quarter order by minutes_remaining, seconds_remaining desc) as prev_status_current_quarter
        --, is_game_point
    from shots 
)

select *
from final
--where match_id = '200010310ATL'
--AND QUARTER = '1st quarter'
--and minutes_remaining = 1
--and seconds_remaining <= 50
--and team = 'CHH'
--order by minutes_remaining, seconds_remaining desc