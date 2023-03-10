IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_HorseInformationMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_HorseInformationMerge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseInformationMerge]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DR2.RaceDt
		   ,H.HorseId
	       ,DR2.HorseName
	       ,DR2.Sex
	       ,DR2.YearOfBirth
	       ,DR2.HorseFoalingMonth
	       ,DR2.[Weight]
	       ,DR2.Sire
	       ,DR2.SireSire
	       ,DR2.Dam
	       ,DR2.DamSire
	       ,DR2.Breeder
	       ,DR2.StateCountry
	       ,DR2.LifeTimeRecordTodayDistanceStarts
	       ,DR2.LifeTimeRecordTodayDistanceWins
	       ,DR2.LifeTimeRecordTodayDistancePlaces
	       ,DR2.LifeTimeRecordTodayDistanceShows
	       ,DR2.LifeTimeRecordTodayDistanceEarning
	       ,DR2.LifeTimeRecordTodayTrackStarts
	       ,DR2.LifeTimeRecordTodayTrackWins
	       ,DR2.LifeTimeRecordTodayTrackPlaces
	       ,DR2.LifeTimeRecordTodayTrackShows
	       ,DR2.LifeTimeRecordTodayTrackEarning
	       ,DR2.LifeTimeTurfRecordStarts
	       ,DR2.LifeTimeTurfRecordWins
	       ,DR2.LifeTimeTurfRecordPlaces
	       ,DR2.LifeTimeTurfRecordShows
	       ,DR2.LifeTimeTurfRecordEarning
	       ,DR2.LifeTimeWetRecordStarts
	       ,DR2.LifeTimeWetRecordWins
	       ,DR2.LifeTimeWetRecordPlaces
	       ,DR2.LifeTimeWetRecordShows
	       ,DR2.LifeTimeWetRecordEarning
	       ,DR2.CurrentRecordYear
	       ,DR2.CurrentRecordStarts
	       ,DR2.CurrentRecordWins
	       ,DR2.CurrentRecordPlaces
	       ,DR2.CurrentRecordShows
	       ,DR2.CurrentRecordEarning
	       ,DR2.PreviousRecordYear
	       ,DR2.PreviousRecordStarts
	       ,DR2.PreviousRecordWins
	       ,DR2.PreviousRecordPlaces
	       ,DR2.PreviousRecordShows
	       ,DR2.PreviousRecordEarning
	       ,DR2.LifetimeRecordStarts
	       ,DR2.LifetimeRecordWins
	       ,DR2.LifetimeRecordPlaces
	       ,DR2.LifetimeRecordShows
	       ,DR2.LifetimeRecordEarning
	       ,DR2.LifetimeStartsAllWeather
	       ,DR2.LifetimeWinsAllWeather
	       ,DR2.LifetimePlacesAllWeather
	       ,DR2.LifetimeShowsAllWeather
	       ,DR2.LifetimeEarningsAllWeather
		   ,ROW_NUMBER() OVER(ORDER BY (SELECT 0)) RowNum
	INTO #brisnet_horses
	FROM kelso.brisnet_dr2 DR2
	LEFT JOIN kelso.brisnet_Horses H ON H.HorseName = DR2.HorseName
	WHERE DR2.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','));

	MERGE kelso.brisnet_Horses AS [TARGET]
    USING #brisnet_horses [SOURCE]
    ON ([SOURCE].[HorseId] = [TARGET].[HorseId])
	WHEN MATCHED AND [SOURCE].[RaceDt] < [TARGET].[RaceDt]
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[RaceDt] = [SOURCE].[RaceDt]
			,[TARGET].[Weight] = [SOURCE].[Weight]
			,[TARGET].[Breeder] = [SOURCE].[Breeder]
			,[TARGET].[StateCountry] = [SOURCE].[StateCountry]
			,[TARGET].[LifeTimeRecordTodayDistanceStarts] = [SOURCE].[LifeTimeRecordTodayDistanceStarts]
			,[TARGET].[LifeTimeRecordTodayDistanceWins] = [SOURCE].[LifeTimeRecordTodayDistanceWins]
			,[TARGET].[LifeTimeRecordTodayDistancePlaces] = [SOURCE].[LifeTimeRecordTodayDistancePlaces]
			,[TARGET].[LifeTimeRecordTodayDistanceShows] = [SOURCE].[LifeTimeRecordTodayDistanceShows]
			,[TARGET].[LifeTimeRecordTodayDistanceEarning] = [SOURCE].[LifeTimeRecordTodayDistanceEarning]
			,[TARGET].[LifeTimeRecordTodayTrackStarts] = [SOURCE].[LifeTimeRecordTodayTrackStarts]
			,[TARGET].[LifeTimeRecordTodayTrackWins] = [SOURCE].[LifeTimeRecordTodayTrackWins]
			,[TARGET].[LifeTimeRecordTodayTrackPlaces] = [SOURCE].[LifeTimeRecordTodayTrackPlaces]
			,[TARGET].[LifeTimeRecordTodayTrackShows] = [SOURCE].[LifeTimeRecordTodayTrackShows]
			,[TARGET].[LifeTimeRecordTodayTrackEarning] = [SOURCE].[LifeTimeRecordTodayTrackEarning]
			,[TARGET].[LifeTimeTurfRecordStarts] = [SOURCE].[LifeTimeTurfRecordStarts]
			,[TARGET].[LifeTimeTurfRecordWins] = [SOURCE].[LifeTimeTurfRecordWins]
			,[TARGET].[LifeTimeTurfRecordPlaces] = [SOURCE].[LifeTimeTurfRecordPlaces]
			,[TARGET].[LifeTimeTurfRecordShows] = [SOURCE].[LifeTimeTurfRecordShows]
			,[TARGET].[LifeTimeTurfRecordEarning] = [SOURCE].[LifeTimeTurfRecordEarning]
			,[TARGET].[LifeTimeWetRecordStarts] = [SOURCE].[LifeTimeWetRecordStarts]
			,[TARGET].[LifeTimeWetRecordWins] = [SOURCE].[LifeTimeWetRecordWins]
			,[TARGET].[LifeTimeWetRecordPlaces] = [SOURCE].[LifeTimeWetRecordPlaces]
			,[TARGET].[LifeTimeWetRecordShows] = [SOURCE].[LifeTimeWetRecordShows]
			,[TARGET].[LifeTimeWetRecordEarning] = [SOURCE].[LifeTimeWetRecordEarning]
			,[TARGET].[CurrentRecordYear] = [SOURCE].[CurrentRecordYear]
			,[TARGET].[CurrentRecordStarts] = [SOURCE].[CurrentRecordStarts]
			,[TARGET].[CurrentRecordWins] = [SOURCE].[CurrentRecordWins]
			,[TARGET].[CurrentRecordPlaces] = [SOURCE].[CurrentRecordPlaces]
			,[TARGET].[CurrentRecordShows] = [SOURCE].[CurrentRecordShows]
			,[TARGET].[CurrentRecordEarning] = [SOURCE].[CurrentRecordEarning]
			,[TARGET].[PreviousRecordYear] = [SOURCE].[PreviousRecordYear]
			,[TARGET].[PreviousRecordStarts] = [SOURCE].[PreviousRecordStarts]
			,[TARGET].[PreviousRecordWins] = [SOURCE].[PreviousRecordWins]
			,[TARGET].[PreviousRecordPlaces] = [SOURCE].[PreviousRecordPlaces]
			,[TARGET].[PreviousRecordShows] = [SOURCE].[PreviousRecordShows]
			,[TARGET].[PreviousRecordEarning] = [SOURCE].[PreviousRecordEarning]
			,[TARGET].[LifetimeRecordStarts] = [SOURCE].[LifetimeRecordStarts]
			,[TARGET].[LifetimeRecordWins] = [SOURCE].[LifetimeRecordWins]
			,[TARGET].[LifetimeRecordPlaces] = [SOURCE].[LifetimeRecordPlaces]
			,[TARGET].[LifetimeRecordShows] = [SOURCE].[LifetimeRecordShows]
			,[TARGET].[LifetimeRecordEarning] = [SOURCE].[LifetimeRecordEarning]
			,[TARGET].[LifetimeStartsAllWeather] = [SOURCE].[LifetimeStartsAllWeather]
			,[TARGET].[LifetimeWinsAllWeather] = [SOURCE].[LifetimeWinsAllWeather]
			,[TARGET].[LifetimePlacesAllWeather] = [SOURCE].[LifetimePlacesAllWeather]
			,[TARGET].[LifetimeShowsAllWeather] = [SOURCE].[LifetimeShowsAllWeather]
			,[TARGET].[LifetimeEarningsAllWeather] = [SOURCE].[LifetimeEarningsAllWeather]
	WHEN NOT MATCHED 
    THEN INSERT ([CreatedDt]
				 ,[ModifiedDt]
				 ,[RaceDt]
				 ,[HorseId]
				 ,[HorseName]
				 ,[Sex]
				 ,[YearOfBirth]
				 ,[HorseFoalingMonth]
				 ,[Weight]
				 ,[Sire]
				 ,[SireSire]
				 ,[Dam]
				 ,[DamSire]
				 ,[Breeder]
				 ,[StateCountry]
				 ,[LifeTimeRecordTodayDistanceStarts]
				 ,[LifeTimeRecordTodayDistanceWins]
				 ,[LifeTimeRecordTodayDistancePlaces]
				 ,[LifeTimeRecordTodayDistanceShows]
				 ,[LifeTimeRecordTodayDistanceEarning]
				 ,[LifeTimeRecordTodayTrackStarts]
				 ,[LifeTimeRecordTodayTrackWins]
				 ,[LifeTimeRecordTodayTrackPlaces]
				 ,[LifeTimeRecordTodayTrackShows]
				 ,[LifeTimeRecordTodayTrackEarning]
				 ,[LifeTimeTurfRecordStarts]
				 ,[LifeTimeTurfRecordWins]
				 ,[LifeTimeTurfRecordPlaces]
				 ,[LifeTimeTurfRecordShows]
				 ,[LifeTimeTurfRecordEarning]
				 ,[LifeTimeWetRecordStarts]
				 ,[LifeTimeWetRecordWins]
				 ,[LifeTimeWetRecordPlaces]
				 ,[LifeTimeWetRecordShows]
				 ,[LifeTimeWetRecordEarning]
				 ,[CurrentRecordYear]
				 ,[CurrentRecordStarts]
				 ,[CurrentRecordWins]
				 ,[CurrentRecordPlaces]
				 ,[CurrentRecordShows]
				 ,[CurrentRecordEarning]
				 ,[PreviousRecordYear]
				 ,[PreviousRecordStarts]
				 ,[PreviousRecordWins]
				 ,[PreviousRecordPlaces]
				 ,[PreviousRecordShows]
				 ,[PreviousRecordEarning]
				 ,[LifetimeRecordStarts]
				 ,[LifetimeRecordWins]
				 ,[LifetimeRecordPlaces]
				 ,[LifetimeRecordShows]
				 ,[LifetimeRecordEarning]
				 ,[LifetimeStartsAllWeather]
				 ,[LifetimeWinsAllWeather]
				 ,[LifetimePlacesAllWeather]
				 ,[LifetimeShowsAllWeather]
				 ,[LifetimeEarningsAllWeather])
	VALUES (GETDATE()
				 ,GETDATE()
				 ,[SOURCE].[RaceDt]
				 ,NEWID()
				 ,[SOURCE].[HorseName]
				 ,[SOURCE].[Sex]
				 ,[SOURCE].[YearOfBirth]
				 ,[SOURCE].[HorseFoalingMonth]
				 ,[SOURCE].[Weight]
				 ,[SOURCE].[Sire]
				 ,[SOURCE].[SireSire]
				 ,[SOURCE].[Dam]
				 ,[SOURCE].[DamSire]
				 ,[SOURCE].[Breeder]
				 ,[SOURCE].[StateCountry]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceStarts]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceWins]
				 ,[SOURCE].[LifeTimeRecordTodayDistancePlaces]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceShows]
				 ,[SOURCE].[LifeTimeRecordTodayDistanceEarning]
				 ,[SOURCE].[LifeTimeRecordTodayTrackStarts]
				 ,[SOURCE].[LifeTimeRecordTodayTrackWins]
				 ,[SOURCE].[LifeTimeRecordTodayTrackPlaces]
				 ,[SOURCE].[LifeTimeRecordTodayTrackShows]
				 ,[SOURCE].[LifeTimeRecordTodayTrackEarning]
				 ,[SOURCE].[LifeTimeTurfRecordStarts]
				 ,[SOURCE].[LifeTimeTurfRecordWins]
				 ,[SOURCE].[LifeTimeTurfRecordPlaces]
				 ,[SOURCE].[LifeTimeTurfRecordShows]
				 ,[SOURCE].[LifeTimeTurfRecordEarning]
				 ,[SOURCE].[LifeTimeWetRecordStarts]
				 ,[SOURCE].[LifeTimeWetRecordWins]
				 ,[SOURCE].[LifeTimeWetRecordPlaces]
				 ,[SOURCE].[LifeTimeWetRecordShows]
				 ,[SOURCE].[LifeTimeWetRecordEarning]
				 ,[SOURCE].[CurrentRecordYear]
				 ,[SOURCE].[CurrentRecordStarts]
				 ,[SOURCE].[CurrentRecordWins]
				 ,[SOURCE].[CurrentRecordPlaces]
				 ,[SOURCE].[CurrentRecordShows]
				 ,[SOURCE].[CurrentRecordEarning]
				 ,[SOURCE].[PreviousRecordYear]
				 ,[SOURCE].[PreviousRecordStarts]
				 ,[SOURCE].[PreviousRecordWins]
				 ,[SOURCE].[PreviousRecordPlaces]
				 ,[SOURCE].[PreviousRecordShows]
				 ,[SOURCE].[PreviousRecordEarning]
				 ,[SOURCE].[LifetimeRecordStarts]
				 ,[SOURCE].[LifetimeRecordWins]
				 ,[SOURCE].[LifetimeRecordPlaces]
				 ,[SOURCE].[LifetimeRecordShows]
				 ,[SOURCE].[LifetimeRecordEarning]
				 ,[SOURCE].[LifetimeStartsAllWeather]
				 ,[SOURCE].[LifetimeWinsAllWeather]
				 ,[SOURCE].[LifetimePlacesAllWeather]
				 ,[SOURCE].[LifetimeShowsAllWeather]
				 ,[SOURCE].[LifetimeEarningsAllWeather]);

END

