SELECT
  '`' || winning_score || '-' || losing_score AS old_score,
  next_winning_score || '-' || next_losing_score AS new_score,
  COUNT(*) AS number_of_matches
FROM (
  SELECT *,
         CASE WHEN r = 3 AND winning_score != losing_score THEN 1 ELSE 0 END AS death_match
  FROM (
    SELECT *,
           GREATEST(winning_score, losing_score) AS r,
           LAG(GREATEST(winning_score, losing_score)) OVER (
             PARTITION BY season, playoff_match_up_unique_str ORDER BY reverse_rk
           ) AS next,
           LAG(winning_score) OVER (
             PARTITION BY season, playoff_match_up_unique_str ORDER BY reverse_rk
           ) AS next_winning_score,
           LAG(losing_score) OVER (
             PARTITION BY season, playoff_match_up_unique_str ORDER BY reverse_rk
           ) AS next_losing_score
    FROM warehouse.fct_playoff_per_game_win_loss
    WHERE season IN (
      '2022-23',
      '2021-22',
      '2020-21',
      '2019-20',
      '2018-19',
      '2017-18',
      '2016-17',
      '2015-16',
      '2014-15',
      '2013-14',
      '2012-13',
      '2011-12',
      '2010-11',
      '2009-10',
      '2008-09',
      '2007-08',
      '2006-07',
      '2005-06',
      '2004-05',
      '2003-04'
    )
    ORDER BY game_date DESC
  )
  WHERE r = 3 AND winning_score != losing_score
)
GROUP BY 1, 2;
