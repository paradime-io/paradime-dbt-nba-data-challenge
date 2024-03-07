with source as (
    select * from {{ref('playoff_data_players')}}

)
select * from source