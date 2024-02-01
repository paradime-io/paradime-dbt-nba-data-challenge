 WITH source AS (
  SELECT
    *
  FROM
    {{ source('NBA', 'GAMES') }}
)
select * from source