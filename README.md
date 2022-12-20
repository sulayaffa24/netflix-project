# netflix-project
>Downloaded my personal Netflix data to analyze movies and tv shows screen time

I got the idea from a DataQuest email I received a while ago, where you can download your personal Netflix streaming history data. So I wanted to analyze how many minutes were spent watching Movies and TV Shows per Profile by downloading the data and uploading it on BigQuery and visualizing it on PowerBI

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

### Exploratory data analysis

I wanted to seperate the TV Shows from the Movies using SQL. Most movies are over an hour and most TV Shows are about 45 minutes long, but that is not the case every time and there are times were you don't complete a movie or a TV Show. I had to do exploratory data analysis using SQL to find all the TV Shows and Movies and to categorize them in a column called Entertainment_Type. There were no TIME_FUNCTION in BigQuery to add the time duration of each tv show or movie streamed, so I extracted the hour, minute, seconds and created a column for the each. Converted the hours and seconds to minutes and created a new column called total_running_minutes.

### Visualizations

