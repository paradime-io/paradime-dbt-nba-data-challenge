with
    source as (select * from {{ source('NBA', 'TEAMS') }}),

    renamed as (
        select
            id as team_id,
            full_name,
            abbreviation as team_name_abbreviation,
            nickname,
            city,
            state,
            year_founded
        from source
    )

select *
from renamed
