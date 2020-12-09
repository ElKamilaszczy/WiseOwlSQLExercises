/*
Top 3 events in my date od birth (the top 3 closest ones) and then concatenate them into single variable
*/
Use WorldEvents;
GO
DECLARE @MyBirth date = '19961119', @EventList varchar(100) ='';
SELECT TOP (3) WITH TIES @EventList = @EventList + ', '+ EventName FROM tblEvent
ORDER BY ABS(DATEDIFF(day, @MyBirth, EventDate));
SELECT SUBSTRING(@EventList, 3, 2000);
