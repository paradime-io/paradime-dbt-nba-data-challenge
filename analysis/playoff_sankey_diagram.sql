SELECT
  '`' || greatest_score || '-' || least_Score AS old_score,
  next_greatest_score || '-' || next_least_score AS new_score,
  COUNT(*) AS number_of_matches
FROM (
  
    SELECT *
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
    and greatest_score = 3
)
group by 1, 2  