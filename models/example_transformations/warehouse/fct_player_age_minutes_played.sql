WITH agg_points AS (
  -- Calculate aggregate player points for each season and age.
  SELECT
    season,
    DATEDIFF('year', DATE(birthdate), game_date) AS age,
    SUM(mins_played) AS mins_played
  FROM {{ ref('stg_player_game_logs') }} player_logs
  JOIN {{ ref('stg_common_player_info') }} player
    ON player_logs.player_id = player.player_id
  GROUP BY 1, 2
  HAVING SUM(mins_played) > 0 -- Filter players with no playtime
)

SELECT
  *,
  -- Calculate the percentage of mins_played for each player relative to the season total.
  mins_played / SUM(mins_played) OVER (PARTITION BY season) AS season_points_percentage
FROM agg_points
