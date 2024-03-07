with salary_cap_by_year as (
    select *
    from {{ source('NBA_EXPANDED', 'RAW_NBA__SALARY_CAP') }}
)

select *
, left(season, 4)::int as season_start_year
from salary_cap_by_year