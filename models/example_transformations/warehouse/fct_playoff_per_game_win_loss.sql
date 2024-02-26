WITH win AS (
  -- Select all columns from `fct_playoff_win_loss_team` where `winning_team` is not null.
  SELECT *
  FROM {{ ref('fct_playoff_win_loss_team') }}
  WHERE winning_team IS NOT NULL
),

lost AS (
  -- Select all columns from `fct_playoff_win_loss_team` where `loosing_team` is not null.
  SELECT *
  FROM {{ ref('fct_playoff_win_loss_team') }}
  WHERE losing_team IS NOT NULL
)

SELECT
  win.season,
  win.game_id,
  win.game_date,
  win.playoff_match_up_unique_str,
  win.team_abbreviation AS winning_team,
  lost.team_abbreviation AS losing_team,
  win.team_match_won AS winning_score,
  lost.team_match_won AS losing_score,
  ROW_NUMBER() 
  OVER (PARTITION BY win.season, win.playoff_match_up_unique_str ORDER BY win.game_date DESC) AS reverse_rk,
  GREATEST(winning_score, losing_score) as greatest_score,
  LEAST(winning_score, losing_score) as least_Score,
  LAG(GREATEST(winning_score, losing_score)) OVER (
        PARTITION BY win.season, win.playoff_match_up_unique_str ORDER BY win.game_date DESC
  ) AS next_greatest_score,
  LAG(LEAST(winning_score, losing_score)) OVER (
        PARTITION BY win.season, win.playoff_match_up_unique_str ORDER BY win.game_date DESC
  ) AS next_least_score, 
    LAG(winning_score) OVER (
        PARTITION BY win.season, win.playoff_match_up_unique_str ORDER BY win.game_date DESC
    ) AS next_winning_score,
    LAG(losing_score) OVER (
        PARTITION BY win.season, win.playoff_match_up_unique_str ORDER BY win.game_date DESC
    ) AS next_losing_score
FROM win
JOIN lost ON win.game_id = lost.game_id
