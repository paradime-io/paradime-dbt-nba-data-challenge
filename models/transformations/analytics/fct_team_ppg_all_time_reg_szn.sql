select 
    team_name,
    season,
    avg(points) as avg_points
from {{ ref('team_advanced_stats')}}
where game_type = 'Regular Season'
--after 3pt-line was introduced
and left(season,4) >= 1979 
group by 
    team_name,
    season
order by
    3 desc