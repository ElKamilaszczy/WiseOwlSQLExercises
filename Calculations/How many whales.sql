/*
It's traditional to express a country's size in terms of how many times you could fit Wales into it.
Result: Country, KmSquared of country, WaslesUnits, AreaLeftOver, WalesComparison (as text)
*/

USE WorldEvents;
GO
;WITH wales AS
( SELECT 'Wales' as Country, 20761 as KmSquared)
SELECT c.Country, c.KmSquared, c.KmSquared / w.KmSquared AS WalesUnits, c.KmSquared % w.KmSquared as AreaLeftOver,
CONCAT(c.KmSquared / w.KmSquared, ' x Wales plus ', c.KmSquared % w.KmSquared, ' sq. km.') as WalesComparison FROM
dbo.CountriesByArea c CROSS JOIN wales w
order by ABS(c.KmSquared - w.KmSquared) asc;

