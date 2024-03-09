# Tony's Submission
Welcome! 

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
- *PLAY BY PLAY*
- *TEAM BOX SCORE*
- *COMMON_PLAYER_INFO*

## Methodology
### Tools Used
- **[Paradime](https://www.paradime.io/)** for SQL, dbt™.
- **[Python](https://www.python.org/)** for data retrieval™.
- **[Snowflake](https://www.snowflake.com/)** for data storage and computing.
- **Google Sheets** for data visualization.

### Applied Techniques
- SQL and dbt™ to transform _stg_play_by_play_ to player level performance, with an emphasis on clutch time

## Visualizations
### Clutch Shooting: Most Go-Ahead Shots 
Visualization of 2023-24 NBA players with the most made shots that put their team in the lead. 

![Clutch Shooting: Most Go-Ahead Shots](assets%2Fimage%20%2826%29.png)

*Insights:*
Sophmore phenom Paolo Banchero has arrived. In just his second seaon, he's earned All Star and rightfully so - he leads the NBA in go-ahead buckets.
A slight surprise that Jalin Williams comes in at number two here, given he hasn't solidified himself just yet as a star. However, he clearly plays a pivotal role in the Thunder's success.

### Clutch Shooting: Most Clutch Go-Ahead Shots 
Drilling in one level further, lets analyze go-ahead buckets in everyone's favorite part of the game: Clutch Time.
![Clutch Shooting: Most Clutch Go-Ahead Shots](assets%2Fimage%20%2827%29.png)

*Insights:* 
Surprisingly enough, Tyler Herro makes himself heard in the clutch, with two go-ahead buckets so far this year. Good for Tyler!
Also, the Thunder have three players that made this list. #Clutch.

### Clutch Shooting: Most Clutch Squared Go-Ahead Shots 
Let's get serious. Now we're talking clutch shots with less than 75 seconds to go. 
Are you starting to think about who I think you're thinking about?

![Clutch Shooting: Most Clutch Squared Go-Ahead Shots](assets%2Fimage%20%2828%29.png)

*Insights:* 
One more shoutout to Paolo. Not only were his two clutch go-ahead buckets important, they were important _squared_.
The lights do not appear bright for this young man. Shoutout Dejounte Murray too.

### Last but not least: GAME WINNERS
Question: When all is lost, who do you run to? 

![Last but not least: GAME WINNERS](assets%2Fimage%20%2829%29.png)

*Insights:* 
Answer: *Checks Watch* Damian Lillard, of course. Who else would top this list? He made a 32ft 3pt shot with one second on the clock. Tough.

## Conclusions
This project successfully extracts significant insights from NBA data that NBA fans would find interesting, such as: 

- With the fate of the universe on the line, martians pointing the laser beam, give me Damian Lillard!
- Paolo Banchero is piecing together a terrific start to his young career.
- Tyler Herro may not impact outcome consistently, but he makes shots when the game is tight. 
- The Oklahoma City Thunder have several players that can answer when called upon