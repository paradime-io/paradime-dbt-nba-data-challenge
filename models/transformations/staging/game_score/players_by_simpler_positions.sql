select 
    player_id,
    full_name as player_name,
    case
        when startswith(position, 'Guard') then 'Guard'
        when startswith(position, 'Forward') then 'Forward'
        when startswith(position, 'Center') then 'Center'
    end as simple_position
from {{ ref('stg_common_player_info') }}
where simple_position is not NULL