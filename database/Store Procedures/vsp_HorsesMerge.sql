IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorsesMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorsesMerge]
GO

CREATE PROCEDURE [kelso].[vsp_HorsesMerge]
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Horses H
	USING (
			SELECT DISTINCT HorseName,
							CurrentYr,
						    StartsThisYr,
							WinThisYr,
							PlacesThisYr,
							ShowsThisYr,
							EarningThisYr,
							LifetimeStarts,
							LifetimeWins,
							LifetimePlaces,
							LifetimeShows,
							LifetimeEarnings,
							TurfStarts,
							TurfWins,
							TurfPlaces,
							TurfShows,
							OffTrackRating,
							TurfRating,
							RaceDt
			FROM kelso.ent_staging 
		  ) S
	ON S.HorseName = H.HorseName
	WHEN MATCHED THEN
		UPDATE 
			SET H.CurrentYear = NULL,
			    H.StartsThisYr = S.StartsThisYr,
			    H.WinThisYr = S.WinThisYr,
			    H.PlaceThisYr = S.PlacesThisYr,
			    H.ShowThisYr = S.ShowsThisYr,
			    H.EarningThisYr = S.EarningThisYr,
			    H.LifetimeStarts = S.LifetimeStarts,
			    H.LifetimeWins = S.LifetimeWins,
			    H.LifetimePlaces = S.LifetimePlaces,
			    H.LifetimeShows = S.LifetimeShows,
			    H.LifetimeEarnings = S.LifetimeEarnings,
			    H.TurfStarts = S.TurfStarts,
			    H.TurfWins = S.TurfWins,
			    H.TurfPlaces = S.TurfPlaces,
			    H.TurfShows = S.TurfShows,
			    H.OffTrackRating = S.OffTrackRating,
			    H.TurfRating = S.TurfRating,
			    H.ChangeDt = GETDATE(),
				H.RaceDt = S.RaceDt
    WHEN NOT MATCHED THEN  
		INSERT (
					HorseName,
					StartsThisYr,
					WinThisYr,
					PlaceThisYr,
					ShowThisYr,
					EarningThisYr,
					LifetimeStarts,
					LifetimeWins,
					LifetimePlaces,
					LifetimeShows,
					LifetimeEarnings,
					TurfStarts,
					TurfWins,
					TurfPlaces,
					TurfShows,
					OffTrackRating,
					TurfRating,
					ChangeDt,
					RaceDt
			   )
			   VALUES
			   (
					S.HorseName,
					S.StartsThisYr,
					S.WinThisYr,
					S.PlacesThisYr,
					S.ShowsThisYr,
					S.EarningThisYr,
				    S.LifetimeStarts,
				    S.LifetimeWins,
				    S.LifetimePlaces,
				    S.LifetimeShows,
				    S.LifetimeEarnings,
				    S.TurfStarts,
				    S.TurfWins,
					S.TurfPlaces,
				    S.TurfShows,
				    S.OffTrackRating,
				    S.TurfRating,
					GETDATE(),
					S.RaceDt
			   );
END

GO






