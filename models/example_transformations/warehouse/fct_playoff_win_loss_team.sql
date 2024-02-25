SELECT
  *,
  CASE WHEN max_any_team_match_won = max_team_match_won THEN team_abbreviation ELSE NULL END AS winning_team,
  CASE WHEN max_any_team_match_won != max_team_match_won THEN team_abbreviation ELSE NULL END AS losing_team
FROM {{ ref('fct_playoff_match_progress') }}
