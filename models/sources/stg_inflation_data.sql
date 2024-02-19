WITH source AS (
    SELECT 
        *
    FROM 
        {{ source('CAHUGHES95', 'INFLATION_DATA') }}
)

-- season_format.sql
, season_format AS (
    SELECT
        year,
        (year - 1) AS season_start,
        year AS season_end
    FROM source
)

, final as (
    SELECT
      s.*,
      CAST(d.season_start AS VARCHAR) || '-' || SUBSTRING(CAST(d.season_end AS VARCHAR), 3, 2) AS season_format
    FROM season_format d
    join source s on s.year = d.year

)

SELECT 
    *
FROM
    final