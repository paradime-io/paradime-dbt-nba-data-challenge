SELECT
  winning_score || '-' || losing_score AS final_playoff_win_loss,
  COUNT(*) AS number_of_matches
FROM warehouse.fct_playoff_per_game_win_loss
WHERE
  reverse_rk = 1 AND
  season IN (
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
GROUP BY 1;
