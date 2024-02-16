# dbt™ Data Modeling Challenge - NBA Edition

Welcome to the [Paradime dbt™ Data Modeling Challenge - NBA Edition](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#)!

## Table of Contents
1. [Getting Started](#getting-started)
   - [Registration and Verification](#step-1-registration-and-verification)
   - [Account Set-Up](#step-2-account-set-up)
   - [Paradime Account Configuration](#step-3-paradime-account-configuration)
   - [Kickstart Your Project](#step-4-kickstart-your-project)
2. [Competition Details](#competition-details)
3. [Building Your Project](#building-your-project)
4. [Example Submission](#example-submission)

---

## Getting Started

### Step 1: Registration and Verification
- **Submit Your Application**: Fill out the [registration form](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-registration-form).
- **Verification by Paradime**: We'll review your application against the [entry requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2).

### Step 2: Account Set-Up
After verification, you'll receive two emails from Paradime:
1. **Snowflake Account Credentials**: Contains your Snowflake account details. Search for an email with subject line "*Start Your NBA Data Modeling Challenge – Your Snowflake Credentials*."
2. **Paradime Platform Invitation**: An invitation to access the Paradime Platform. Search for an email with the subject line "*[Paradime] Activate your account*."

### Step 3: Paradime Account Configuration
- **Access Paradime**: Use the provided credentials to log into your account. Join the Paradime workspace using the invite email.
- **Snowflake Integration**: Add Snowflake credentials (Username, Password, Role, Database) to Paradime.
- **Act Fast - Limited Time Activation**: The links to activate your Paradime account expire within 24 hours!

Note: A step-by-step tutorial is available in you Snowflake credentials email, "*Start Your NBA Data Modeling Challenge – Your Snowflake Credentials*".

### Step 4: Kickstart Your Project
- **Create a New Branch**: Open the Paradime Editor and create a new branch. Your branch name should follow this format: "nba-<your_email>"
- **Start Developing**: Begin crafting SQL queries, developing dbt™ models, and generating insights!
   ![Start Developing in Paradime](link_to_arcade_screenshot)
note: If you login to snowflake, your default role is public. Swith your role to the one we provide in the email "NAME_ANALYTICS" (role name also provided in snowflake email. 

**Need Help?**: Check out [this step-by-step video tutorial](https://app.arcade.software/share/9JaKC9DmaGYBTW1sWlhf), and join the #nba-challenge channel on [Slack](https://paradimers.slack.com/join/shared_invite/zt-1mzax4sb8-jgw~hXRlDHAx~KN0az18bw#/shared-invite/email) for assistance.

---

## Competition Details
- **[Entry Requirements](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Competition Deliverables](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**
- **[Judging Criteria](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2)**

---
## Building Your Project

Now that you're set up, you have until March 8, 2024 to complete and submit your project!

### Step 1: Getting to Know the Paradime

- **The Paradime Editor**: Dive into the Paradime Editor with this step-by-step, [interactive guide](https://app.arcade.software/share/9JaKC9DmaGYBTW1sWlhf). It's designed to familiarize you with the core functionalities and of the editor, and get your familiar with the Project. 
- **Paradime Help Docs**: For a comprehensive understanding of all the features and how to make the most of Paradime for your project, explore the [Paradime Help Docs](https://docs.paradime.io/app-help/welcome-to-paradime.io/readme).

### Step 2: Getting to Know the NBA Data

Paradime has pre-loaded your Snowflake account with 7 historical NBA datasets, offering comprehensive and detailed statistics about games, players, teams, salaries, and more, typically covering the years 1947-2023. Familiarize yourself with these datasets through various resources:

- **In Snowflake**: Directly explore the datasets in [Snowflake](https://app.snowflake.com/kbuwhsf/xrb98600) for hands-on analysis.
- **GitHub Repository Resources**:
  - [Staging Files](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/tree/main/models/sources): These files provide a preliminary view and structure of the datasets available in this repository.
  - [schema.yml File](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/schema.yml): This file contains schema definitions, helping you understand the data models and their relationships.
- **Paradime Catalog UI**: Use the [Paradime Catalog UI](https://app.paradime.io/catalog/search) for an interactive exploration of the datasets, featuring intuitive search and navigation.

### Step 3: Generating Insights

Your primary goal is to construct dbt™ models that unearth compelling insights, captivating NBA fans and/or General Managers. With seven distinct datasets at your disposal, the possibilities for discovery are virtually limitless. This is your playground to innovate and explore the depths of NBA data.

Before diving in, ensure you're familiar with the [Judging Criteria](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-how-it-works-2) so you've got a chance to win the [$500-$1500 Amazon gift cards](https://www.paradime.io/dbt-data-modeling-challenge-nba-edition#div-whats-in-it-for-you)!

Need a spark of inspiration? Check out the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge?tab=readme-ov-file#example-submission), and here are some additional suggestions to kickstart your analytical journey:

- **Second-Round Draft Picks**: Who stands out among the historically best second-round picks?
      - Data Required: *[common_player_info](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_common_player_info.sql)*
- **International Player Impact**: Which international players (Not born in the USA) have made the biggest mark in the NBA?
      - Data Required: *[common_player_info](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_common_player_info.sql)*
- **Efficiency in Spending**: Analyze which teams/players have gotten the most (or least!) value for their money.
      - Data Required: *[team_spend_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_spend_by_season.sql)*, *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*
- **Performance Shifts**: Investigate players whose performance changes between the regular season and playoffs.
      - Data Required: *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- **Contracts and Contributions**: Who are the NBA's most overpaid or underpaid players?
   - Data Required: *[player_salaries_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_salaries_by_season.sql)*, *[player_game_logs](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_player_game_logs.sql)*
- **Unexpected Playoff Outcomes**: Explore the anomalies - teams that defied odds, or underperformed, in the Playoffs
  - Data Required: *[team_stats_by_season](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/models/sources/stg_team_stats_by_season.sql)*

### Creating Data Visualizations
When it comes to visualizing your insights, you have a variety of tools at your disposal, including basic options like Excel and Google Sheets. Here are some common methods you can consider:
- **Cloud BI Platforms**: Utilize platforms like Power BI, Lightdash, Metabase, Preset, Tableau, Looker, Sigma, and more. Simply use the Snowflake credentials we provided to connect these platforms to your data.
- **[Snowflake's Snowsight](https://docs.snowflake.com/en/user-guide/ui-snowsight-visualizations)**: Create visualizations directly within your provided Snowflake account, taking advantage of Snowflake's built-in visualization capabilities.
- **[Download CSV](https://docs.paradime.io/app-help/code-ide/data-preview#download-csv)**: For a straightforward approach, export the data behind your dbt™ models from Snowflake to .csv files. This method was used in the [example submission](https://github.com/paradime-io/paradime-dbt-nba-data-challenge?tab=readme-ov-file#example-submission). Please note: if you opt for exporting to .csv, our judges will verify that the exported data accurately reflects the data behind your dbt™ models!

Remember, the choice of tool is yours – select one that best fits your style and project needs!

### Submitting Your Project
**Submission Deadline:** March 8th, 2024
Once your project is complete, please submit the following materials to Parker Rogers (parker@paradime.io) with Subject Line "<your_name> - NBA Data Modeling Challenge Submission":
- **GitHub Repository**: Send the link to your GitHub repository containing your dbt™ models.
- **README.md**: Include a README file that narrates your project's story, methodology, and insights. Check out this [example README](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#example-submission).
- **Data Visualizations and Insights**: Showcase your findings, ideally within your README.md. For inspiration, refer to these [example visualizations](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/blob/main/README.md#visualizations).

We look forward to seeing your creative and insightful analyses!

# Example Submission
Here's an example project that fulfills all requirements and would be elligble eligible for cash prizes. Feel free to use this template for your submission. 

## Table of Contents
1. [Introduction](#introduction)
2. [Data Sources](#data-sources)
3. [Methodology](#methodology)
   - [Tools Used](#tools-used)
   - [Applied Techniques](#applied-techniques)
4. [Visualizations](#visualizations)
   - [Team Playoff Appearances](#team-playoff-appearances)
   - [Player Playoff Games](#player-playoff-games)
   - [Top Playoff Scorers](#top-playoff-scorers)
   - [Top Regular Season Scorers](#top-regular-season-scorers)
   - [NBA Players by University](#nba-players-by-university)
5. [Conclusions](#conclusions)

## Introduction
Explore my project for the _dbt™ data modeling challenge - NBA Edition_, Hosted by [Paradime](https://www.paradime.io/)! This project dives into the analysis and visualization of NBA statistics, designed for basketball enthusiasts and analysts.

### [My GitHub repo](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/?tab=readme-ov-file#my-github-repo)

## Data Sources
My analysis leverages three key NBA datasets from Paradime:
- *PLAYER_GAME_LOGS*
- *TEAM_STATS_BY_SEASON*
- *COMMON_PLAYER_INFO*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **Google Sheets** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform _stg_player_game_logs_ into seasonal player statistics
- SQL and dbt™ to transform _stg_player_game_logs_ and _stg_common_player_info_ to understand
  playoff and regular season performance by individual players
- SQL and dbt™ to transform _stg_common_player_info_ for insights on NBA players' college backgrounds.
- SQL and dbt™ to transform _stg_team_stats_by_season_ for insights on NBA Teams' historical playoff performance.

## Visualizations
### Team Playoff Appearances
Visualization of playoff appearances for all 30 NBA teams, including their playoff appearance rates.

![Team Playoff Appearances](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/107123308/cd69a2fa-6b60-44de-b8bc-2f6a6828f033)

*Insights:*
The Los Angeles Lakers' dominance in playoff appearances, and the San Antonio Spurs' highest playoff appearance rate.
The Spurs have only missed the playoffs 9 times!

### Player Playoff Games
Assessment of NBA players with the highest number of playoff game wins and their win percentages. The '*' next to NBA Player name indicates if they're 
a member of the [NBA Greatest 75 Team](https://www.nba.com/news/nba-75th-anniversary-team-announced)

![Player Playoff Games](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/107123308/ffd6abf3-b8a8-411f-a0be-12402a5d1b45)

*Insights:* 
LeBron James has the most playoff wins of any player, but here's what's most interesting: 
Of the 25 players with the most playoff wins, only 12 of them are members of the [NBA Greatest 75 team](https://www.nba.com/news/nba-75th-anniversary-team-announced). 
There are several players listed that impact playoff wins and compliment their team's best players, but aren't known 
as on the the all time greats, such as: Derek Fisher, Robert Horry, Danny Green. 

### Top Playoff Scorers
Showcases players who achieved the the most points scored in any playoff season.

![Top Playoff Scorers](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/107123308/db51f47a-5cfb-431c-9c7b-3a793a6b4352)

*Insights:* 
Michael Jordan, LeBron James, and Kobe Bryant are the only players having three seasons within the top 25 
highest most points scored in a playoff season.

### Top Regular Season Scorers
Highlights NBA players who scored the most in regular seasons.

![Top Regular Season Scorers](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/107123308/774223ad-11f0-4202-817f-5a8c1daf3afc)

*Insights:* 
Wilt Champerlain is one of the best regular season scorer of all time. In addition to having the most points scored 
in any regular season ever (4,029), he also has six season in the top 25. The only other player with 6 top 25 seasons is Michael Jordan.
In the chart above, notice that Wilt Champerlain doesn't appear once in the top 25 playoff scorers of all time 👀.

### NBA Players by University
Displays which universities have produced the most NBA players.

![NBA Players by University](https://github.com/paradime-io/paradime-dbt-nba-data-challenge/assets/107123308/e21af17a-9cb8-491a-8e0d-b70eae118324)

*Insights:* 
Kentucky has produced the most NBA players in NBA history by a significant margin.... Go Wildcats! Also, this data is [slightly inaccurate](https://erudera.com/resources/colleges-with-most-nba-players/), but that's the NBA API's fault, not mine 🤣

## Conclusions
This project successfully extracts significant insights from NBA data that NBA fans would find interesting, such as: 

- The dominance of teams like the Los Angeles Lakers and the San Antonio Spurs in playoff appearances
- The critical role of "role" players, as highlighted by the playoff games by player insights,
- The extraordinary achievements of players like LeBron James, Michael Jordan in the playoffs, and Wilt Chamberlain in the regular season. 
- The influence of universities like Kentucky in producing NBA talent.
