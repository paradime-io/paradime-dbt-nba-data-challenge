with all_time_def_eff as (
    select 
        team_name,
        season,
        round(avg(defensive_efficiency), 3) as avg_defensive_efficiency
    from {{ ref('team_advanced_stats')}}
    where game_type = 'Regular Season'
    group by 
        team_name,
        season
    having
        --filter out outliers and missing data
        count(*) = count(defensive_efficiency)
)
select
    *,
    rank() over (order by avg_defensive_efficiency desc) as def_eff_rank
from all_time_def_eff
order by 4