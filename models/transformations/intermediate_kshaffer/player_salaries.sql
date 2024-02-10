WITH player_salaries AS
      (
        SELECT player_id
             , player_name
             , season
             , TO_NUMBER(REPLACE(REPLACE(salary,'$'),',')) as salary --Convert to number
             , COUNT(DISTINCT season) OVER (PARTITION BY player_id) AS years_with_known_salary
        FROM 
               {{ ref('stg_player_salaries_by_season') }}
        GROUP BY player_id
               , player_name
               , season
               , salary
    )

SELECT player_id
     , player_name
     , MAX(salary) AS max_player_salary
     , MIN(salary) AS min_player_salary
     , MAX_BY(season, salary) AS season_with_max_salary
     , MIN_BY(season, salary) AS season_with_min_salary
     , ROUND(AVG(salary)) as avg_player_salary
     , ROUND(MEDIAN(salary)) as median_player_salary
     , years_with_known_salary
FROM player_salaries
GROUP BY ALL
  
  