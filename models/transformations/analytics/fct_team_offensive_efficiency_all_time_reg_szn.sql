select 
    team_name,
    season,
    avg(offensive_efficiency) as avg_offensive_efficiency
from {{ ref('team_advanced_stats')}}
where game_type = 'Regular Season'
group by 
    team_name,
    season
having
    count(*) = count(offensive_efficiency)
order by
    3 desc