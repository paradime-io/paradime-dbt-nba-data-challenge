with source as (
    select 
    player_id
    , season
    , max(predicted_salary) as predicted_salary 
    from {{ref('stg_player_predicted_salaries')}}
    group by 1,2
)

select * from source