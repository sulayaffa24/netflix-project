# Netflix SQL and Tableau Project 
>Downloaded my personal Netflix data to analyze movies and tv shows screen time

I got the idea from a DataQuest email I received a while ago, where you can download your personal Netflix streaming history data. So I wanted to analyze how many hours were spent watching Movies and TV Shows per Profile by downloading the data and uploading it on BigQuery and visualizing it on PowerBI

### Getting the data

1. Log in to Netflix with your account
2. Click on Account in the dropdown menu at the top right and navigate to Settings
3. Select Download your personal information and click on Submit Request at the bottom of the page
4. It could take up to a week to receive it in your email.

### Uploading the data in BigQuery

Once you receive the file unzip the folder and you will find multiple folders under it. You can inspect the contents under the folders but the one you should be looking for is the CONTENT_INTERACTION folder where you will find the ViewingActivity.csv file. I uploaded the ViewingActivity.csv file in BigQuery and started analyzing the data. Here are the columns that were available at download:

- Profile_Name
- Start_Time
- Duration
- Attributes
- Title
- Supplemental_Video_Type
- Device_Type
- Bookmark
- Latest_Bookmark
- Country

### Data Analysis

I wanted to separate the TV Shows from the Movies using SQL. Most movies are over an hour and most TV Shows are about 45 minutes long, but that is not the case every time and there are times when you don't complete a movie or a TV Show. I had to do exploratory data analysis using SQL to find all the TV Shows and Movies and categorize them in a column called Entertainment_Type. There was no TIME_FUNCTION in BigQuery to add the time duration of each TV show or movie streamed, therefore I extracted the hour, minute, and seconds and created a column for each of them. Converted the hours and seconds to minutes and created a new column called total_running_minutes. In PowerBI I transformed the total_running_minutes to total_hours in a separate column.

```sql
SELECT Profile_Name,
       Country,
       Start_Time,
       Device_type,
       EXTRACT(YEAR FROM Start_Time) AS Year,
       EXTRACT(MONTH FROM Start_Time) AS Month,
       Title, 
       Duration,
       EXTRACT(HOUR FROM Duration) AS Hour,
       EXTRACT(MINUTE FROM Duration) AS Minute,
       EXTRACT(SECOND FROM Duration) AS Second,
       CASE
              WHEN CONTAINS_SUBSTR(Title, 'Episode') THEN 'TV Show' -- All TV Show had Episode in the Title Column
              WHEN CONTAINS_SUBSTR(Title, 'Trailer') THEN 'Trailer' -- Digging into the data you find Trailers in the Title Column
              WHEN CONTAINS_SUBSTR(Title, 'Teaser') THEN 'Teaser' -- Digging into the data you find Teasers in the Title Column
              WHEN CONTAINS_SUBSTR(Title, 'Bonus') THEN 'Bonus' -- Digging into the data you find Bonus in the Title Column
              WHEN CONTAINS_SUBSTR(Title, 'Recap') THEN 'Recap' -- Digging into the data you find Recap in the Title Column
              WHEN CONTAINS_SUBSTR(Title, 'hook') OR CONTAINS_SUBSTR(Title, '_') OR CONTAINS_SUBSTR(Title, 'Clip') THEN 'Hook/Clip' -- Found some Hooks and clips as well
              ELSE 'Movie' 
              END AS Entertainment,
      ROUND((EXTRACT(HOUR FROM Duration) * 60) + (EXTRACT(MINUTE FROM Duration)) + (EXTRACT(SECOND FROM Duration) / 60), 2) AS total_minutes -- Calculate the total minutes
FROM `[your_project_number].netflix_data.netflix_activity`

```

### Visualizations

**Here are the visualizations I created:**

> All dashboard are interactive you can choose multiple Profile Names

**Time Spent Watching Movies**

![image](https://github.com/sulayaffa24/netflix-project/assets/30465635/4a37cccf-5b28-4d10-9f24-322546280415)

[Movie Dashboard](https://public.tableau.com/app/profile/sulayman.yaffa/viz/PersonalMovieNetflixData/Dashboard1)


**Time Spent Watching TV Shows**

![image](https://github.com/sulayaffa24/netflix-project/assets/30465635/8bfe8725-08be-4c84-a5d4-72263cb08e62)

[TV Show Dashboard](https://public.tableau.com/app/profile/sulayman.yaffa/viz/PersonalTVShowNetflixData/Dashboard2)
