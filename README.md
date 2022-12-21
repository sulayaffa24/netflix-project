# netflix-project
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

### Exploratory data analysis

I wanted to seperate the TV Shows from the Movies using SQL. Most movies are over an hour and most TV Shows are about 45 minutes long, but that is not the case every time and there are times where you don't complete a movie or a TV Show. I had to do exploratory data analysis using SQL to find all the TV Shows and Movies and categorize them in a column called Entertainment_Type. There were no TIME_FUNCTION in BigQuery to add the time duration of each tv show or movie streamed, therefore I extracted the hour, minute, seconds and created a column for each them. Converted the hours and seconds to minutes and created a new column called total_running_minutes. In PowerBI I transformed the total_running_minutes to total_hours in a seperate column.

### Visualizations

**Here are the visualizations I created:**

*We can see that Don't Blame the Kid is the most watched Movie in Profile_Name: Sulayman in the Country: US in terms of hours*

![image](https://user-images.githubusercontent.com/30465635/208797005-1c5ec96e-becf-41f1-8d03-d6dd2b966abc.png)


*We can see that Ozark Season 3: Su Casa Es Mi Casa (Episode 6) is the most watched TV Show episode in Profile_Name: MASTA YODA in the Country: US in terms of hours*

![image](https://user-images.githubusercontent.com/30465635/208797188-e304fad9-e355-44fa-a780-d5f02ea10fb5.png)

