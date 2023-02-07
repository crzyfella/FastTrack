IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseInformation]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseInformation]
GO

CREATE PROCEDURE [kelso].[vsp_HorseInformation]
(
	@HorseId INT,
	@RacId INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH historyCTE AS
	(
		SELECT *
		FROM kelso.HorseHistory
		WHERE HorseID = @HorseId
			  AND RaceDt < @RaceDt
	)
	SELECT H.HorseID,
		   H.HorseName,
		   (
			SELECT MAX (RaceDt) 
			FROM historyCTE
		   ) LastRaceDt, 
		   DATEDIFF(DAY,
					(
						SELECT MAX (RaceDt) 
						FROM historyCTE
					),
					@RaceDt 
		   ) NumOfDaysSinceLastRace,
		   (
			SELECT MAX (WorkOutDt) 
			FROM kelso.WorkoutHistory
			WHERE HorseID = H.HorseID 
				  AND WorkOutDt <= @RaceDt
		   ) LastWorkoutDt,
		   DATEDIFF(DAY,
					(
						SELECT MAX (WorkOutDt) 
						FROM kelso.WorkoutHistory
						WHERE HorseID = H.HorseID 
							  AND WorkOutDt <= @RaceDt
					),
					@RaceDt
		   ) NumOfDaysSinceLastWorkout,
		   (
				SELECT CONVERT
					   (
						FLOAT,
						CASE
							WHEN CHARINDEX('-', MorningLine) > 0 THEN SUBSTRING(MorningLine, 1, CHARINDEX('-', MorningLine) - 1)
							WHEN CHARINDEX('/', MorningLine) > 0 THEN SUBSTRING(MorningLine, 1, CHARINDEX('/', MorningLine) - 1)
							ELSE 1
						 END 
						) /
						CONVERT
						(
						 FLOAT,
						 CASE
							WHEN CHARINDEX('-', MorningLine) > 0 THEN SUBSTRING(MorningLine, CHARINDEX('-', MorningLine) + 1, 10)
							WHEN CHARINDEX('/', MorningLine) > 0 THEN SUBSTRING(MorningLine, CHARINDEX('/', MorningLine) + 1, 10)
							ELSE 1
						 END)  
				FROM kelso.ent
				WHERE RacID = @RacId AND HorseID = H.HorseID 
		   ) BettingLine,
		   H.StartsThisYr,
		   H.WinThisYr, 
		   CASE
			WHEN ISNULL(H.StartsThisYr, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.WinThisYr AS FLOAT) / CAST(H.StartsThisYr AS FLOAT)), 2) 
		   END WinsPerc,
		   (H.WinThisYr + H.PlaceThisYr + H.ShowThisYr) Top3Finishes,
		   CASE 
			WHEN ISNULL(H.StartsThisYr, 0) = 0 THEN NULL
			ELSE ROUND(CAST((H.WinThisYr + H.PlaceThisYr  + H.ShowThisYr) AS FLOAT) / CAST(H.StartsThisYr AS FLOAT), 2)
		   END Top3FinishesWinPerc,
		   H.LifetimeStarts,
		   H.LifetimeWins,
		   CASE
			WHEN ISNULL(H.LifetimeStarts, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.LifetimeWins AS FLOAT) / CAST(H.LifetimeStarts AS FLOAT)), 2) 
		   END LifetimeWinsPerc,
		   (H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) LifetimeTop3Finish,
		   CASE 
			WHEN ISNULL(H.LifetimeStarts, 0) = 0 THEN NULL
			ELSE ROUND(CAST((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) AS FLOAT) / CAST(H.LifetimeStarts AS FLOAT), 2)
		   END Top3FinishesLifetimePerc,
		   H.TurfStarts,
		   H.TurfWins,
		   CASE
			WHEN ISNULL(H.TurfStarts, 0) = 0 THEN NULL
			ELSE ROUND((CAST(H.TurfWins AS FLOAT) / CAST(H.TurfStarts AS FLOAT)), 2) 
		   END TurfWinsPerc,
		   (H.TurfWins + H.TurfPlaces + H.TurfShows) TurfTop3Finishes,
		   CASE 
			WHEN ISNULL(H.TurfStarts, 0) = 0 THEN NULL
			ELSE ROUND(CAST(((H.TurfWins + H.TurfPlaces + H.TurfShows)) AS FLOAT) / CAST(H.TurfStarts AS FLOAT), 2)
		   END Top3FinishesTurfPerc,
		   (H.LifetimeStarts - H.TurfStarts) NonTurfStarts,
		   CASE 
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND (H.LifetimeWins - H.TurfWins) > 0 THEN H.LifetimeWins - H.TurfWins 
		   END NonTurfWins,
		   CASE
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND (H.LifetimeWins - H.TurfWins) > 0 THEN ROUND(CAST((H.LifetimeWins - H.TurfWins) AS FLOAT) / CAST((H.LifetimeStarts - H.TurfStarts) AS FLOAT), 2)
		   END NonTurfWinsPerc,
		   CASE 
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) > 0 THEN ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) 
		   END NonTurfTop3Finishes,
		   CASE
			WHEN (H.LifetimeStarts - H.TurfStarts) > 0 AND ((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows)) > 0 THEN ROUND(CAST((H.LifetimeWins + H.LifetimePlaces + H.LifetimeShows) - (H.TurfWins + H.TurfPlaces + H.TurfShows) AS FLOAT) / CAST((H.LifetimeStarts - H.TurfStarts) AS FLOAT), 2)
		   END Top3FinishesNonTurfPerc,
		   H.TurfRating,
		   H.OffTrackRating
	FROM kelso.Horses H
	WHERE H.HorseID = @HorseId;

END

GO









