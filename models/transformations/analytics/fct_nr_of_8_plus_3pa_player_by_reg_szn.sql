with threepa_per_season as (
    select
        player_name,
        season,
        round(avg(three_point_attempted),3) as avg_three_point_attempted
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
from threepa_per_season
where avg_three_point_attempted >= 8
group by 
    season