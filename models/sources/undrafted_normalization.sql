WITH draft_year_updated AS (
    SELECT *, 
    (CASE WHEN draft_year = 'Undrafted' THEN from_year ELSE draft_year END)::int AS draft_year_updated
    FROM {{ source('NBA', 'COMMON_PLAYER_INFO')}}
    ORDER BY draft_year DESC, draft_number ASC
) 
SELECT 
draft_year_updated, 
MAX(draft_number::int) as max_draft_number
FROM draft_year_updated
WHERE draft_number != 'Undrafted'
GROUP BY draft_year_updated
ORDER BY draft_year_updated DESC 
