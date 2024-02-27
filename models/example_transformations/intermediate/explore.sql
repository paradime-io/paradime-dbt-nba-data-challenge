--  SELECT *
--  FROM {{ ref('stg_games')}}
--  WHERE game_id=20000002

SELECT *
FROM {{ ref('dim_teams')}}
WHERE team_abb IN ('NJN','CLE')