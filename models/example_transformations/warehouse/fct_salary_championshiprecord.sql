with stats as (select concat(team_name, ' ', season) as teamseason, nba_finals_appearance 
from {{ ref('stg_team_stats_by_season')}} )
--the above CTE concatenates the team_name and season columns in order to produce a unique string to join the two staging tables
, spend as (select concat(full_name, ' ', season) as teamseason, team_payroll, 
rank() over (partition by season order by team_payroll desc) as salary_rank 
from {{ ref('stg_team_spend_by_season') }}
order by season desc)
--the above CTE also concatenates the same columns and produces a rank of team payrolls per season from greatest to lowest
, ctejoin as (select spend.teamseason, spend.team_payroll,
 spend.salary_rank, stats.nba_finals_appearance 
 from spend left join stats on spend.teamseason = stats.teamseason 
 order by nba_finals_appearance)
--the above CTE joins the previous two CTEs using the concatenated column
, final as (select salary_rank, nba_finals_appearance, count(nba_finals_appearance) as num_championships from ctejoin where nba_finals_appearance = 'LEAGUE CHAMPION' 
 group by nba_finals_appearance, salary_rank order by salary_rank asc)
--the final CTE selects the number of NBA championships that have been won by each salary rank for a given season
select * from final