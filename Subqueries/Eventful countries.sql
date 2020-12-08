/*
Write a query which lists out countries which have more than 8 events, using a correlated subquery rather than HAVING. 

That is: list the names of countries from the countries table where for each country the number of events matching the country's id is more than 8.

*/
USE WorldEvents;
GO
;WITH ids_8 AS
(
	SELECT CountryID FROM tblEvent
	GROUP BY CountryID
	HAVING COUNT(*) > 8
)
SELECT CountryName FROM ids_8 i INNER JOIN tblCountry tc
ON tc.CountryID = i.CountryID;
