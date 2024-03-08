with injuries as (
    select *
    from {{ source('NBA_EXPANDED', 'RAW_NBA__PLAYER_INJURIES') }}
)

select *
from injuries
