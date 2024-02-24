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
    )

select *
from bmi_calc
