WITH logs AS (SELECT * FROM {{ref('stg_player_game_logs')}}),
info AS (SELECT * FROM {{ref('stg_common_player_info')}}),
salaries AS (SELECT * FROM {{ref('stg_player_salaries_by_season')}}),

seasons AS (
    SELECT
    player_id,
    season,
    game_date AS season_first_game_date
    FROM
        logs
    QUALIFY
        ROW_NUMBER()OVER(PARTITION BY player_id,season ORDER BY game_date)=1),

salary_dedup AS (
    SELECT
        player_id,
        season,
        SUM(salary) AS salary
    FROM
        salary
    GROUP BY 1,2),

joined AS (
    SELECT
        player_id,
        season,
        YEAR(season_first_game_date)-YEAR(birthdate) AS age,
        ROW_NUMBER()OVER(PARTITION BY player_id ORDER BY season_first_game_date) AS nba_tenure,
        CASE WHEN ROW_NUMBER()OVER(PARTITION BY player_id ORDER BY season_first_game_date)=1 THEN TRUE ELSE FALSE END AS is_rookie_year,
        CASE WHEN ROW_NUMBER()OVER(PARTITION BY player_id ORDER BY season_first_game_date DESC)=1 THEN TRUE ELSE FALSE END AS is_last_year,
        salary
    FROM
        seasons
    LEFT JOIN
        info
    USING(player_id)
    LEFT JOIN
        salary_dedup
    USING(player_id,season))

SELECT * FROM joined
