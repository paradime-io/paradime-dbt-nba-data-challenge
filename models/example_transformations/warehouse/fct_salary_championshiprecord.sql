with stats_concat as (select concat(team_name, ' ', season) as teamseason, nba_finals_appearance 
from {{ ref('stg_team_stats_by_season')}} )

, spend_concat as (select concat(full_name, ' ', season) as teamseason, team_payroll, 
rank() over (partition by season order by team_payroll desc) as salary_rank 
from {{ ref('stg_team_spend_by_season') }}
order by season desc)

, ctejoin as (select spend_concat.teamseason, spend_concat.team_payroll,
 spend_concat.salary_rank, stats_concat.nba_finals_appearance 
 from spend_concat left join stats_concat on spend_concat.teamseason = stats_concat.teamseason 
 order by nba_finals_appearance)

, final as (select count(nba_finals_appearance), nba_finals_appearance,
 salary_rank from ctejoin where nba_finals_appearance = 'LEAGUE CHAMPION' 
 group by nba_finals_appearance, salary_rank order by salary_rank asc)

select * from final