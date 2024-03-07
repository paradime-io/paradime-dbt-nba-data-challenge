with player_game_logs as (
    select *
    from {{ref('stg_player_game_logs')}}
)

select *
, left(season, 4)::integer as season_start_year
from player_game_logs