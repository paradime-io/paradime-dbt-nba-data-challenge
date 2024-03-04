with final as (select team_name, season, field_goals_attempted, field_goals_made, three_pointers_attempted, three_pointers_made
from {{ ref('stg_team_stats_by_season') }}
where field_goals_attempted > 0
group by team_name, season, field_goals_attempted, field_goals_made, three_pointers_attempted, three_pointers_made
order by season asc)

select * from final;