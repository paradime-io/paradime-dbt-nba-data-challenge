SELECT
  season,
  team_name,
  1 AS value
FROM warehouse.fct_team_season_points_pivot
WHERE
  season NOT IN ('2023-24')
  AND (home_points_scored / home_matches_played) < (away_points_scored / away_matches_played)
ORDER BY
  season ASC,
  team_abbreviation ASC;
