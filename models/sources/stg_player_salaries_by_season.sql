with
    source as (select * from {{ source('NBA', 'PLAYER_SALARIES_BY_SEASON') }}),

    renamed as (
        select
            player_id,
            player_name,
            rank,
            season,
            cast(replace(replace(salary, '$', ''), ',', '') as int) as salary_usd
        from source
    )

select *
from renamed
