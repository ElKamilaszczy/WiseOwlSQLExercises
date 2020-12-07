/*
Query to show dates in format: day of the week, number+(st/nd/rd/th), month name, year
*/
USE WorldEvents;
GO
SET LANGUAGE us_english;
GO
Select EventName, EventDate, 
wd + ' '+ CASE WHEN d =1 THEN d+'st'
WHEN d =2 THEN d+'nd'
WHEN d =3 THEN d+'rd'
ELSE d+'th'
END +' '+ m +' '+y AS FullDate FROM tblEvent
CROSS APPLY (VALUES(DATENAME(weekday, EventDate), DATENAME(day, EventDate), DATENAME(month, EventDate), DATENAME(year, EventDate)))
AS C(wd, d, m, y);
