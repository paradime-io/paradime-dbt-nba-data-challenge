with source as (
    select * from {{ref('game_logs_agg')}}
)
select * from source