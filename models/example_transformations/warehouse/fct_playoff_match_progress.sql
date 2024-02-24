with team_match_won_ranked as (
select 
SUM(case when wl = 'W' then 1 else 0 end) OVER 
(partition by season, playoff_match_up_unique_str, team_abbreviation order by game_date) as team_match_won,
* 
from     {{ ref('fct_playoff_unique_clashes') }}
)

select
*,
MAX(team_match_won) OVER (PARTITION BY season, playoff_match_up_unique_str) as max_any_team_match_won,
MAX(team_match_won) OVER (PARTITION BY season, playoff_match_up_unique_str, team_abbreviation) as max_team_match_won
from 
team_match_won_ranked