with
    games as (select season, game_date from {{ ref('stg_games') }}),
    agg_dates as (
        select
            season as full_season_id,
            min(game_date) as season_start_date,
            max(game_date) as season_end_date
        from games
        group by 1
    )

select *
from agg_dates
