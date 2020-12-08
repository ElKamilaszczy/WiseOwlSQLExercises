/*
Write a query to list out for each episode year and enemy the number of episodes made, but in addition:

    Only show episodes made by doctors born before 1970; and
    Omit rows where an enemy appeared in only one episode in a particular year.
*/
USE DoctorWho;
GO
SELECT YEAR(te.EpisodeDate), tn.EnemyName, COUNT(*) FROM tblEpisode te 
INNER JOIN tblEpisodeEnemy tee ON te.EpisodeId = tee.EpisodeId 
INNER JOIN tblEnemy tn ON tee.EnemyId = tn.EnemyId
INNER JOIN tblDoctor td ON te.DoctorId = td.DoctorId
WHERE td.BirthDate < '19700101'
GROUP BY YEAR(te.EpisodeDate), tn.EnemyName, tn.EnemyId
HAVING COUNT(*) > 1;