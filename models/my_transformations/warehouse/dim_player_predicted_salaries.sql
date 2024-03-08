with source as (
    select * from {{ref('player_predicted_salaries')}}

)

select * from source