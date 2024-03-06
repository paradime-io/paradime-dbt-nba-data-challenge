with source as (
    select * from {{ref('player_info')}}

)

select * from source