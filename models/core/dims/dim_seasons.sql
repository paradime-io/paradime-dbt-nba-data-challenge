WITH season AS(
SELECT 
    season_id,
    season as season_name
FROM {{ ref('stg_games')}}
GROUP BY 1,2
)

SELECT season_id,
    TRY_CAST(SPLIT_PART(season_name,'-',1) AS INTEGER) AS season_start_year,
    TRY_CAST(SPLIT_PART(season_name,'-',1) AS INTEGER)+1 AS season_end_year
FROM season
WHERE season_id IS NOT NULL
ORDER BY season_start_year