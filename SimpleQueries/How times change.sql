/*
Create a query which uses two separate SELECT statements to show the first and last 2 events in date order from the tblEvent table.
We assume there aren't 2 events at the same time (date)
*/
USE WorldEvents;
GO
SET NOCOUNT ON;
GO
SELECT EventName as [What], EventDate as [when] FROM dbo.tblEvent 
ORDER BY [when] ASC
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;
GO
SELECT TOP (2) EventName as [What], EventDate as [when] FROM dbo.tblEvent 
ORDER BY [when] DESC