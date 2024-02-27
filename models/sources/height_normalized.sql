SELECT 
person_id, 
display_first_last, 
height,
((SUBSTRING(height, 0, 1)*12) + SUBSTRING(height, 3, 2))::int AS height_inches
FROM {{ source('NBA', 'COMMON_PLAYER_INFO') }}
