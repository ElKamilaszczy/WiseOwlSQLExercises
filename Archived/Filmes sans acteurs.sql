/*
https://www.wiseowl.co.uk/sql/exercises/standard/archived/2363/
*/
use Movies;
go
select * from tblFilm;
select * from tblCast;
/* No actor exists for a film */
SELECT f.FilmName from tblFilm f
WHERE NOT EXISTS 
(
	SELECT NULL FROM tblCast c
	WHERE c.CastFilmID = f.FilmID
)
ORDER BY 1 ASC;

