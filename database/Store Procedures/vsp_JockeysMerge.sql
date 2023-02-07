IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_JockeysMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_JockeysMerge]
GO

CREATE PROCEDURE [kelso].[vsp_JockeysMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Jockeys J
	USING (
			SELECT DISTINCT JockeyName,
							JockeyStarts,
							JockeyWins,
							JockeyPlaces,
							JockeyShows,
							JockeyPercentage,
							JockeyStatsYTD,
							RaceDt
			FROM kelso.ent_staging 
		  ) S
	ON S.JockeyName = J.JockeyName
	WHEN MATCHED THEN
		UPDATE 
			SET J.JockeyStarts = S.JockeyStarts, 
				J.JockeyWins = S.JockeyWins, 
				J.JockeyPlaces = S.JockeyPlaces, 
				J.JockeyShows = S.JockeyShows, 
				J.JockeyPercentage = S.JockeyPercentage, 
				J.JockeyStatsYTD = S.JockeyStatsYTD, 
				J.JockeyLifetimeStats = SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, LEN(S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD) - 1),
				J.JockeyLifetimeTotalRaces = SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD)),
				J.JockeyLifetimeTotalWin = SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2) - CHARINDEX(' ', S.JockeyStatsYTD)),
				J.JockeyLifetimeWinPercentage = SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2), CHARINDEX(')', S.JockeyStatsYTD) - CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2)),
			    J.ChangeDate = GETDATE(),
				J.RaceDt = S.RaceDt
    WHEN NOT MATCHED THEN  
		INSERT (
					JockeyName, 
					JockeyStarts, 
					JockeyWins, 
					JockeyPlaces, 
					JockeyShows, 
					JockeyPercentage, 
					JockeyStatsYTD, 
					JockeyLifetimeStats,
					JockeyLifetimeTotalRaces,
					JockeyLifetimeTotalWin,
					JockeyLifetimeWinPercentage,
					ChangeDate,
					RaceDt
			   )
			   VALUES
			   (
					S.JockeyName, 
					S.JockeyStarts, 
					S.JockeyWins, 
					S.JockeyPlaces, 
					S.JockeyShows, 
					S.JockeyPercentage, 
					S.JockeyStatsYTD, 
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, LEN(S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD) - 1),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX('(', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD) - CHARINDEX('(', S.JockeyStatsYTD)),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 1, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2) - CHARINDEX(' ', S.JockeyStatsYTD)),
					SUBSTRING(S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2), CHARINDEX(')', S.JockeyStatsYTD) - CHARINDEX(' ', S.JockeyStatsYTD, CHARINDEX(' ', S.JockeyStatsYTD) + 2)),
					GETDATE(),
					S.RaceDt
			   );
END

GO






