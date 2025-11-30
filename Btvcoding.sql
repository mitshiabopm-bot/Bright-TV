SELECT
  *
FROM
  "BRIGHTTV"."VIEWER"."DATASET"
LIMIT
  10;

  select distinct (userid) as users
  FROM BRIGHTTV.VIEWER.DATASET;

 select count (distinct (userid)) as user_count
  FROM BRIGHTTV.VIEWER.DATASET; 

    select distinct (userid) as users
    FROM BRIGHTTV.VIEWER.profiles;

   
   
   select count (distinct (userid)) as user_count
   FROM BRIGHTTV.VIEWER.profiles;

   select distinct(channel2)
   from brighttv.viewer.dataset;
  

   select count(distinct(channel2)) as number_of_channel2
    from brighttv.viewer.dataset;

    SELECT max date as latest date 
FROM
  "BRIGHTTV"."VIEWER"."DATASET"

  select max (recorddate2) as latest_date
  from brighttv.viewer.DATASET;

 select min (recorddate2) as first_time
  from brighttv.viewer.DATASET;  

 select max(duration2)
  from brighttv.viewer.dataset;
  
 select min(duration2)
  from brighttv.viewer.dataset;
    
  select*
  from brighttv.viewer.dataset as v
  inner join brighttv.viewer.profile as p
  on v.userid = p.userid;

select*
  from brighttv.viewer.dataset as v
   full join brighttv.viewer.profile as p
  on v.userid = p.userid;

select*
  from brighttv.viewer.dataset as v
  left join brighttv.viewer.profile as p
  on v.userid = p.userid;

select*
  from brighttv.viewer.dataset as v
  right join brighttv.viewer.profile as p
  on v.userid = p.userid;

    select distinct(gender) as gendernumber
  from brighttv.viewer.profile;

  select count(gender) as male_gender
  from brighttv.viewer.profile
  where gender = 'male';

   select count(gender) as female_gender
  from brighttv.viewer.profile
  where gender = 'female';

 select count(gender) as none_gender
  from brighttv.viewer.profile
  where gender = 'None';

select distinct(race) as different_race
  from brighttv.viewer.profile;

  select count(race) as indian_asian_viewer
  from brighttv.viewer.profile
  where race = 'indian_asian';

  select count(race) as coloured
  from brighttv.viewer.profile
  where race = 'coloured';

select count(race) as other
  from brighttv.viewer.profile
  where race = 'other';


select count(race) as white
  from brighttv.viewer.profile
  where race = 'white';

select count(race) as black
  from brighttv.viewer.profile
  where race = 'black';

select count(race) as None
  from brighttv.viewer.profile
  where race = 'None';

select max(AGE) as oldest_viewer
from brighttv.viewer.profile;

select min(AGE) as youngest_viewer
from brighttv.viewer.profile;

select*
from brighttv.viewer.dataset as v
full join brighttv.viewer.profile as p
on v.userid = p.userid;



-----------Case study----

SELECT 
    YEAR(TO_TIMESTAMP(v.recorddate2, 'MM/DD/YYYY HH24:MI')) AS year,
    MONTHNAME(TO_TIMESTAMP(v.recorddate2, 'MM/DD/YYYY HH24:MI')) AS month,
    CASE 
        WHEN MONTHNAME(TO_TIMESTAMP(v.recorddate2, 'MM/DD/YYYY HH24:MI')) IN ('Nov', 'Dec') 
            THEN 'Festive_season' 
        ELSE 'Normal_month' 
    END AS month_category,
    WEEK(TO_TIMESTAMP(v.recorddate2, 'MM/DD/YYYY HH24:MI')) AS week,
    CASE 
        WHEN DAYNAME(TO_TIMESTAMP(v.recorddate2, 'MM/DD/YYYY HH24:MI')) IN ('Sat', 'Sun') 
            THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_category,
    CASE 
        WHEN p.age BETWEEN 0 AND 6 THEN 'Childhood'
        WHEN p.age BETWEEN 7 AND 12 THEN 'Middle Childhood'
        WHEN p.age BETWEEN 13 AND 18 THEN 'Adolescence'
        WHEN p.age BETWEEN 19 AND 40 THEN 'Young Adulthood'
        WHEN p.age BETWEEN 41 AND 65 THEN 'Middle Adulthood'
        WHEN p.age BETWEEN 66 AND 75 THEN 'Young Old'
        WHEN p.age BETWEEN 76 AND 85 THEN 'Elderly'
        WHEN p.age >= 86 THEN 'Eldest'
        ELSE 'Unknown'
    END AS age_bucket,
    p.gender,
    p.race,
    p.province,

    COUNT(*) AS total_records,

    -- ✅ Aggregated totals
    SUM(DATEDIFF(minute, TIME '00:00:00', v.duration2)) AS total_viewtime_minutes,
    ROUND(SUM(DATEDIFF(minute, TIME '00:00:00', v.duration2)) / 60, 2) AS total_viewtime_hours,

    -- ✅ Averages per record/user
    ROUND(AVG(DATEDIFF(minute, TIME '00:00:00', v.duration2)), 2) AS avg_viewtime_minutes,
    ROUND(AVG(DATEDIFF(minute, TIME '00:00:00', v.duration2)) / 60, 2) AS avg_viewtime_hours

FROM brighttv.viewer.dataset AS v
FULL JOIN brighttv.viewer.profile AS p 
    ON v.userid = p.userid
GROUP BY 
    year, month, month_category, week, day_category, age_bucket, 
    p.gender, p.race, p.province
ORDER BY 
    year, month, week, day_category, age_bucket, 
    p.gender, p.race, p.province;

  
