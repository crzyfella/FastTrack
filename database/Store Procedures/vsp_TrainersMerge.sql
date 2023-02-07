IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_TrainersMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_TrainersMerge]
GO

CREATE PROCEDURE [kelso].[vsp_TrainersMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Trainers T
	USING (
			SELECT DISTINCT TrainerName,
						    TrainerStarts,
							TrainerWins,
							TrainerPlaces,
							TrainerShows,
							TrainerPercentage,
							TrainerStatsYTD
			FROM kelso.ent_staging 
		  ) S
	ON S.TrainerName = T.TrainerName
	WHEN MATCHED THEN
		UPDATE 
			SET T.TrainerStarts = S.TrainerStarts, 
				T.TrainerWins = S.TrainerWins, 
				T.TrainerPlaces = S.TrainerPlaces, 
				T.TrainerShows = S.TrainerShows, 
				T.TrainerPercentage = S.TrainerPercentage, 
				T.TrainerStatsYTD = S.TrainerStatsYTD, 
				T.TrainerLifetimeStats = SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, LEN(S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD) - 1),
				T.TrainerLifetimeTotalRaces = SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD)),
				T.TrainerLifetimeTotalWin = SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2) - CHARINDEX(' ', S.TrainerStatsYTD)),
				T.TrainerLifetimeWinPercentage = SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2), CHARINDEX(')', S.TrainerStatsYTD) - CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2)),
			    T.ChangeDate = GETDATE()
    WHEN NOT MATCHED THEN  
		INSERT (
					TrainerName, 
					TrainerStarts, 
					TrainerWins, 
					TrainerPlaces, 
					TrainerShows, 
					TrainerPercentage, 
					TrainerStatsYTD, 
					TrainerLifetimeStats,
					TrainerLifetimeTotalRaces,
					TrainerLifetimeTotalWin,
					TrainerLifetimeWinPercentage,
					ChangeDate
			   )
			   VALUES
			   (
					S.TrainerName, 
					S.TrainerStarts, 
					S.TrainerWins, 
					S.TrainerPlaces, 
					S.TrainerShows, 
					S.TrainerPercentage, 
					S.TrainerStatsYTD, 
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, LEN(S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD) - 1),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX('(', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD) - CHARINDEX('(', S.TrainerStatsYTD)),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 1, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2) - CHARINDEX(' ', S.TrainerStatsYTD)),
					SUBSTRING(S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2), CHARINDEX(')', S.TrainerStatsYTD) - CHARINDEX(' ', S.TrainerStatsYTD, CHARINDEX(' ', S.TrainerStatsYTD) + 2)),
					GETDATE()
			   );
END

GO






