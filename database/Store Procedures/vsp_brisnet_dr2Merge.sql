IF EXISTS (SELECT * FROM sysobjects 
      WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_dr2Merge]') 
       AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
 DROP PROCEDURE [kelso].[vsp_brisnet_dr2Merge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr2Merge]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brisnet_dr2 TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[PostPosition] [varchar](5) NULL,
		[Entry] [varchar](5) NULL,
		[ClaimingPrice] [decimal](18, 0) NULL,
		[Trainer] [varchar](100) NULL,
		[TrainerStartsCurrentMeet] [int] NULL,
		[TrainerWinCurrentMeet] [int] NULL,
		[TrainerPlacesCurrentMeet] [int] NULL,
		[TrainerShowCurrentMeet] [int] NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWeight] [int] NULL,
		[JockeyStartsCurrentMeet] [varchar](100) NULL,
		[JockeyWinsCurrentMeet] [varchar](100) NULL,
		[JockeyPlacesCurrentMeet] [varchar](100) NULL,
		[JockeyShowsCurrentMeet] [varchar](100) NULL,
		[Owner] [varchar](100) NULL,
		[TrainerRecordCurrentYear] [varchar](30) NULL,
		[TrainerRecordPreviousYear] [varchar](30) NULL,
		[JockeyRecordCurrentYear] [varchar](30) NULL,
		[JockeyRecordPreviousYear] [varchar](30) NULL,
		[OwnersSilks] [varchar](100) NULL,
		[HorseName] [varchar](100) NULL,
		[YearOfBirth] [int] NULL,
		[HorseFoalingMonth] [int] NULL,
		[Reserved28] [varchar](50) NULL,
		[Sex] [char](1) NULL,
		[HorseColor] [varchar](50) NULL,
		[Weight] [int] NULL,
		[Sire] [varchar](50) NULL,
		[SireSire] [varchar](50) NULL,
		[Dam] [varchar](150) NULL,
		[DamSire] [varchar](150) NULL,
		[Breeder] [varchar](150) NULL,
		[StateCountry] [varchar](25) NULL,
		[AuctionPrice] [decimal](18, 0) NULL,
		[InfoSoldAtAuction] [varchar](25) NULL,
		[Reserved40] [varchar](150) NULL,
		[AEIndicator] [char](1) NULL,
		[Medication1stLasixInfo] [int] NULL,
		[Medication1stWithOutLasixInfo] [int] NULL,
		[EquipmentChange] [int] NULL,
		[LifeTimeRecordTodayDistanceStarts] [int] NULL,
		[LifeTimeRecordTodayDistanceWins] [int] NULL,
		[LifeTimeRecordTodayDistancePlaces] [int] NULL,
		[LifeTimeRecordTodayDistanceShows] [int] NULL,
		[LifeTimeRecordTodayDistanceEarning] [decimal](18, 0) NULL,
		[LifeTimeRecordTodayTrackStarts] [int] NULL,
		[LifeTimeRecordTodayTrackWins] [int] NULL,
		[LifeTimeRecordTodayTrackPlaces] [int] NULL,
		[LifeTimeRecordTodayTrackShows] [int] NULL,
		[LifeTimeRecordTodayTrackEarning] [decimal](18, 0) NULL,
		[LifeTimeTurfRecordStarts] [int] NULL,
		[LifeTimeTurfRecordWins] [int] NULL,
		[LifeTimeTurfRecordPlaces] [int] NULL,
		[LifeTimeTurfRecordShows] [int] NULL,
		[LifeTimeTurfRecordEarning] [decimal](18, 0) NULL,
		[LifeTimeWetRecordStarts] [int] NULL,
		[LifeTimeWetRecordWins] [int] NULL,
		[LifeTimeWetRecordPlaces] [int] NULL,
		[LifeTimeWetRecordShows] [int] NULL,
		[LifeTimeWetRecordEarning] [decimal](18, 0) NULL,
		[CurrentRecordYear] [int] NULL,
		[CurrentRecordStarts] [int] NULL,
		[CurrentRecordWins] [int] NULL,
		[CurrentRecordPlaces] [int] NULL,
		[CurrentRecordShows] [int] NULL,
		[CurrentRecordEarning] [decimal](18, 0) NULL,
		[PreviousRecordYear] [int] NULL,
		[PreviousRecordStarts] [int] NULL,
		[PreviousRecordWins] [int] NULL,
		[PreviousRecordPlaces] [int] NULL,
		[PreviousRecordShows] [int] NULL,
		[PreviousRecordEarning] [decimal](18, 0) NULL,
		[LifetimeRecordStarts] [int] NULL,
		[LifetimeRecordWins] [int] NULL,
		[LifetimeRecordPlaces] [int] NULL,
		[LifetimeRecordShows] [int] NULL,
		[LifetimeRecordEarning] [decimal](18, 0) NULL,
		[Workout1Date] [datetime] NULL,
		[Workout2Date] [datetime] NULL,
		[Workout3Date] [datetime] NULL,
		[Workout4Date] [datetime] NULL,
		[Workout5Date] [datetime] NULL,
		[Workout6Date] [datetime] NULL,
		[Workout7Date] [datetime] NULL,
		[Workout8Date] [datetime] NULL,
		[Workout9Date] [datetime] NULL,
		[Workout10Date] [datetime] NULL,
		[Workout11Date] [datetime] NULL,
		[Workout12Date] [datetime] NULL,
		[Workout1Time] [decimal](18, 2) NULL,
		[Workout2Time] [decimal](18, 2) NULL,
		[Workout3Time] [decimal](18, 2) NULL,
		[Workout4Time] [decimal](18, 2) NULL,
		[Workout5Time] [decimal](18, 2) NULL,
		[Workout6Time] [decimal](18, 2) NULL,
		[Workout7Time] [decimal](18, 2) NULL,
		[Workout8Time] [decimal](18, 2) NULL,
		[Workout9Time] [decimal](18, 2) NULL,
		[Workout10Time] [decimal](18, 2) NULL,
		[Workout11Time] [decimal](18, 2) NULL,
		[Workout12Time] [decimal](18, 2) NULL,
		[Workout1Track] [varchar](10) NULL,
		[Workout2Track] [varchar](10) NULL,
		[Workout3Track] [varchar](10) NULL,
		[Workout4Track] [varchar](10) NULL,
		[Workout5Track] [varchar](10) NULL,
		[Workout6Track] [varchar](10) NULL,
		[Workout7Track] [varchar](10) NULL,
		[Workout8Track] [varchar](10) NULL,
		[Workout9Track] [varchar](10) NULL,
		[Workout10Track] [varchar](10) NULL,
		[Workout11Track] [varchar](10) NULL,
		[Workout12Track] [varchar](10) NULL,
		[Workout1Distance] [decimal](18, 0) NULL,
		[Workout2Distance] [decimal](18, 0) NULL,
		[Workout3Distance] [decimal](18, 0) NULL,
		[Workout4Distance] [decimal](18, 0) NULL,
		[Workout5Distance] [decimal](18, 0) NULL,
		[Workout6Distance] [decimal](18, 0) NULL,
		[Workout7Distance] [decimal](18, 0) NULL,
		[Workout8Distance] [decimal](18, 0) NULL,
		[Workout9Distance] [decimal](18, 0) NULL,
		[Workout10Distance] [decimal](18, 0) NULL,
		[Workout11Distance] [decimal](18, 0) NULL,
		[Workout12Distance] [decimal](18, 0) NULL,
		[WorkoutTrackCondition1] [varchar](5) NULL,
		[WorkoutTrackCondition2] [varchar](5) NULL,
		[WorkoutTrackCondition3] [varchar](5) NULL,
		[WorkoutTrackCondition4] [varchar](5) NULL,
		[WorkoutTrackCondition5] [varchar](5) NULL,
		[WorkoutTrackCondition6] [varchar](5) NULL,
		[WorkoutTrackCondition7] [varchar](5) NULL,
		[WorkoutTrackCondition8] [varchar](5) NULL,
		[WorkoutTrackCondition9] [varchar](5) NULL,
		[WorkoutTrackCondition10] [varchar](5) NULL,
		[WorkoutTrackCondition11] [varchar](5) NULL,
		[WorkoutTrackCondition12] [varchar](5) NULL,
		[Workout1Description] [varchar](5) NULL,
		[Workout2Description] [varchar](5) NULL,
		[Workout3Description] [varchar](5) NULL,
		[Workout4Description] [varchar](5) NULL,
		[Workout5Description] [varchar](5) NULL,
		[Workout6Description] [varchar](5) NULL,
		[Workout7Description] [varchar](5) NULL,
		[Workout8Description] [varchar](5) NULL,
		[Workout9Description] [varchar](5) NULL,
		[Workout10Description] [varchar](5) NULL,
		[Workout11Description] [varchar](5) NULL,
		[Workout12Description] [varchar](5) NULL,
		[MainInnerTrackIndicator1] [varchar](5) NULL,
		[MainInnerTrackIndicator2] [varchar](5) NULL,
		[MainInnerTrackIndicator3] [varchar](5) NULL,
		[MainInnerTrackIndicator4] [varchar](5) NULL,
		[MainInnerTrackIndicator5] [varchar](5) NULL,
		[MainInnerTrackIndicator6] [varchar](5) NULL,
		[MainInnerTrackIndicator7] [varchar](5) NULL,
		[MainInnerTrackIndicator8] [varchar](5) NULL,
		[MainInnerTrackIndicator9] [varchar](5) NULL,
		[MainInnerTrackIndicator10] [varchar](5) NULL,
		[MainInnerTrackIndicator11] [varchar](5) NULL,
		[MainInnerTrackIndicator12] [varchar](5) NULL,
		[NumberOfWorkout1] [varchar](5) NULL,
		[NumberOfWorkout2] [varchar](5) NULL,
		[NumberOfWorkout3] [varchar](5) NULL,
		[NumberOfWorkout4] [varchar](5) NULL,
		[NumberOfWorkout5] [varchar](5) NULL,
		[NumberOfWorkout6] [varchar](5) NULL,
		[NumberOfWorkout7] [varchar](5) NULL,
		[NumberOfWorkout8] [varchar](5) NULL,
		[NumberOfWorkout9] [varchar](5) NULL,
		[NumberOfWorkout10] [varchar](5) NULL,
		[NumberOfWorkout11] [varchar](5) NULL,
		[NumberOfWorkout12] [varchar](5) NULL,
		[WorkoutRank1] [varchar](5) NULL,
		[WorkoutRank2] [varchar](5) NULL,
		[WorkoutRank3] [varchar](5) NULL,
		[WorkoutRank4] [varchar](5) NULL,
		[WorkoutRank5] [varchar](5) NULL,
		[WorkoutRank6] [varchar](5) NULL,
		[WorkoutRank7] [varchar](5) NULL,
		[WorkoutRank8] [varchar](5) NULL,
		[WorkoutRank9] [varchar](5) NULL,
		[WorkoutRank10] [varchar](5) NULL,
		[WorkoutRank11] [varchar](5) NULL,
		[WorkoutRank12] [varchar](5) NULL,
		[BrisRunStyle] [varchar](5) NULL,
		[QuirinSpeedPoints] [int] NULL,
		[Reserved191Reserved] [varchar](50) NULL,
		[Reserved192Reserved] [varchar](50) NULL,
		[Bris2fPaceFig] [int] NULL,
		[Bris4fPaceFig] [int] NULL,
		[Bris6fPaceFig] [int] NULL,
		[BrisSpeedFig] [int] NULL,
		[BrisLatePace] [int] NULL,
		[Reserved198] [varchar](50) NULL,
		[Reserved199] [varchar](50) NULL,
		[ProgramPostPosition] [int] NULL,
		[ProgramNumber] [varchar](5) NULL,
		[MorningLine] [decimal](18, 2) NULL,
		[NumOfDaySinceLastRace] [int] NULL,
		[RaceConditionLine1] [varchar](275) NULL,
		[RaceConditionLine2] [varchar](275) NULL,
		[RaceConditionLine3] [varchar](275) NULL,
		[RaceConditionLine4] [varchar](275) NULL,
		[RaceConditionLine5] [varchar](275) NULL,
		[RaceConditionLine6] [varchar](275) NULL,
		[LifetimeStartsAllWeather] [int] NULL,
		[LifetimeWinsAllWeather] [int] NULL,
		[LifetimePlacesAllWeather] [int] NULL,
		[LifetimeShowsAllWeather] [int] NULL,
		[LifetimeEarningsAllWeather] [decimal](18, 0) NULL,
		[BestBRISSpeedAllWeather] [int] NULL,
		[Reserved216] [varchar](50) NULL,
		[LowClaimingPrice] [decimal](18, 0) NULL,
		[StatebredFlag] [char](1) NULL,
		[WagerTypes219] [varchar](150) NULL,
		[WagerTypes220] [varchar](150) NULL,
		[WagerTypes221] [varchar](150) NULL,
		[WagerTypes222] [varchar](150) NULL,
		[WagerTypes223] [varchar](150) NULL,
		[WagerTypes224] [varchar](150) NULL,
		[WagerTypes225] [varchar](150) NULL,
		[WagerTypes226] [varchar](150) NULL,
		[WagerTypes227] [varchar](150) NULL,
		[SireStudFee] [decimal](18, 0) NULL,
		[BestBRISSpeedFastTrack] [int] NULL,
		[BestBRISSpeedTurf] [int] NULL,
		[BestBRISSpeedOffTrack] [int] NULL,
		[BestBRISSpeedDistance] [int] NULL,
		[Reserved233] [varchar](250) NULL,
		[Reserved234] [varchar](250) NULL
	)

	INSERT INTO @brisnet_dr2
	SELECT GETDATE()
			,GETDATE()
			,R.RaceId
			,[SOURCE].[TrackCd]
			,[SOURCE].[RaceDt]
			,[SOURCE].[RaceNum]
			,[SOURCE].[PostPosition]
			,[SOURCE].[Entry]
			,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[ClaimingPrice] )) AS decimal(18, 2)) END
			,[SOURCE].[Trainer]
			,[SOURCE].[TrainerStartsCurrentMeet]
			,[SOURCE].[TrainerWinCurrentMeet]
			,[SOURCE].[TrainerPlacesCurrentMeet]
			,[SOURCE].[TrainerShowCurrentMeet]
			,[SOURCE].[Jockey]
			,[SOURCE].[ApprenticeWeight]
			,[SOURCE].[JockeyStartsCurrentMeet]
			,[SOURCE].[JockeyWinsCurrentMeet]
			,[SOURCE].[JockeyPlacesCurrentMeet]
			,[SOURCE].[JockeyShowsCurrentMeet]
			,[SOURCE].[Owner]
			,[SOURCE].[TrainerRecordCurrentYear]
			,[SOURCE].[TrainerRecordPreviousYear]
			,[SOURCE].[JockeyRecordCurrentYear]
			,[SOURCE].[JockeyRecordPreviousYear]
			,[SOURCE].[OwnersSilks]
			,[SOURCE].[HorseName]
			,[SOURCE].[YearOfBirth]
			,[SOURCE].[HorseFoalingMonth]
			,[SOURCE].[Reserved28]
			,[SOURCE].[Sex]
			,[SOURCE].[HorseColor]
			,[SOURCE].[Weight]
			,[SOURCE].[Sire]
			,[SOURCE].[SireSire]
			,[SOURCE].[Dam]
			,[SOURCE].[DamSire]
			,[SOURCE].[Breeder]
			,[SOURCE].[StateCountry]
			,CASE WHEN ISNULL([SOURCE].[AuctionPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[AuctionPrice] )) AS decimal(18, 2)) END
			,[SOURCE].[InfoSoldAtAuction]
			,[SOURCE].[Reserved40]
			,[SOURCE].[AEIndicator]
			,[SOURCE].[Medication1stLasixInfo]
			,[SOURCE].[Medication1stWithOutLasixInfo]
			,[SOURCE].[EquipmentChange]
			,[SOURCE].[LifeTimeRecordTodayDistanceStarts]
			,[SOURCE].[LifeTimeRecordTodayDistanceWins]
			,[SOURCE].[LifeTimeRecordTodayDistancePlaces]
			,[SOURCE].[LifeTimeRecordTodayDistanceShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeRecordTodayDistanceEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeRecordTodayDistanceEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeRecordTodayTrackStarts]
			,[SOURCE].[LifeTimeRecordTodayTrackWins]
			,[SOURCE].[LifeTimeRecordTodayTrackPlaces]
			,[SOURCE].[LifeTimeRecordTodayTrackShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeRecordTodayTrackEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeRecordTodayTrackEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeTurfRecordStarts]
			,[SOURCE].[LifeTimeTurfRecordWins]
			,[SOURCE].[LifeTimeTurfRecordPlaces]
			,[SOURCE].[LifeTimeTurfRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeTurfRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeTurfRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifeTimeWetRecordStarts]
			,[SOURCE].[LifeTimeWetRecordWins]
			,[SOURCE].[LifeTimeWetRecordPlaces]
			,[SOURCE].[LifeTimeWetRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifeTimeWetRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifeTimeWetRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[CurrentRecordYear]
			,[SOURCE].[CurrentRecordStarts]
			,[SOURCE].[CurrentRecordWins]
			,[SOURCE].[CurrentRecordPlaces]
			,[SOURCE].[CurrentRecordShows]
			,CASE WHEN ISNULL([SOURCE].[CurrentRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[CurrentRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[PreviousRecordYear]
			,[SOURCE].[PreviousRecordStarts]
			,[SOURCE].[PreviousRecordWins]
			,[SOURCE].[PreviousRecordPlaces]
			,[SOURCE].[PreviousRecordShows]
			,CASE WHEN ISNULL([SOURCE].[PreviousRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[PreviousRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[LifetimeRecordStarts]
			,[SOURCE].[LifetimeRecordWins]
			,[SOURCE].[LifetimeRecordPlaces]
			,[SOURCE].[LifetimeRecordShows]
			,CASE WHEN ISNULL([SOURCE].[LifetimeRecordEarning], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifetimeRecordEarning] )) AS decimal(18, 2)) END
			,[SOURCE].[Workout1Date]
			,[SOURCE].[Workout2Date]
			,[SOURCE].[Workout3Date]
			,[SOURCE].[Workout4Date]
			,[SOURCE].[Workout5Date]
			,[SOURCE].[Workout6Date]
			,[SOURCE].[Workout7Date]
			,[SOURCE].[Workout8Date]
			,[SOURCE].[Workout9Date]
			,[SOURCE].[Workout10Date]
			,[SOURCE].[Workout11Date]
			,[SOURCE].[Workout12Date]
			,CASE WHEN ISNULL([SOURCE].[Workout1Time], '') = '' THEN 0 WHEN CHARINDEX('0', [SOURCE].[Workout1Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout1Time], CHARINDEX('-', [SOURCE].[Workout1Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout1Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout2Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout2Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout2Time], CHARINDEX('-', [SOURCE].[Workout2Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout2Time])END
			,CASE WHEN ISNULL([SOURCE].[Workout3Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout3Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout3Time], CHARINDEX('-', [SOURCE].[Workout3Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout3Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout4Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout4Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout4Time], CHARINDEX('-', [SOURCE].[Workout4Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout4Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout5Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout5Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout5Time], CHARINDEX('-', [SOURCE].[Workout5Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout5Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout6Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout6Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout6Time], CHARINDEX('-', [SOURCE].[Workout6Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout6Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout7Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout7Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout7Time], CHARINDEX('-', [SOURCE].[Workout7Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout7Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout8Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout8Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout8Time], CHARINDEX('-', [SOURCE].[Workout8Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout8Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout9Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout9Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout9Time], CHARINDEX('-', [SOURCE].[Workout9Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout9Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout10Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout10Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout10Time], CHARINDEX('-', [SOURCE].[Workout10Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout10Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout11Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout11Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout11Time], CHARINDEX('-', [SOURCE].[Workout11Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout11Time]) END
			,CASE WHEN ISNULL([SOURCE].[Workout12Time], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout12Time]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout12Time], CHARINDEX('-', [SOURCE].[Workout12Time]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout12Time]) END
			,[SOURCE].[Workout1Track]
			,[SOURCE].[Workout2Track]
			,[SOURCE].[Workout3Track]
			,[SOURCE].[Workout4Track]
			,[SOURCE].[Workout5Track]
			,[SOURCE].[Workout6Track]
			,[SOURCE].[Workout7Track]
			,[SOURCE].[Workout8Track]
			,[SOURCE].[Workout9Track]
			,[SOURCE].[Workout10Track]
			,[SOURCE].[Workout11Track]
			,[SOURCE].[Workout12Track]
			,CASE WHEN ISNULL([SOURCE].[Workout1Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout1Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout1Distance], CHARINDEX('-', [SOURCE].[Workout1Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout1Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout2Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout2Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout2Distance], CHARINDEX('-', [SOURCE].[Workout2Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout2Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout3Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout3Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout3Distance], CHARINDEX('-', [SOURCE].[Workout3Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout3Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout4Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout4Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout4Distance], CHARINDEX('-', [SOURCE].[Workout4Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout4Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout5Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout5Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout5Distance], CHARINDEX('-', [SOURCE].[Workout5Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout5Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout6Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout6Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout6Distance], CHARINDEX('-', [SOURCE].[Workout6Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout6Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout7Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout7Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout7Distance], CHARINDEX('-', [SOURCE].[Workout7Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout7Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout8Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout8Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout8Distance], CHARINDEX('-', [SOURCE].[Workout8Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout8Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout9Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout9Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout9Distance], CHARINDEX('-', [SOURCE].[Workout9Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout9Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout10Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout10Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout10Distance], CHARINDEX('-', [SOURCE].[Workout10Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout10Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout11Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout11Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout11Distance], CHARINDEX('-', [SOURCE].[Workout11Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout11Distance]) END
			,CASE WHEN ISNULL([SOURCE].[Workout12Distance], '') = '' THEN 0 WHEN CHARINDEX('-', [SOURCE].[Workout12Distance]) > 0 THEN CONVERT(DECIMAL(18,2), SUBSTRING([SOURCE].[Workout12Distance], CHARINDEX('-', [SOURCE].[Workout12Distance]) +1, 20)) ELSE CONVERT(DECIMAL(18,2), [SOURCE].[Workout12Distance]) END
			,[SOURCE].[WorkoutTrackCondition1]
			,[SOURCE].[WorkoutTrackCondition2]
			,[SOURCE].[WorkoutTrackCondition3]
			,[SOURCE].[WorkoutTrackCondition4]
			,[SOURCE].[WorkoutTrackCondition5]
			,[SOURCE].[WorkoutTrackCondition6]
			,[SOURCE].[WorkoutTrackCondition7]
			,[SOURCE].[WorkoutTrackCondition8]
			,[SOURCE].[WorkoutTrackCondition9]
			,[SOURCE].[WorkoutTrackCondition10]
			,[SOURCE].[WorkoutTrackCondition11]
			,[SOURCE].[WorkoutTrackCondition12]
			,[SOURCE].[Workout1Description]
			,[SOURCE].[Workout2Description]
			,[SOURCE].[Workout3Description]
			,[SOURCE].[Workout4Description]
			,[SOURCE].[Workout5Description]
			,[SOURCE].[Workout6Description]
			,[SOURCE].[Workout7Description]
			,[SOURCE].[Workout8Description]
			,[SOURCE].[Workout9Description]
			,[SOURCE].[Workout10Description]
			,[SOURCE].[Workout11Description]
			,[SOURCE].[Workout12Description]
			,[SOURCE].[MainInnerTrackIndicator1]
			,[SOURCE].[MainInnerTrackIndicator2]
			,[SOURCE].[MainInnerTrackIndicator3]
			,[SOURCE].[MainInnerTrackIndicator4]
			,[SOURCE].[MainInnerTrackIndicator5]
			,[SOURCE].[MainInnerTrackIndicator6]
			,[SOURCE].[MainInnerTrackIndicator7]
			,[SOURCE].[MainInnerTrackIndicator8]
			,[SOURCE].[MainInnerTrackIndicator9]
			,[SOURCE].[MainInnerTrackIndicator10]
			,[SOURCE].[MainInnerTrackIndicator11]
			,[SOURCE].[MainInnerTrackIndicator12]
			,[SOURCE].[NumberOfWorkout1]
			,[SOURCE].[NumberOfWorkout2]
			,[SOURCE].[NumberOfWorkout3]
			,[SOURCE].[NumberOfWorkout4]
			,[SOURCE].[NumberOfWorkout5]
			,[SOURCE].[NumberOfWorkout6]
			,[SOURCE].[NumberOfWorkout7]
			,[SOURCE].[NumberOfWorkout8]
			,[SOURCE].[NumberOfWorkout9]
			,[SOURCE].[NumberOfWorkout10]
			,[SOURCE].[NumberOfWorkout11]
			,[SOURCE].[NumberOfWorkout12]
			,[SOURCE].[WorkoutRank1]
			,[SOURCE].[WorkoutRank2]
			,[SOURCE].[WorkoutRank3]
			,[SOURCE].[WorkoutRank4]
			,[SOURCE].[WorkoutRank5]
			,[SOURCE].[WorkoutRank6]
			,[SOURCE].[WorkoutRank7]
			,[SOURCE].[WorkoutRank8]
			,[SOURCE].[WorkoutRank9]
			,[SOURCE].[WorkoutRank10]
			,[SOURCE].[WorkoutRank11]
			,[SOURCE].[WorkoutRank12]
			,[SOURCE].[BrisRunStyle]
			,[SOURCE].[QuirinSpeedPoints]
			,[SOURCE].[Reserved191Reserved]
			,[SOURCE].[Reserved192Reserved]
			,[SOURCE].[Bris2fPaceFig]
			,[SOURCE].[Bris4fPaceFig]
			,[SOURCE].[Bris6fPaceFig]
			,[SOURCE].[BrisSpeedFig]
			,[SOURCE].[BrisLatePace]
			,[SOURCE].[Reserved198]
			,[SOURCE].[Reserved199]
			,[SOURCE].[ProgramPostPosition]
			,[SOURCE].[ProgramNumber]
			,CASE WHEN ISNULL([SOURCE].[MorningLine], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[MorningLine])) AS decimal(18, 2)) END
			,[SOURCE].[NumOfDaySinceLastRace]
			,[SOURCE].[RaceConditionLine1]
			,[SOURCE].[RaceConditionLine2]
			,[SOURCE].[RaceConditionLine3]
			,[SOURCE].[RaceConditionLine4]
			,[SOURCE].[RaceConditionLine5]
			,[SOURCE].[RaceConditionLine6]
			,[SOURCE].[LifetimeStartsAllWeather]
			,[SOURCE].[LifetimeWinsAllWeather]
			,[SOURCE].[LifetimePlacesAllWeather]
			,[SOURCE].[LifetimeShowsAllWeather]
			,CASE WHEN ISNULL([SOURCE].[LifetimeEarningsAllWeather], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LifetimeEarningsAllWeather])) AS decimal(18, 2)) END
			,[SOURCE].[BestBRISSpeedAllWeather]
			,[SOURCE].[Reserved216]
			,CASE WHEN ISNULL([SOURCE].[LowClaimingPrice], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[LowClaimingPrice])) AS decimal(18, 2)) END
			,[SOURCE].[StatebredFlag]
			,[SOURCE].[WagerTypes219]
			,[SOURCE].[WagerTypes220]
			,[SOURCE].[WagerTypes221]
			,[SOURCE].[WagerTypes222]
			,[SOURCE].[WagerTypes223]
			,[SOURCE].[WagerTypes224]
			,[SOURCE].[WagerTypes225]
			,[SOURCE].[WagerTypes226]
			,[SOURCE].[WagerTypes227]
			,CASE WHEN ISNULL([SOURCE].[SireStudFee], '') = '' THEN 0 ELSE CAST(LTRIM(RTRIM([SOURCE].[SireStudFee])) AS decimal(18, 2)) END
			,[SOURCE].[BestBRISSpeedFastTrack]
			,[SOURCE].[BestBRISSpeedTurf]
			,[SOURCE].[BestBRISSpeedOffTrack]
			,[SOURCE].[BestBRISSpeedDistance]
			,NULL
			,[SOURCE].[Reserved234]
	FROM kelso.brisnet_dr2_staging SOURCE
	LEFT JOIN kelso.brisnet_Races R ON( R.TrackCd = [SOURCE].[TrackCd]
									   AND R.RaceDt = CAST([SOURCE].[RaceDt] AS DATETIME)
									   AND R.RaceNum = CAST([SOURCE].[RaceNum] AS INT));

	MERGE kelso.brisnet_dr2 AS [TARGET]
	USING @brisnet_dr2 AS [SOURCE]
	ON ([SOURCE].[RaceId] = [TARGET].[RaceId] 
		AND [SOURCE].[PostPosition] = [TARGET].[PostPosition]) 
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[Entry] = [SOURCE].[Entry] 
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice]
			,[TARGET].[Trainer] = [SOURCE].[Trainer] 
			,[TARGET].[TrainerStartsCurrentMeet] = [SOURCE].[TrainerStartsCurrentMeet] 
			,[TARGET].[TrainerWinCurrentMeet] = [SOURCE].[TrainerWinCurrentMeet] 
			,[TARGET].[TrainerPlacesCurrentMeet] = [SOURCE].[TrainerPlacesCurrentMeet] 
			,[TARGET].[TrainerShowCurrentMeet] = [SOURCE].[TrainerShowCurrentMeet] 
			,[TARGET].[Jockey] = [SOURCE].[Jockey] 
			,[TARGET].[ApprenticeWeight] = [SOURCE].[ApprenticeWeight] 
			,[TARGET].[JockeyStartsCurrentMeet] = [SOURCE].[JockeyStartsCurrentMeet] 
			,[TARGET].[JockeyWinsCurrentMeet] = [SOURCE].[JockeyWinsCurrentMeet] 
			,[TARGET].[JockeyPlacesCurrentMeet] = [SOURCE].[JockeyPlacesCurrentMeet] 
			,[TARGET].[JockeyShowsCurrentMeet] = [SOURCE].[JockeyShowsCurrentMeet] 
			,[TARGET].[Owner] = [SOURCE].[Owner] 
			,[TARGET].[TrainerRecordCurrentYear] = [SOURCE].[TrainerRecordCurrentYear] 
			,[TARGET].[TrainerRecordPreviousYear] = [SOURCE].[TrainerRecordPreviousYear] 
			,[TARGET].[JockeyRecordCurrentYear] = [SOURCE].[JockeyRecordCurrentYear] 
			,[TARGET].[JockeyRecordPreviousYear] = [SOURCE].[JockeyRecordPreviousYear] 
			,[TARGET].[OwnersSilks] = [SOURCE].[OwnersSilks] 
			,[TARGET].[HorseName] = [SOURCE].[HorseName] 
			,[TARGET].[YearOfBirth] = [SOURCE].[YearOfBirth] 
			,[TARGET].[HorseFoalingMonth] = [SOURCE].[HorseFoalingMonth] 
			,[TARGET].[Reserved28] = [SOURCE].[Reserved28] 
			,[TARGET].[Sex] = [SOURCE].[Sex] 
			,[TARGET].[HorseColor] = [SOURCE].[HorseColor] 
			,[TARGET].[Weight] = [SOURCE].[Weight] 
			,[TARGET].[Sire] = [SOURCE].[Sire] 
			,[TARGET].[SireSire] = [SOURCE].[SireSire] 
			,[TARGET].[Dam] = [SOURCE].[Dam] 
			,[TARGET].[DamSire] = [SOURCE].[DamSire] 
			,[TARGET].[Breeder] = [SOURCE].[Breeder] 
			,[TARGET].[StateCountry] = [SOURCE].[StateCountry] 
			,[TARGET].[AuctionPrice] = [SOURCE].[AuctionPrice] 
			,[TARGET].[InfoSoldAtAuction] = [SOURCE].[InfoSoldAtAuction] 
			,[TARGET].[Reserved40] = [SOURCE].[Reserved40] 
			,[TARGET].[AEIndicator] = [SOURCE].[AEIndicator] 
			,[TARGET].[Medication1stLasixInfo] = [SOURCE].[Medication1stLasixInfo] 
			,[TARGET].[Medication1stWithOutLasixInfo] = [SOURCE].[Medication1stWithOutLasixInfo] 
			,[TARGET].[EquipmentChange] = [SOURCE].[EquipmentChange] 
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
			,[TARGET].[Workout1Date] = [SOURCE].[Workout1Date] 
			,[TARGET].[Workout2Date] = [SOURCE].[Workout2Date] 
			,[TARGET].[Workout3Date] = [SOURCE].[Workout3Date] 
			,[TARGET].[Workout4Date] = [SOURCE].[Workout4Date] 
			,[TARGET].[Workout5Date] = [SOURCE].[Workout5Date] 
			,[TARGET].[Workout6Date] = [SOURCE].[Workout6Date] 
			,[TARGET].[Workout7Date] = [SOURCE].[Workout7Date] 
			,[TARGET].[Workout8Date] = [SOURCE].[Workout8Date] 
			,[TARGET].[Workout9Date] = [SOURCE].[Workout9Date] 
			,[TARGET].[Workout10Date] = [SOURCE].[Workout10Date] 
			,[TARGET].[Workout11Date] = [SOURCE].[Workout11Date] 
			,[TARGET].[Workout12Date] = [SOURCE].[Workout12Date] 
			,[TARGET].[Workout1Time] = [SOURCE].[Workout1Time] 
			,[TARGET].[Workout2Time] = [SOURCE].[Workout2Time]
			,[TARGET].[Workout3Time] = [SOURCE].[Workout3Time]
			,[TARGET].[Workout4Time] = [SOURCE].[Workout4Time]
			,[TARGET].[Workout5Time] = [SOURCE].[Workout5Time]
			,[TARGET].[Workout6Time] = [SOURCE].[Workout6Time]
			,[TARGET].[Workout7Time] = [SOURCE].[Workout7Time]
			,[TARGET].[Workout8Time] = [SOURCE].[Workout8Time]
			,[TARGET].[Workout9Time] = [SOURCE].[Workout9Time]
			,[TARGET].[Workout10Time] = [SOURCE].[Workout10Time]
			,[TARGET].[Workout11Time] = [SOURCE].[Workout11Time]
			,[TARGET].[Workout12Time] = [SOURCE].[Workout12Time]
			,[TARGET].[Workout1Track] = [SOURCE].[Workout1Track]
			,[TARGET].[Workout2Track] = [SOURCE].[Workout2Track] 
			,[TARGET].[Workout3Track] = [SOURCE].[Workout3Track]
			,[TARGET].[Workout4Track] = [SOURCE].[Workout4Track]
			,[TARGET].[Workout5Track] = [SOURCE].[Workout5Track]
			,[TARGET].[Workout6Track] = [SOURCE].[Workout6Track] 
			,[TARGET].[Workout7Track] = [SOURCE].[Workout7Track]
			,[TARGET].[Workout8Track] = [SOURCE].[Workout8Track]
			,[TARGET].[Workout9Track] = [SOURCE].[Workout9Track]
			,[TARGET].[Workout10Track] = [SOURCE].[Workout10Track] 
			,[TARGET].[Workout11Track] = [SOURCE].[Workout11Track]
			,[TARGET].[Workout12Track] = [SOURCE].[Workout12Track] 
			,[TARGET].[Workout1Distance] = [SOURCE].[Workout1Distance]
			,[TARGET].[Workout2Distance] = [SOURCE].[Workout2Distance]
			,[TARGET].[Workout3Distance] = [SOURCE].[Workout3Distance]
			,[TARGET].[Workout4Distance] = [SOURCE].[Workout4Distance]
			,[TARGET].[Workout5Distance] = [SOURCE].[Workout5Distance]
			,[TARGET].[Workout6Distance] = [SOURCE].[Workout6Distance]
			,[TARGET].[Workout7Distance] = [SOURCE].[Workout7Distance]
			,[TARGET].[Workout8Distance] = [SOURCE].[Workout8Distance]
			,[TARGET].[Workout9Distance] = [SOURCE].[Workout9Distance]
			,[TARGET].[Workout10Distance] = [SOURCE].[Workout10Distance]
			,[TARGET].[Workout11Distance] = [SOURCE].[Workout11Distance]
			,[TARGET].[Workout12Distance] = [SOURCE].[Workout12Distance]
			,[TARGET].[WorkoutTrackCondition1] = [SOURCE].[WorkoutTrackCondition1] 
			,[TARGET].[WorkoutTrackCondition2] = [SOURCE].[WorkoutTrackCondition2] 
			,[TARGET].[WorkoutTrackCondition3] = [SOURCE].[WorkoutTrackCondition3] 
			,[TARGET].[WorkoutTrackCondition4] = [SOURCE].[WorkoutTrackCondition4] 
			,[TARGET].[WorkoutTrackCondition5] = [SOURCE].[WorkoutTrackCondition5] 
			,[TARGET].[WorkoutTrackCondition6] = [SOURCE].[WorkoutTrackCondition6] 
			,[TARGET].[WorkoutTrackCondition7] = [SOURCE].[WorkoutTrackCondition7] 
			,[TARGET].[WorkoutTrackCondition8] = [SOURCE].[WorkoutTrackCondition8] 
			,[TARGET].[WorkoutTrackCondition9] = [SOURCE].[WorkoutTrackCondition9] 
			,[TARGET].[WorkoutTrackCondition10] = [SOURCE].[WorkoutTrackCondition10] 
			,[TARGET].[WorkoutTrackCondition11] = [SOURCE].[WorkoutTrackCondition11] 
			,[TARGET].[WorkoutTrackCondition12] = [SOURCE].[WorkoutTrackCondition12] 
			,[TARGET].[Workout1Description] = [SOURCE].[Workout1Description] 
			,[TARGET].[Workout2Description] = [SOURCE].[Workout2Description] 
			,[TARGET].[Workout3Description] = [SOURCE].[Workout3Description] 
			,[TARGET].[Workout4Description] = [SOURCE].[Workout4Description] 
			,[TARGET].[Workout5Description] = [SOURCE].[Workout5Description] 
			,[TARGET].[Workout6Description] = [SOURCE].[Workout6Description] 
			,[TARGET].[Workout7Description] = [SOURCE].[Workout7Description] 
			,[TARGET].[Workout8Description] = [SOURCE].[Workout8Description] 
			,[TARGET].[Workout9Description] = [SOURCE].[Workout9Description] 
			,[TARGET].[Workout10Description] = [SOURCE].[Workout10Description] 
			,[TARGET].[Workout11Description] = [SOURCE].[Workout11Description] 
			,[TARGET].[Workout12Description] = [SOURCE].[Workout12Description] 
			,[TARGET].[MainInnerTrackIndicator1] = [SOURCE].[MainInnerTrackIndicator1] 
			,[TARGET].[MainInnerTrackIndicator2] = [SOURCE].[MainInnerTrackIndicator2] 
			,[TARGET].[MainInnerTrackIndicator3] = [SOURCE].[MainInnerTrackIndicator3] 
			,[TARGET].[MainInnerTrackIndicator4] = [SOURCE].[MainInnerTrackIndicator4] 
			,[TARGET].[MainInnerTrackIndicator5] = [SOURCE].[MainInnerTrackIndicator5] 
			,[TARGET].[MainInnerTrackIndicator6] = [SOURCE].[MainInnerTrackIndicator6] 
			,[TARGET].[MainInnerTrackIndicator7] = [SOURCE].[MainInnerTrackIndicator7] 
			,[TARGET].[MainInnerTrackIndicator8] = [SOURCE].[MainInnerTrackIndicator8] 
			,[TARGET].[MainInnerTrackIndicator9] = [SOURCE].[MainInnerTrackIndicator9] 
			,[TARGET].[MainInnerTrackIndicator10] = [SOURCE].[MainInnerTrackIndicator10] 
			,[TARGET].[MainInnerTrackIndicator11] = [SOURCE].[MainInnerTrackIndicator11] 
			,[TARGET].[MainInnerTrackIndicator12] = [SOURCE].[MainInnerTrackIndicator12] 
			,[TARGET].[NumberOfWorkout1] = [SOURCE].[NumberOfWorkout1] 
			,[TARGET].[NumberOfWorkout2] = [SOURCE].[NumberOfWorkout2] 
			,[TARGET].[NumberOfWorkout3] = [SOURCE].[NumberOfWorkout3] 
			,[TARGET].[NumberOfWorkout4] = [SOURCE].[NumberOfWorkout4] 
			,[TARGET].[NumberOfWorkout5] = [SOURCE].[NumberOfWorkout5] 
			,[TARGET].[NumberOfWorkout6] = [SOURCE].[NumberOfWorkout6] 
			,[TARGET].[NumberOfWorkout7] = [SOURCE].[NumberOfWorkout7] 
			,[TARGET].[NumberOfWorkout8] = [SOURCE].[NumberOfWorkout8] 
			,[TARGET].[NumberOfWorkout9] = [SOURCE].[NumberOfWorkout9] 
			,[TARGET].[NumberOfWorkout10] = [SOURCE].[NumberOfWorkout10] 
			,[TARGET].[NumberOfWorkout11] = [SOURCE].[NumberOfWorkout11] 
			,[TARGET].[NumberOfWorkout12] = [SOURCE].[NumberOfWorkout12] 
			,[TARGET].[WorkoutRank1] = [SOURCE].[WorkoutRank1] 
			,[TARGET].[WorkoutRank2] = [SOURCE].[WorkoutRank2] 
			,[TARGET].[WorkoutRank3] = [SOURCE].[WorkoutRank3] 
			,[TARGET].[WorkoutRank4] = [SOURCE].[WorkoutRank4] 
			,[TARGET].[WorkoutRank5] = [SOURCE].[WorkoutRank5] 
			,[TARGET].[WorkoutRank6] = [SOURCE].[WorkoutRank6] 
			,[TARGET].[WorkoutRank7] = [SOURCE].[WorkoutRank7] 
			,[TARGET].[WorkoutRank8] = [SOURCE].[WorkoutRank8] 
			,[TARGET].[WorkoutRank9] = [SOURCE].[WorkoutRank9] 
			,[TARGET].[WorkoutRank10] = [SOURCE].[WorkoutRank10] 
			,[TARGET].[WorkoutRank11] = [SOURCE].[WorkoutRank11] 
			,[TARGET].[WorkoutRank12] = [SOURCE].[WorkoutRank12] 
			,[TARGET].[BrisRunStyle] = [SOURCE].[BrisRunStyle] 
			,[TARGET].[QuirinSpeedPoints] = [SOURCE].[QuirinSpeedPoints] 
			,[TARGET].[Reserved191Reserved] = [SOURCE].[Reserved191Reserved] 
			,[TARGET].[Reserved192Reserved] = [SOURCE].[Reserved192Reserved] 
			,[TARGET].[Bris2fPaceFig] = [SOURCE].[Bris2fPaceFig] 
			,[TARGET].[Bris4fPaceFig] = [SOURCE].[Bris4fPaceFig] 
			,[TARGET].[Bris6fPaceFig] = [SOURCE].[Bris6fPaceFig] 
			,[TARGET].[BrisSpeedFig] = [SOURCE].[BrisSpeedFig] 
			,[TARGET].[BrisLatePace] = [SOURCE].[BrisLatePace] 
			,[TARGET].[Reserved198] = [SOURCE].[Reserved198] 
			,[TARGET].[Reserved199] = [SOURCE].[Reserved199] 
			,[TARGET].[ProgramPostPosition] = [SOURCE].[ProgramPostPosition] 
			,[TARGET].[ProgramNumber] = [SOURCE].[ProgramNumber] 
			,[TARGET].[MorningLine] = [SOURCE].[MorningLine] 
			,[TARGET].[NumOfDaySinceLastRace] = [SOURCE].[NumOfDaySinceLastRace] 
			,[TARGET].[RaceConditionLine1] = [SOURCE].[RaceConditionLine1] 
			,[TARGET].[RaceConditionLine2] = [SOURCE].[RaceConditionLine2] 
			,[TARGET].[RaceConditionLine3] = [SOURCE].[RaceConditionLine3] 
			,[TARGET].[RaceConditionLine4] = [SOURCE].[RaceConditionLine4] 
			,[TARGET].[RaceConditionLine5] = [SOURCE].[RaceConditionLine5] 
			,[TARGET].[RaceConditionLine6] = [SOURCE].[RaceConditionLine6] 
			,[TARGET].[LifetimeStartsAllWeather] = [SOURCE].[LifetimeStartsAllWeather] 
			,[TARGET].[LifetimeWinsAllWeather] = [SOURCE].[LifetimeWinsAllWeather] 
			,[TARGET].[LifetimePlacesAllWeather] = [SOURCE].[LifetimePlacesAllWeather] 
			,[TARGET].[LifetimeShowsAllWeather] = [SOURCE].[LifetimeShowsAllWeather] 
			,[TARGET].[LifetimeEarningsAllWeather] = [SOURCE].[LifetimeEarningsAllWeather] 
			,[TARGET].[BestBRISSpeedAllWeather] = [SOURCE].[BestBRISSpeedAllWeather] 
			,[TARGET].[Reserved216] = [SOURCE].[Reserved216] 
			,[TARGET].[LowClaimingPrice] = [SOURCE].[LowClaimingPrice] 
			,[TARGET].[StatebredFlag] = [SOURCE].[StatebredFlag] 
			,[TARGET].[WagerTypes219] = [SOURCE].[WagerTypes219] 
			,[TARGET].[WagerTypes220] = [SOURCE].[WagerTypes220] 
			,[TARGET].[WagerTypes221] = [SOURCE].[WagerTypes221] 
			,[TARGET].[WagerTypes222] = [SOURCE].[WagerTypes222] 
			,[TARGET].[WagerTypes223] = [SOURCE].[WagerTypes223] 
			,[TARGET].[WagerTypes224] = [SOURCE].[WagerTypes224] 
			,[TARGET].[WagerTypes225] = [SOURCE].[WagerTypes225] 
			,[TARGET].[WagerTypes226] = [SOURCE].[WagerTypes226] 
			,[TARGET].[WagerTypes227] = [SOURCE].[WagerTypes227] 
			,[TARGET].[SireStudFee] = [SOURCE].[SireStudFee]
			,[TARGET].[BestBRISSpeedFastTrack] = [SOURCE].[BestBRISSpeedFastTrack] 
			,[TARGET].[BestBRISSpeedTurf] = [SOURCE].[BestBRISSpeedTurf] 
			,[TARGET].[BestBRISSpeedOffTrack] = [SOURCE].[BestBRISSpeedOffTrack] 
			,[TARGET].[BestBRISSpeedDistance] = [SOURCE].[BestBRISSpeedDistance] 
			,[TARGET].[Reserved233] = NULL 
			,[TARGET].[Reserved234] = [SOURCE].[Reserved234] 
	WHEN NOT MATCHED 
	THEN INSERT ([RaceId]
				,[CreatedDt] 
				,[ModifiedDt]
				,[TrackCd]
				,[RaceDt] 
				,[RaceNum]
				,[PostPosition] 
				,[Entry] 
				,[ClaimingPrice] 
				,[Trainer] 
				,[TrainerStartsCurrentMeet] 
				,[TrainerWinCurrentMeet] 
				,[TrainerPlacesCurrentMeet] 
				,[TrainerShowCurrentMeet] 
				,[Jockey] 
				,[ApprenticeWeight] 
				,[JockeyStartsCurrentMeet] 
				,[JockeyWinsCurrentMeet] 
				,[JockeyPlacesCurrentMeet] 
				,[JockeyShowsCurrentMeet] 
				,[Owner] 
				,[TrainerRecordCurrentYear] 
				,[TrainerRecordPreviousYear] 
				,[JockeyRecordCurrentYear] 
				,[JockeyRecordPreviousYear] 
				,[OwnersSilks] 
				,[HorseName] 
				,[YearOfBirth] 
				,[HorseFoalingMonth] 
				,[Reserved28] 
				,[Sex] 
				,[HorseColor] 
				,[Weight] 
				,[Sire] 
				,[SireSire] 
				,[Dam] 
				,[DamSire] 
				,[Breeder] 
				,[StateCountry] 
				,[AuctionPrice] 
				,[InfoSoldAtAuction] 
				,[Reserved40] 
				,[AEIndicator] 
				,[Medication1stLasixInfo] 
				,[Medication1stWithOutLasixInfo] 
				,[EquipmentChange] 
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
				,[Workout1Date] 
				,[Workout2Date] 
				,[Workout3Date] 
				,[Workout4Date] 
				,[Workout5Date] 
				,[Workout6Date] 
				,[Workout7Date] 
				,[Workout8Date] 
				,[Workout9Date] 
				,[Workout10Date] 
				,[Workout11Date] 
				,[Workout12Date] 
				,[Workout1Time] 
				,[Workout2Time] 
				,[Workout3Time] 
				,[Workout4Time] 
				,[Workout5Time] 
				,[Workout6Time] 
				,[Workout7Time] 
				,[Workout8Time] 
				,[Workout9Time] 
				,[Workout10Time] 
				,[Workout11Time] 
				,[Workout12Time]
				,[Workout1Track] 
				,[Workout2Track] 
				,[Workout3Track] 
				,[Workout4Track] 
				,[Workout5Track] 
				,[Workout6Track] 
				,[Workout7Track] 
				,[Workout8Track] 
				,[Workout9Track] 
				,[Workout10Track] 
				,[Workout11Track] 
				,[Workout12Track] 
				,[Workout1Distance] 
				,[Workout2Distance] 
				,[Workout3Distance] 
				,[Workout4Distance] 
				,[Workout5Distance] 
				,[Workout6Distance] 
				,[Workout7Distance] 
				,[Workout8Distance] 
				,[Workout9Distance] 
				,[Workout10Distance] 
				,[Workout11Distance] 
				,[Workout12Distance]
				,[WorkoutTrackCondition1] 
				,[WorkoutTrackCondition2] 
				,[WorkoutTrackCondition3] 
				,[WorkoutTrackCondition4] 
				,[WorkoutTrackCondition5] 
				,[WorkoutTrackCondition6] 
				,[WorkoutTrackCondition7] 
				,[WorkoutTrackCondition8] 
				,[WorkoutTrackCondition9] 
				,[WorkoutTrackCondition10] 
				,[WorkoutTrackCondition11] 
				,[WorkoutTrackCondition12] 
				,[Workout1Description] 
				,[Workout2Description] 
				,[Workout3Description] 
				,[Workout4Description] 
				,[Workout5Description] 
				,[Workout6Description] 
				,[Workout7Description] 
				,[Workout8Description] 
				,[Workout9Description] 
				,[Workout10Description] 
				,[Workout11Description] 
				,[Workout12Description] 
				,[MainInnerTrackIndicator1] 
				,[MainInnerTrackIndicator2] 
				,[MainInnerTrackIndicator3] 
				,[MainInnerTrackIndicator4] 
				,[MainInnerTrackIndicator5] 
				,[MainInnerTrackIndicator6] 
				,[MainInnerTrackIndicator7] 
				,[MainInnerTrackIndicator8] 
				,[MainInnerTrackIndicator9] 
				,[MainInnerTrackIndicator10] 
				,[MainInnerTrackIndicator11] 
				,[MainInnerTrackIndicator12] 
				,[NumberOfWorkout1] 
				,[NumberOfWorkout2] 
				,[NumberOfWorkout3] 
				,[NumberOfWorkout4] 
				,[NumberOfWorkout5] 
				,[NumberOfWorkout6] 
				,[NumberOfWorkout7] 
				,[NumberOfWorkout8] 
				,[NumberOfWorkout9] 
				,[NumberOfWorkout10] 
				,[NumberOfWorkout11] 
				,[NumberOfWorkout12] 
				,[WorkoutRank1] 
				,[WorkoutRank2] 
				,[WorkoutRank3] 
				,[WorkoutRank4] 
				,[WorkoutRank5] 
				,[WorkoutRank6] 
				,[WorkoutRank7] 
				,[WorkoutRank8] 
				,[WorkoutRank9] 
				,[WorkoutRank10] 
				,[WorkoutRank11] 
				,[WorkoutRank12] 
				,[BrisRunStyle] 
				,[QuirinSpeedPoints] 
				,[Reserved191Reserved] 
				,[Reserved192Reserved] 
				,[Bris2fPaceFig] 
				,[Bris4fPaceFig] 
				,[Bris6fPaceFig] 
				,[BrisSpeedFig] 
				,[BrisLatePace] 
				,[Reserved198] 
				,[Reserved199] 
				,[ProgramPostPosition] 
				,[ProgramNumber]
				,[MorningLine] 
				,[NumOfDaySinceLastRace] 
				,[RaceConditionLine1] 
				,[RaceConditionLine2] 
				,[RaceConditionLine3] 
				,[RaceConditionLine4] 
				,[RaceConditionLine5] 
				,[RaceConditionLine6] 
				,[LifetimeStartsAllWeather] 
				,[LifetimeWinsAllWeather] 
				,[LifetimePlacesAllWeather] 
				,[LifetimeShowsAllWeather] 
				,[LifetimeEarningsAllWeather] 
				,[BestBRISSpeedAllWeather] 
				,[Reserved216] 
				,[LowClaimingPrice] 
				,[StatebredFlag] 
				,[WagerTypes219] 
				,[WagerTypes220] 
				,[WagerTypes221] 
				,[WagerTypes222] 
				,[WagerTypes223] 
				,[WagerTypes224] 
				,[WagerTypes225] 
				,[WagerTypes226] 
				,[WagerTypes227] 
				,[SireStudFee] 
				,[BestBRISSpeedFastTrack] 
				,[BestBRISSpeedTurf] 
				,[BestBRISSpeedOffTrack] 
				,[BestBRISSpeedDistance] 
				,[Reserved233] 
				,[Reserved234] ) 
    VALUES ([SOURCE].[RaceId]
			 ,GETDATE()
			 ,GETDATE()
			 ,[SOURCE].[TrackCd]
			 ,[SOURCE].[RaceDt]
			 ,[SOURCE].[RaceNum]
			 ,[SOURCE].[PostPosition]
			 ,[SOURCE].[Entry]
			 ,[SOURCE].[ClaimingPrice]
			 ,[SOURCE].[Trainer]
			 ,[SOURCE].[TrainerStartsCurrentMeet]
			 ,[SOURCE].[TrainerWinCurrentMeet]
			 ,[SOURCE].[TrainerPlacesCurrentMeet]
			 ,[SOURCE].[TrainerShowCurrentMeet]
			 ,[SOURCE].[Jockey]
			 ,[SOURCE].[ApprenticeWeight]
			 ,[SOURCE].[JockeyStartsCurrentMeet]
			 ,[SOURCE].[JockeyWinsCurrentMeet]
			 ,[SOURCE].[JockeyPlacesCurrentMeet]
			 ,[SOURCE].[JockeyShowsCurrentMeet]
			 ,[SOURCE].[Owner]
			 ,[SOURCE].[TrainerRecordCurrentYear]
			 ,[SOURCE].[TrainerRecordPreviousYear]
			 ,[SOURCE].[JockeyRecordCurrentYear]
			 ,[SOURCE].[JockeyRecordPreviousYear]
			 ,[SOURCE].[OwnersSilks]
			 ,[SOURCE].[HorseName]
			 ,[SOURCE].[YearOfBirth]
			 ,[SOURCE].[HorseFoalingMonth]
			 ,[SOURCE].[Reserved28]
			 ,[SOURCE].[Sex]
			 ,[SOURCE].[HorseColor]
			 ,[SOURCE].[Weight]
			 ,[SOURCE].[Sire]
			 ,[SOURCE].[SireSire]
			 ,[SOURCE].[Dam]
			 ,[SOURCE].[DamSire]
			 ,[SOURCE].[Breeder]
			 ,[SOURCE].[StateCountry]
			 ,[SOURCE].[AuctionPrice]
			 ,[SOURCE].[InfoSoldAtAuction]
			 ,[SOURCE].[Reserved40]
			 ,[SOURCE].[AEIndicator]
			 ,[SOURCE].[Medication1stLasixInfo]
			 ,[SOURCE].[Medication1stWithOutLasixInfo]
			 ,[SOURCE].[EquipmentChange]
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
			 ,[SOURCE].[Workout1Date]
			 ,[SOURCE].[Workout2Date]
			 ,[SOURCE].[Workout3Date]
			 ,[SOURCE].[Workout4Date]
			 ,[SOURCE].[Workout5Date]
			 ,[SOURCE].[Workout6Date]
			 ,[SOURCE].[Workout7Date]
			 ,[SOURCE].[Workout8Date]
			 ,[SOURCE].[Workout9Date]
			 ,[SOURCE].[Workout10Date]
			 ,[SOURCE].[Workout11Date]
			 ,[SOURCE].[Workout12Date]
			 ,[SOURCE].[Workout1Time]
			 ,[SOURCE].[Workout2Time]
			 ,[SOURCE].[Workout3Time]
			 ,[SOURCE].[Workout4Time]
			 ,[SOURCE].[Workout5Time]
			 ,[SOURCE].[Workout6Time]
			 ,[SOURCE].[Workout7Time]
			 ,[SOURCE].[Workout8Time]
			 ,[SOURCE].[Workout9Time]
			 ,[SOURCE].[Workout10Time]
			 ,[SOURCE].[Workout11Time]
			 ,[SOURCE].[Workout12Time]
			 ,[SOURCE].[Workout1Track]
			 ,[SOURCE].[Workout2Track]
			 ,[SOURCE].[Workout3Track]
			 ,[SOURCE].[Workout4Track]
			 ,[SOURCE].[Workout5Track]
			 ,[SOURCE].[Workout6Track]
			 ,[SOURCE].[Workout7Track]
			 ,[SOURCE].[Workout8Track]
			 ,[SOURCE].[Workout9Track]
			 ,[SOURCE].[Workout10Track]
			 ,[SOURCE].[Workout11Track]
			 ,[SOURCE].[Workout12Track]
			 ,[SOURCE].[Workout1Distance]
			 ,[SOURCE].[Workout2Distance]
			 ,[SOURCE].[Workout3Distance]
			 ,[SOURCE].[Workout4Distance]
			 ,[SOURCE].[Workout5Distance]
			 ,[SOURCE].[Workout6Distance]
			 ,[SOURCE].[Workout7Distance]
			 ,[SOURCE].[Workout8Distance]
			 ,[SOURCE].[Workout9Distance]
			 ,[SOURCE].[Workout10Distance]
			 ,[SOURCE].[Workout11Distance]
			 ,[SOURCE].[Workout12Distance]
			 ,[SOURCE].[WorkoutTrackCondition1]
			 ,[SOURCE].[WorkoutTrackCondition2]
			 ,[SOURCE].[WorkoutTrackCondition3]
			 ,[SOURCE].[WorkoutTrackCondition4]
			 ,[SOURCE].[WorkoutTrackCondition5]
			 ,[SOURCE].[WorkoutTrackCondition6]
			 ,[SOURCE].[WorkoutTrackCondition7]
			 ,[SOURCE].[WorkoutTrackCondition8]
			 ,[SOURCE].[WorkoutTrackCondition9]
			 ,[SOURCE].[WorkoutTrackCondition10]
			 ,[SOURCE].[WorkoutTrackCondition11]
			 ,[SOURCE].[WorkoutTrackCondition12]
			 ,[SOURCE].[Workout1Description]
			 ,[SOURCE].[Workout2Description]
			 ,[SOURCE].[Workout3Description]
			 ,[SOURCE].[Workout4Description]
			 ,[SOURCE].[Workout5Description]
			 ,[SOURCE].[Workout6Description]
			 ,[SOURCE].[Workout7Description]
			 ,[SOURCE].[Workout8Description]
			 ,[SOURCE].[Workout9Description]
			 ,[SOURCE].[Workout10Description]
			 ,[SOURCE].[Workout11Description]
			 ,[SOURCE].[Workout12Description]
			 ,[SOURCE].[MainInnerTrackIndicator1]
			 ,[SOURCE].[MainInnerTrackIndicator2]
			 ,[SOURCE].[MainInnerTrackIndicator3]
			 ,[SOURCE].[MainInnerTrackIndicator4]
			 ,[SOURCE].[MainInnerTrackIndicator5]
			 ,[SOURCE].[MainInnerTrackIndicator6]
			 ,[SOURCE].[MainInnerTrackIndicator7]
			 ,[SOURCE].[MainInnerTrackIndicator8]
			 ,[SOURCE].[MainInnerTrackIndicator9]
			 ,[SOURCE].[MainInnerTrackIndicator10]
			 ,[SOURCE].[MainInnerTrackIndicator11]
			 ,[SOURCE].[MainInnerTrackIndicator12]
			 ,[SOURCE].[NumberOfWorkout1]
			 ,[SOURCE].[NumberOfWorkout2]
			 ,[SOURCE].[NumberOfWorkout3]
			 ,[SOURCE].[NumberOfWorkout4]
			 ,[SOURCE].[NumberOfWorkout5]
			 ,[SOURCE].[NumberOfWorkout6]
			 ,[SOURCE].[NumberOfWorkout7]
			 ,[SOURCE].[NumberOfWorkout8]
			 ,[SOURCE].[NumberOfWorkout9]
			 ,[SOURCE].[NumberOfWorkout10]
			 ,[SOURCE].[NumberOfWorkout11]
			 ,[SOURCE].[NumberOfWorkout12]
			 ,[SOURCE].[WorkoutRank1]
			 ,[SOURCE].[WorkoutRank2]
			 ,[SOURCE].[WorkoutRank3]
			 ,[SOURCE].[WorkoutRank4]
			 ,[SOURCE].[WorkoutRank5]
			 ,[SOURCE].[WorkoutRank6]
			 ,[SOURCE].[WorkoutRank7]
			 ,[SOURCE].[WorkoutRank8]
			 ,[SOURCE].[WorkoutRank9]
			 ,[SOURCE].[WorkoutRank10]
			 ,[SOURCE].[WorkoutRank11]
			 ,[SOURCE].[WorkoutRank12]
			 ,[SOURCE].[BrisRunStyle]
			 ,[SOURCE].[QuirinSpeedPoints]
			 ,[SOURCE].[Reserved191Reserved]
			 ,[SOURCE].[Reserved192Reserved]
			 ,[SOURCE].[Bris2fPaceFig]
			 ,[SOURCE].[Bris4fPaceFig]
			 ,[SOURCE].[Bris6fPaceFig]
			 ,[SOURCE].[BrisSpeedFig]
			 ,[SOURCE].[BrisLatePace]
			 ,[SOURCE].[Reserved198]
			 ,[SOURCE].[Reserved199]
			 ,[SOURCE].[ProgramPostPosition]
			 ,[SOURCE].[ProgramNumber]
			 ,[SOURCE].[MorningLine]
			 ,[SOURCE].[NumOfDaySinceLastRace]
			 ,[SOURCE].[RaceConditionLine1]
			 ,[SOURCE].[RaceConditionLine2]
			 ,[SOURCE].[RaceConditionLine3]
			 ,[SOURCE].[RaceConditionLine4]
			 ,[SOURCE].[RaceConditionLine5]
			 ,[SOURCE].[RaceConditionLine6]
			 ,[SOURCE].[LifetimeStartsAllWeather]
			 ,[SOURCE].[LifetimeWinsAllWeather]
			 ,[SOURCE].[LifetimePlacesAllWeather]
			 ,[SOURCE].[LifetimeShowsAllWeather]
			 ,[SOURCE].[LifetimeEarningsAllWeather]
			 ,[SOURCE].[BestBRISSpeedAllWeather]
			 ,[SOURCE].[Reserved216]
			 ,[SOURCE].[LowClaimingPrice]
			 ,[SOURCE].[StatebredFlag]
			 ,[SOURCE].[WagerTypes219]
			 ,[SOURCE].[WagerTypes220]
			 ,[SOURCE].[WagerTypes221]
			 ,[SOURCE].[WagerTypes222]
			 ,[SOURCE].[WagerTypes223]
			 ,[SOURCE].[WagerTypes224]
			 ,[SOURCE].[WagerTypes225]
			 ,[SOURCE].[WagerTypes226]
			 ,[SOURCE].[WagerTypes227]
			 ,[SOURCE].[SireStudFee]
			 ,[SOURCE].[BestBRISSpeedFastTrack]
			 ,[SOURCE].[BestBRISSpeedTurf]
			 ,[SOURCE].[BestBRISSpeedOffTrack]
			 ,[SOURCE].[BestBRISSpeedDistance]
			 ,[SOURCE].[Reserved233]
			 ,[SOURCE].[Reserved234]);
END

GO
