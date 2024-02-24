WITH final AS (
SELECT *
FROM {{ ref('stg_teams') }}
)

SELECT *
FROM final