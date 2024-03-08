with player_info as (
    select *
    from {{ref('stg_common_player_info')}}
)

select *
, 12 * (split_part(height, '-', 1)::int) + split_part(height, '-', 2)::int as height_inches
, case when as modern_roles
from player_info