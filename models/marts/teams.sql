with teams as (
    select *
    from {{ref('stg_teams')}}
)

select *
from teams