with height_wingspan_ratio_cte as (
    select 
        *,
        --split the dataset to 5 percentile
        ntile(5) over (order by height_wingspan_ratio) as percentile
    from {{ ref('player_average_stats_enriched')}} 
    where height_wingspan_ratio is not null
)
select 
    percentile,
    round(avg(height_wingspan_ratio),2) as height_wingspan_ratio,
    round(avg(points),2) as points,
    round(avg(field_goal_pct),2) as field_goal_pct,
    round(avg(three_point_pct),2) as three_point_pct,
    round(avg(free_throw_pct),2) as free_throw_pct,
    round(avg(total_rebounds),2) as total_rebounds,
    round(avg(assists),2) as assists,
    round(avg(steals),2) as steals,
    round(avg(blocks),2) as blocks,
    round(avg(effective_field_goal_percentage),2) as effective_field_goal_percentage,
    round(avg(true_shooting_percentage),2) as true_shooting_percentage,
    round(avg(rebound_percentage),2) as rebound_percentage,
    round(avg(steal_percentage),2) as steal_percentage,
    round(avg(block_percentage),2) as block_percentage,
    round(avg(per),2) as per
from height_wingspan_ratio_cte
group by 
    percentile
order by 
    percentile