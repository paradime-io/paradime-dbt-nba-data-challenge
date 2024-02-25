SELECT
  season,
  CASE
    WHEN (home_points_scored / home_matches_played) > (away_points_scored / away_matches_played) THEN 'home_better_than_away'
    ELSE 'away_better_than_home'
  END AS key,
  1 AS value
FROM warehouse.fct_team_season_points_pivot
WHERE season NOT IN ('2023-24')
ORDER BY
  season ASC,
  key DESC;
