with team_three_pointers as (select team_name, season, three_pointers_attempted
from {{ ref('stg_team_stats_by_season') }}
where three_pointers_attempted > 0
group by team_name, season, three_pointers_attempted
order by season asc)
--the above CTE produces the number of three pointers attempted per team per season from the first available data in 1982
, team_rank as (select team_name, season, three_pointers_attempted, 
dense_rank() over (partition by season order by three_pointers_attempted desc) as three_point_rank from team_three_pointers)
--the above CTE produces a team ranking and quantity of three pointers attempted per team per season
, final as (select team_name, season, three_point_rank, three_pointers_attempted from team_rank 
where three_point_rank between 1 and 5 group by team_name, season, three_point_rank, three_pointers_attempted 
order by season asc, three_point_rank asc)
--the above CTE produces the top five ranked teams per season by three pointers attempted and the number of three pointers attempted by each team
select * from final