/*
Queries:
Events which aren't in the Transport category (number 14), but which nevertheless include the text Train in the EventDetails column. 	4 rows
Events which are in the Space country (number 13), but which don't mention Space in either the event name or the event details columns. 	6 rows
Events which are in categories 5 or 6 (War/conflict and Death/disaster), but which don't mention either War or Death in the EventDetails column. 	91 rows
*/
--Query 1--
SET NOCOUNT ON;
GO
Select * FROM dbo.tblEvent te
WHERE NOT EXISTS
(
	SELECT NULL FROM dbo.tblCategory tc
	WHERE te.CategoryID = tc.CategoryID
	AND tc.CategoryName = 'Transport'
)
AND te.EventDetails LIKE '%Train%' COLLATE Latin1_General_CI_AI;
GO
-- Query 2--
Select * FROM dbo.tblEvent te
WHERE te.CountryID = (Select CountryID from tblCountry WHERE CountryName = 'Space'
)
AND (te.EventName NOT LIKE '%Space%' COLLATE Latin1_General_CI_AI AND te.EventDetails NOT LIKE '%Space%' COLLATE Latin1_General_CI_AI);
-- Query 3--
GO
Select * FROM dbo.tblEvent te
WHERE te.CategoryID IN (Select CategoryID from tblCategory WHERE CategoryName = 'War and conflict' OR CategoryName = 'Death and disaster'
)
AND (te.EventDetails NOT LIKE '%War%' COLLATE Latin1_General_CI_AI AND te.EventDetails NOT LIKE '%Death%' COLLATE Latin1_General_CI_AI);

select * from tblCategory