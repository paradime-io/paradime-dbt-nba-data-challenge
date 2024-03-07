with ppg_per_season as (
    select
        player_name,
        season,
        avg(points) as avg_ppg
    from {{ ref('player_advanced_stats')}}
    where game_type = 'Regular Season'
    --since 3pt-line was introduced
    and left(season,4) >= 1979
    group by
        player_name,
        season
)
select 
    season,
    count(*) as nr_of_players
from ppg_per_season
where avg_ppg >= 25
group by 
    season