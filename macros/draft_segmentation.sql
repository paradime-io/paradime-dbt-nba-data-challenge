{% macro draft_segmentation(draft_number, draft_round) -%}

CASE 
    WHEN TRY_CAST({{draft_number}} AS INTEGER)<=15 AND {{draft_round}}='1' THEN 'Lottery pick'
    WHEN TRY_CAST({{draft_number}} AS INTEGER)  between 16 and 30 AND {{draft_round}}='1' THEN 'Late first round'
    WHEN TRY_CAST({{draft_number}} AS INTEGER) between 30 AND 60 OR {{draft_round}}='2' THEN 'Second round'
    ELSE 'Other-Undrafted' 
END

{%- endmacro %}