-- This is the view I created to create a table to query later
-- But you can create a CTE as well
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


-- Querying the view I created
-- Using the SUM function to add the total minutes 
-- GROUP BY the columns I wanted to use

SELECT Profile_Name, Device_type, Year, Title, Entertainment, Country, ROUND(SUM(total_minutes),2) AS total_running_minutes
FROM `[your_project_number].netflix_data.cleaned_data_with_location`
GROUP BY Profile_Name, Device_type, Year, Title, Entertainment, Country
