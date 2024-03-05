with
    player_info as (
        select
            player_id,
            full_name as player_name,
            height,
            weight,
            position,
            seasons_played,
            roster_status

        from {{ ref('stg_common_player_info') }}
    ),

    height_inches_calc as (
        select
            *,
            split_part(height, '-', 1)::int * 12
            + split_part(height, '-', 2)::int as height_inches
        from player_info
    ),
    bmi_calc as (
        select *, 703 * (weight / (height_inches * height_inches)) as bmi
        from height_inches_calc
    ),
    bmi_category as (
        select
            *,
            case
                when bmi < 18.5
                then 'underweight'
                when bmi < 25
                then 'healthy weight'
                when bmi < 30
                then 'overweight'
                when bmi >= 30
                then 'obesity'
                else 'unknown'
            end as bmi_category
        from bmi_calc
    )
select *
from bmi_category
