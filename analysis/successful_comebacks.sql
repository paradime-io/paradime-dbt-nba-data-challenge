with one_three_win as 

(SELECT
  playoff_match_up_unique_str||season
FROM warehouse.fct_playoff_per_game_win_loss
where winning_Score = 1
and losing_Score = 3
and season IN (
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
)

SELECT
  *
FROM warehouse.fct_playoff_per_game_win_loss
where winning_Score = 2
and losing_Score = 3
and season IN (
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
and playoff_match_up_unique_str||season not in (select * from one_three_win)