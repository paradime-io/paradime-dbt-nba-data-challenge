with source as (
    select * from {{ref('team_stats_by_season')}}

)

select 
*
from source