with shots as (
    select *
    from {{ source('NBA_EXPANDED', 'RAW_NBA__PLAYER_SHOTS') }}
)

select *
from shots