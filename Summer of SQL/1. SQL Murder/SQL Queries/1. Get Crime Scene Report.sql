SELECT date,
       type,
       description,
       city
FROM crime_scene_report WHERE city = "SQL City" AND type = "murder" AND date = 20180115;
