select 
*,

case when max_any_team_match_won = max_team_match_won then team_abbreviation else null end winning_team,
case when max_any_team_match_won != max_team_match_won then team_abbreviation else null end loosing_team
from     
{{ ref('fct_playoff_match_progress') }}

