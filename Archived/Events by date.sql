/*
https://www.wiseowl.co.uk/sql/exercises/standard/archived/1106/
*/
USE HistoricalEvents;
GO
select DATEPART(year, EventDate) as EventYear, DATEPART(month, EventDate) as EventMonth, COUNT(*) from tblEvent
GROUP BY  DATEPART(year, EventDate), DATEPART(month, EventDate)
ORDER BY EventYear desc, EventMonth desc