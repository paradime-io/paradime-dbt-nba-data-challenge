select 
    season,
    avg(points) as points_per_game,
    avg(effective_field_goal_percentage) as eFG_pct,
    avg(true_shooting_percentage) as TS_pct,
    avg(rebound_percentage) as RBD_pct,
    avg(steal_percentage) as STL_pct,
    avg(block_percentage) as BLK_pct,
    avg(PER) as PER
from  intermediate.player_advanced_stats
--after 3pt-line was introduced
where left(season,4) >= 1979
and game_type = 'Regular Season'
group by 
    season
order by 
    season