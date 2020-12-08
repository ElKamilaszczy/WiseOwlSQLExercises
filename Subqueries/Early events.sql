/*
Create a subquery to list out all of those events whose:
    Country id is not in the list of the last 30 country ids in alphabetical order; and
    Category id is not in the list of the last 15 category ids in alphabetical order.

*/
USE WorldEvents;
GO
SELECT * FROM tblEvent
WHERE CountryID NOT IN (SELECT CountryID FROM tblCountry ORDER BY CountryName DESC OFFSET 0 ROWS FETCH NEXT 30  ROWS ONLY)
AND CategoryID NOT IN (SELECT CategoryID FROM tblCategory ORDER BY CategoryName DESC OFFSET 0 ROWS FETCH NEXT 15  ROWS ONLY)
