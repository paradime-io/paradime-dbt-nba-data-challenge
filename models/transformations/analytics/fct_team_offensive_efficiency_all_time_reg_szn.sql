with all_time_off_eff as (
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
        --filter out outliers and missing data
        count(*) = count(offensive_efficiency)
)
select
    *,
    rank() over (order by avg_offensive_efficiency desc) as off_eff_rank
from all_time_off_eff
order by 4