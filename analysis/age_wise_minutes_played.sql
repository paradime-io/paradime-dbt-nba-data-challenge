SELECT
  season,
  age,
  season_points_percentage
FROM warehouse.fct_player_age_minutes_played
WHERE
  season NOT IN ('1950-51', '2023-24')
  AND age BETWEEN 18 AND 45
ORDER BY
  season ASC,
  age ASC;
