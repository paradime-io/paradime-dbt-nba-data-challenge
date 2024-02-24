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
        , substr(match_id, 0, 4) as game_year
        , substr(match_id, 5, 2) as game_month
        , substr(match_id, 7, 2) as game_day
        -- To refactor
        , case 
            when team = 'PHO' then 'PHX'
            when team = 'BRK' then 'BKN'
            when team = 'CHO' then 'CHA'
            else team end
        as clean_team
        , clean_team || '-' || game_year || '-' || game_month || '-' || game_day as team_game_date
    from shots 
)

select *
from final