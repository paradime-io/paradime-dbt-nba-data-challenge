with all_time_points as (
    select 
        team_name,
        season,
        round(avg(points), 3) as avg_points
    from {{ ref('team_advanced_stats')}}
    where game_type = 'Regular Season'
    --after 3pt-line was introduced
    and left(season,4) >= 1979 
    group by 
        team_name,
        season
)
select
    *,
    rank() over (order by avg_points desc) as point_rank
from all_time_points
order by 4