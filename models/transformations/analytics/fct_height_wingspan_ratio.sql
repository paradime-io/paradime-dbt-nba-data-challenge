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
    round(avg(height_wingspan_ratio),3) as height_wingspan_ratio,
    round(avg(points),3) as points,
    round(avg(field_goal_pct),3) as field_goal_pct,
    round(avg(three_point_pct),3) as three_point_pct,
    round(avg(free_throw_pct),3) as free_throw_pct,
    round(avg(total_rebounds),3) as total_rebounds,
    round(avg(assists),3) as assists,
    round(avg(steals),3) as steals,
    round(avg(blocks),3) as blocks,
    round(avg(effective_field_goal_percentage),3) as effective_field_goal_percentage,
    round(avg(true_shooting_percentage),3) as true_shooting_percentage,
    round(avg(rebound_percentage),3) as rebound_percentage,
    round(avg(steal_percentage),3) as steal_percentage,
    round(avg(block_percentage),3) as block_percentage,
    round(avg(per),3) as per
from height_wingspan_ratio_cte
group by 
    percentile
order by 
    percentile