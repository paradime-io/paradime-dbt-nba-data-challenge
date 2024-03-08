with source as (
    select * from {{ref('team_info')}}

)

select * from source