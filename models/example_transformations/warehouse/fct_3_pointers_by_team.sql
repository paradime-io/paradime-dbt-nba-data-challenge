with final as (select team_name, season, field_goals_attempted, field_goals_made, three_pointers_attempted, three_pointers_made
from {{ ref('stg_team_stats_by_season') }}
where field_goals_attempted > 0 --some season have zero field goals attempted so this filters those seasons out
group by team_name, season, field_goals_attempted, field_goals_made, three_pointers_attempted, three_pointers_made
order by season asc)
--the above CTE selects the number of FGs and 3Ps attempted and made per team per season
select * from final;