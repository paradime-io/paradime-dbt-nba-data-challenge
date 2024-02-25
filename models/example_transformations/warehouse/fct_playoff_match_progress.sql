WITH team_match_won_ranked AS (
  -- Calculate the cumulative number of wins for each team in a match-up,
  -- partitioned by season, match-up ID, and team abbreviation.
  SELECT
    SUM(CASE WHEN wl = 'W' THEN 1 ELSE 0 END) OVER (
      PARTITION BY season, playoff_match_up_unique_str, team_abbreviation ORDER BY game_date
    ) AS team_match_won,
    *
  FROM {{ ref('fct_playoff_unique_clashes') }}
)

SELECT
  *,
  -- Find the maximum number of wins for any team in a match-up within a season,
  -- ignoring team abbreviation.
  MAX(team_match_won) OVER (PARTITION BY season, playoff_match_up_unique_str) AS max_any_team_match_won,
  -- Find the maximum number of wins for a specific team in a match-up within a season.
  MAX(team_match_won) OVER (PARTITION BY season, playoff_match_up_unique_str, team_abbreviation) AS max_team_match_won
FROM team_match_won_ranked
