import requests
from bs4 import BeautifulSoup
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import pandas as pd


# Function to scrape NBA Draft data
def scrape_nba_draft_data():
    all_rows = []
    # Assuming there's a way to iterate through pages; this might need adjustment
    for page in range(1, 167):  # Example: iterate through 4 pages
        url = f'https://www.nba.com/stats/draft/history?Page={page}'
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Find the table rows; this selector might need adjustment
        rows = soup.select('selector_for_the_table_rows')
        for row in rows:
            cols = row.find_all('td')
            if cols:
                all_rows.append([col.text.strip() for col in cols])
                
    return pd.DataFrame(all_rows, columns=["player", "team", "affiliation", "year", "round_number", "round_pick", "overall_pick"])

# Function to connect to Snowflake
def connect_to_snowflake():
    # Snowflake connection parameters
    ctx = snowflake.connector.connect(
        user=user,
        password=password,
        account=account,
        warehouse=warehouse,
        database=database
    )
    return ctx

# Function to create/replace the table and insert data
def create_and_insert_data(df):
    ctx = connect_to_snowflake()
    cs = ctx.cursor()
    cs.execute("USE SCHEMA CAHUGHES95CVFDE_ANALYTICS.STAGING")
    # Replace table
    cs.execute(f"DROP TABLE IF EXISTS DRAFT_DATA")
    cs.execute(f"""
        CREATE TABLE DRAFT_DATA (
            player VARCHAR,
            team VARCHAR,
            affiliation VARCHAR,
            year INT,
            round_number INT,
            round_pick INT,
            overall_pick INT
        )
    """)
    
    # Insert data
    write_pandas(ctx, df, DRAFT_DATA)
    
    cs.close()
    ctx.close()

# Main function to orchestrate the process
def main():
    df = scrape_nba_draft_data()
    create_and_insert_data(df)

if __name__ == "__main__":
    main()
