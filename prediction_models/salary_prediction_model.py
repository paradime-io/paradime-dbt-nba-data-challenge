import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.preprocessing import StandardScaler
from settings import user, password, account, warehouse, database, schema

# Snowflake connection parameters
ctx = snowflake.connector.connect(
    user=user,
    password=password,
    account=account,
    warehouse=warehouse,
    database=database
)

# Example of setting the schema dynamically
ctx.cursor().execute("USE SCHEMA CAHUGHES95CVFDE_ANALYTICS.WAREHOUSE")

# Query to load data
query = """
SELECT 
    pp.player_id as PLAYER_ID,
    pp.season as SEASON,
    pp.avg_points as PPG,
    (pp.total_rebounds/nullif(pp.games_played_counter,0)) AS RPG,
    (pp.assists/nullif(pp.games_played_counter, 0)) AS APG,
    (pp.steals/nullif(pp.games_played_counter,0)) AS SPG,
    (pp.blocks/nullif(pp.games_played_counter,0)) AS BPG,
    pp.TS_PERCENTAGE,
    pp.USG_PERCENTAGE,
    (pp.plus_minus/nullif(pp.games_played_counter,0)) AS AVG_PLUSMINUS,
    pp.games_played_counter AS GAMES_PLAYED,
    ps.salary_adjusted_for_inflation_and_cap AS ADJUSTED_SALARY,
    sc.cap_maximum AS CAP_MAXIMUM,
    sc.salary_maximum AS SALARY_MAXIMUM,
    sc.salary_minimum AS SALARY_MINIMUM
FROM FACT_PLAYER_PERFORMANCE pp 
JOIN DIM_PLAYER_SALARIES_BY_SEASON_ADJUSTED ps ON ps.Player_id = pp.player_id AND ps.season = pp.season 
JOIN CAHUGHES95CVFDE_ANALYTICS.STAGING.SALARY_CAP_BY_SEASON sc ON pp.season = sc.season
WHERE pp.season like '20%' 
and pp.game_type = 'Regular Season'
and pp.games_played_counter >=30
"""

df = pd.read_sql(query, ctx).dropna()

# Convert 'SEASON' to a numeric year for modeling
df['SEASON_YEAR'] = df['SEASON'].apply(lambda x: int(x.split('-')[0]))

# Define features and target variable for the model
features = ['SEASON_YEAR', 'PPG', 'RPG', 'APG', 'SPG', 'BPG', 'TS_PERCENTAGE', 'USG_PERCENTAGE', 'AVG_PLUSMINUS', 'GAMES_PLAYED']
X = df[features]
y = df['ADJUSTED_SALARY']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Initialize and fit the scaler on the training data
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Train the Linear Regression model
model = LinearRegression().fit(X_train_scaled, y_train)

# Make predictions on the testing set
X_scaled = scaler.transform(X)
predictions = model.predict(X_scaled)

# Predictions on scaled test set for evaluation
test_predictions = model.predict(X_test_scaled)

# Evaluate the model
print(f"Mean Squared Error (MSE): {mean_squared_error(y_test, test_predictions)}")
print(f"R-squared (R2): {r2_score(y_test, test_predictions)}")

# Later, if you need to switch to the STAGING schema
ctx.cursor().execute("USE SCHEMA CAHUGHES95CVFDE_ANALYTICS.STAGING")

# Prepare DataFrame for upload with original 'PLAYER_ID' and 'SEASON', and new 'PREDICTED_SALARY'
df['PREDICTED_SALARY'] = [
    max(min(pred, row['SALARY_MAXIMUM']), row['SALARY_MINIMUM'])
    for pred, (_, row) in zip(predictions, df.iterrows())
]
output_df = df[['PLAYER_ID', 'SEASON', 'PREDICTED_SALARY']].copy()

try:
    ctx.cursor().execute(f"DROP TABLE IF EXISTS PREDICTED_SALARIES")
    print("Table dropped successfully; proceeding with fresh table creation.")
except Exception as e:
    print(f"Failed to drop table: {e}")

create_table_sql = """
CREATE OR REPLACE TABLE PREDICTED_SALARIES (
    PLAYER_ID NUMBER(38,0),
    SEASON VARCHAR(16777216),
    PREDICTED_SALARY NUMBER(38,0)
);
"""
ctx.cursor().execute(create_table_sql)

# Upload predictions to Snowflake
success, nchunks, nrows, _ = write_pandas(ctx, output_df, 'PREDICTED_SALARIES', parallel=4)

print(f"Uploaded {nrows} rows in {nchunks} chunks to 'PREDICTED_SALARIES' table.")

# Close the Snowflake connection
ctx.close()