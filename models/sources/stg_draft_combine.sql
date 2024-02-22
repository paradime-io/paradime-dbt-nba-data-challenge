with split_heights as (
    select 
        player,
        pos,
        body_fat,
        hand_length_inches,
        hand_width_inches,
        height_wo_shoes,
        split(height_wo_shoes, '\'') as split_height_wo_shoes,
        height_w_shoes,
        split(height_w_shoes, '\'') as split_height_w_shoes,
        standing_reach,
        split(standing_reach, '\'') as split_standing_reach,
        weight_lbs,
        wingspan,
        split(wingspan, '\'') as split_wingspan,
        year
    from {{ ref('NBA_DRAFT_COMBINE_2000_2023_CLEANED')}}
),
inches as (
    select 
        player,
        pos,
        body_fat,
        hand_length_inches,
        hand_width_inches,
        split_height_wo_shoes[0] * 12 + split_height_wo_shoes[1] as height_wo_shoes_inches,
        split_height_w_shoes[0] * 12 + split_height_w_shoes[1] as height_w_shoes_inches,
        split_standing_reach[0] * 12 + split_standing_reach[1] as standing_reach_inches,
        weight_lbs,
        split_wingspan[0] * 12 + split_wingspan[1] as wingspan_inches
    from split_heights
)
select 
    *,
    round(height_wo_shoes_inches / wingspan_inches, 3) as height_wingspan_ratio
from inches