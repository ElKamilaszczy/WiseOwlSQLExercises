/*
Create a query which shows two statistics for each category initial:

    The number of events for categories beginning with this letter; and
    The average length in characters of the event name for categories beginning with this letter.
*/
USE WorldEvents;
GO
SELECT LEFT(tc.CategoryName, 1), COUNT(*) as [Num of events], AVG(CAST(LEN(te.EventName) as decimal(4,2)))
FROM tblevent te INNER JOIN dbo.tblCategory tc ON te.CategoryID = tc.CategoryID
GROUP BY LEFT(tc.CategoryName, 1)