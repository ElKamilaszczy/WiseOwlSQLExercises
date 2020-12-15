/*
Show last and first 5 events in 1 query
*/
USE HistoricalEvents;
GO
WITH unioned
AS
(
	SELECT te.EventName, te.EventDate, ROW_NUMBER() OVER(ORDER BY te.EventDate ASC) as rn_asc,
	ROW_NUMBER() OVER(ORDER BY te.EventDate DESC) as rn_desc
	FROM tblEvent te
)
SELECT u.EventName, u.EventDate FROM unioned u
WHERE rn_asc <= 5 OR rn_desc <= 5
ORDER BY u.EventName asc;