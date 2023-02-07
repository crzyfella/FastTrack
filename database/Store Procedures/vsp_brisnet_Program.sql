IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_Program]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
  DROP PROCEDURE [kelso].[vsp_brisnet_Program];
END
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_Program]
(
	@TrackName VARCHAR(100),
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @perLength DECIMAL (18,2) = 0.20;
	DECLARE @TrackCd VARCHAR(25) = (SELECT TrackCd FROM kelso.brisnet_Tracks WHERE TrackName = @TrackName);

	DECLARE @Races TABLE
	( 
		RaceDt VARCHAR(50),
		TrackCd VARCHAR(25),
		TrackName VARCHAR(50),
		RaceNum INT,
		Distance DECIMAL(18, 2),
		Furlong DECIMAL(10, 2),
		Surface VARCHAR(10),
		RaceType VARCHAR(100),
		RaceCondition VARCHAR(MAX)
	);

	DECLARE @Horses TABLE
	(
		Id INT,
		HorseName VARCHAR(100)
	);

	DECLARE @Program TABLE
	(
		RaceNum INT,
		Race NVARCHAR(MAX)
	);

	DECLARE @dr2 TABLE 
	(
		[Id] [int] NOT NULL,
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[PostPosition] [varchar](5) NULL,
		[Entry] [varchar](5) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
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
		[LifeTimeRecordTodayDistanceEarning] [decimal](18, 2) NULL,
		[LifeTimeRecordTodayTrackStarts] [int] NULL,
		[LifeTimeRecordTodayTrackWins] [int] NULL,
		[LifeTimeRecordTodayTrackPlaces] [int] NULL,
		[LifeTimeRecordTodayTrackShows] [int] NULL,
		[LifeTimeRecordTodayTrackEarning] [decimal](18, 2) NULL,
		[LifeTimeTurfRecordStarts] [int] NULL,
		[LifeTimeTurfRecordWins] [int] NULL,
		[LifeTimeTurfRecordPlaces] [int] NULL,
		[LifeTimeTurfRecordShows] [int] NULL,
		[LifeTimeTurfRecordEarning] [decimal](18, 2) NULL,
		[LifeTimeWetRecordStarts] [int] NULL,
		[LifeTimeWetRecordWins] [int] NULL,
		[LifeTimeWetRecordPlaces] [int] NULL,
		[LifeTimeWetRecordShows] [int] NULL,
		[LifeTimeWetRecordEarning] [decimal](18, 2) NULL,
		[CurrentRecordYear] [int] NULL,
		[CurrentRecordStarts] [int] NULL,
		[CurrentRecordWins] [int] NULL,
		[CurrentRecordPlaces] [int] NULL,
		[CurrentRecordShows] [int] NULL,
		[CurrentRecordEarning] [decimal](18, 2) NULL,
		[PreviousRecordYear] [int] NULL,
		[PreviousRecordStarts] [int] NULL,
		[PreviousRecordWins] [int] NULL,
		[PreviousRecordPlaces] [int] NULL,
		[PreviousRecordShows] [int] NULL,
		[PreviousRecordEarning] [decimal](18, 2) NULL,
		[LifetimeRecordStarts] [int] NULL,
		[LifetimeRecordWins] [int] NULL,
		[LifetimeRecordPlaces] [int] NULL,
		[LifetimeRecordShows] [int] NULL,
		[LifetimeRecordEarning] [decimal](18, 2) NULL,
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
		[Workout1Distance] [decimal](18, 2) NULL,
		[Workout2Distance] [decimal](18, 2) NULL,
		[Workout3Distance] [decimal](18, 2) NULL,
		[Workout4Distance] [decimal](18, 2) NULL,
		[Workout5Distance] [decimal](18, 2) NULL,
		[Workout6Distance] [decimal](18, 2) NULL,
		[Workout7Distance] [decimal](18, 2) NULL,
		[Workout8Distance] [decimal](18, 2) NULL,
		[Workout9Distance] [decimal](18, 2) NULL,
		[Workout10Distance] [decimal](18, 2) NULL,
		[Workout11Distance] [decimal](18, 2) NULL,
		[Workout12Distance] [decimal](18, 2) NULL,
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
		[LifetimeEarningsAllWeather] [decimal](18, 2) NULL,
		[BestBRISSpeedAllWeather] [int] NULL,
		[Reserved216] [varchar](50) NULL,
		[LowClaimingPrice] [decimal](18, 2) NULL,
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
		[SireStudFee] [decimal](18, 2) NULL,
		[BestBRISSpeedFastTrack] [int] NULL,
		[BestBRISSpeedTurf] [int] NULL,
		[BestBRISSpeedOffTrack] [int] NULL,
		[BestBRISSpeedDistance] [int] NULL,
		[Reserved233] [varchar](250) NULL,
		[Reserved234] [varchar](250) NULL
	);

	DECLARE @dr3 TABLE
	(
		[Id] [int] NOT NULL,
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](75) NULL,
		[PostPosition] [int] NULL,
		[PreviousRaceDate] [datetime] NULL,
		[NumOfDaysSincePreviousRace] [int] NULL,
		[PreviousTrackName] [varchar](30) NULL,
		[PreviousTrackCd] [varchar](3) NULL,
		[PreviousRaceNum] [int] NULL,
		[TrackCondition] [varchar](2) NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[SpecialChuteIndicator] [char](1) NULL,
		[NumOfEntrants] [int] NULL,
		[PreviousPostPosition] [int] NULL,
		[Equipment] [char](1) NULL,
		[Reserved18] [varchar](50) NULL,
		[Medication] [int] NULL,
		[TripComment] [varchar](100) NULL,
		[WinnerName] [varchar](50) NULL,
		[SecondPlaceFinisherName] [varchar](50) NULL,
		[ThirdPlaceFinisherName] [varchar](50) NULL,
		[WinnerWeight] [int] NULL,
		[SecondPlaceWeight] [int] NULL,
		[ThirdPlaceWeight] [int] NULL,
		[WinnerMargin] [decimal](18, 2) NULL,
		[SecondPlaceMargin] [decimal](18, 2) NULL,
		[ThirdPlaceMargin] [decimal](18, 2) NULL,
		[ExtraCommentLine] [varchar](200) NULL,
		[Weight] [int] NULL,
		[Odds] [decimal](18, 2) NULL,
		[Entry] [char](1) NULL,
		[RaceClassification] [varchar](25) NULL,
		[ClaimingPrice] [decimal](18, 2) NULL,
		[Purse] [decimal](18, 2) NULL,
		[StartCallPosition] [varchar](5) NULL,
		[FirstCallPosition] [varchar](5) NULL,
		[SecondCallPosition] [varchar](5) NULL,
		[GateCallPosition] [varchar](5) NULL,
		[StretchCallPosition] [varchar](5) NULL,
		[FinishPosition] [varchar](5) NULL,
		[MoneyPosition] [varchar](5) NULL,
		[StartCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StartCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[FirstCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FirstCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[SecondCallBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[SecondCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[Reserved50] [varchar](250) NULL,
		[Reserved51] [varchar](250) NULL,
		[StretchBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[StretchBtnLngthsOnly] [decimal](18, 2) NULL,
		[FinishBtnLngthLdrMargin] [decimal](18, 2) NULL,
		[FinishCallBtnLngthsOnly] [decimal](18, 2) NULL,
		[BrisRaceShapeSecondCall] [decimal](18, 2) NULL,
		[Bris2FPace] [int] NULL,
		[Bris4FPace] [int] NULL,
		[Bris6FPace] [int] NULL,
		[Bris8FPace] [int] NULL,
		[Bris10FPace] [int] NULL,
		[BrisLateFPace] [int] NULL,
		[BrisRaceShapeFirstCall] [int] NULL,
		[Reserved64] [int] NULL,
		[BrisSpeedRating] [int] NULL,
		[SpeedRating] [int] NULL,
		[TrackVariant] [int] NULL,
		[TwoFurlongFraction] [decimal](18, 2) NULL,
		[ThreeFurlongFraction] [decimal](18, 2) NULL,
		[FourFurlongFraction] [decimal](18, 2) NULL,
		[FiveFurlongFraction] [decimal](18, 2) NULL,
		[SixFurlongFraction] [decimal](18, 2) NULL,
		[SevenFurlongFraction] [decimal](18, 2) NULL,
		[EightFurlongFraction] [decimal](18, 2) NULL,
		[TenFurlongFraction] [decimal](18, 2) NULL,
		[TwelveFurlongFraction] [decimal](18, 2) NULL,
		[FourteenFurlongFraction] [decimal](18, 2) NULL,
		[SixteenFurlongFraction] [decimal](18, 2) NULL,
		[Fraction1] [decimal](18, 2) NULL,
		[Fraction2] [decimal](18, 2) NULL,
		[Fraction3] [decimal](18, 2) NULL,
		[Reserved82] [varchar](250) NULL,
		[Reserved83] [varchar](250) NULL,
		[FinalTime] [decimal](18, 2) NULL,
		[ClaimedCd] [varchar](10) NULL,
		[Trainer] [varchar](100) NULL,
		[Jockey] [varchar](100) NULL,
		[ApprenticeWtAllow] [int] NULL,
		[RaceType] [varchar](2) NULL,
		[AgeAndSexRestrictions] [varchar](3) NULL,
		[StatebredFlag] [char](1) NULL,
		[RestrictedQualifierFlag] [char](1) NULL,
		[FavoriteIndicator] [int] NULL,
		[FrontBandagesIndicator] [int] NULL,
		[BrisSpeedParPrior] [int] NULL,
		[BarShoe] [char](1) NULL,
		[CompanyLineCode] [varchar](5) NULL,
		[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
		[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
		[Reserved100] [varchar](250) NULL,
		[CodeForPriorStart] [char](1) NULL,
		[Reserved101] [varchar](250) NULL,
		[Reserved102] [varchar](250) NULL,
		[Reserved103] [varchar](250) NULL,
		[Reserved104] [varchar](250) NULL,
		[Reserved105] [varchar](250) NULL,
		[Reserved106] [varchar](250) NULL,
		[ExtendedStartComment] [varchar](250) NULL,
		[SealedTrackIndicator] [char](1) NULL,
		[PrevAllWeatherSurfaceFlag] [char](1) NULL,
		[Reserved110] [varchar](250) NULL,
		[Reserved111] [varchar](250) NULL,
		[Reserved112] [varchar](250) NULL,
		[Reserved113] [varchar](250) NULL,
		[Reserved114] [varchar](250) NULL,
		[Reserved115] [varchar](250) NULL,
		[Reserved116] [varchar](250) NULL,
		[Reserved117] [varchar](250) NULL,
		[Reserved118] [varchar](250) NULL,
		[Reserved119] [varchar](250) NULL,
		[Reserved120] [varchar](250) NULL,
		[Reserved121] [varchar](250) NULL,
		[Reserved122] [varchar](250) NULL
	);

	INSERT INTO @Races
	SELECT CAST(FORMAT(DRF.RaceDt, 'MMM dd, yyyy') AS VARCHAR) RaceDt,
			T.TrackCd,
			T.TrackName,
			DRF.RaceNum,
			DRF.Distance,
			CAST((DRF.Distance / 220.00) AS DECIMAL(10, 2)) Furlong,
			DRF.Surface,
			DRF.Reserved9 RaceType,
			DRF.RaceConditions
	FROM kelso.brisnet_drf DRF
	JOIN kelso.brisnet_Tracks T ON T.TrackCd = DRF.TrackCd
	WHERE DRF.TrackCd = @TrackCd
	AND DRF.RaceDt = @RaceDt
	ORDER BY DRF.RaceNum;

	INSERT INTO @dr2
	SELECT *
	FROM kelso.brisnet_dr2
	WHERE TrackCd = @TrackCd
		AND RaceDt = @RaceDt
	ORDER BY RaceNum, PostPosition;
	
	INSERT INTO @dr3
	SELECT *
	FROM kelso.brisnet_dr3
	WHERE TrackCd = @TrackCd
		AND RaceDt = @RaceDt;

	DECLARE @numOfRaces INT = 0;
	DECLARE @cnt INT = 1;

	SELECT @numOfRaces = COUNT(1)
	FROM @Races;

	WHILE @cnt <= @numOfRaces
	BEGIN
		DELETE FROM @Horses;
		DECLARE @xmlRace NVARCHAR(MAX) = '<Race>';

		DECLARE @xmlInfo NVARCHAR(MAX) =
		(
			SELECT *
			FROM @Races
			WHERE RaceNum = @cnt
			FOR XML PATH('Info')
		);

		SET @xmlRace = @xmlRace + @xmlInfo;

		INSERT INTO @Horses
		SELECT ROW_NUMBER() OVER(ORDER BY PostPosition) Id, HorseName
		FROM @dr2
		WHERE RaceNum = @cnt;
	
		DECLARE @numOfHorses INT = NULL;
		DECLARE @HorseId INT = 1;
		DECLARE @xmlHorses VARCHAR(MAX) = '<Horses>';

		SELECT @numOfHorses = COUNT(1)
		FROM @Horses;

		WHILE @HorseId <= @numOfHorses
		BEGIN
			DECLARE @HorseName VARCHAR(100) = (SELECT HorseName FROM @Horses WHERE Id = @HorseId);

			DECLARE @Info NVARCHAR(MAX) = 
			(
				SELECT PostPosition,
					   HorseName,
					   CurrentRecordYear,
					   CurrentRecordStarts,
					   CurrentRecordWins,
					   CurrentRecordPlaces,
					   CurrentRecordShows,
					   FORMAT(CurrentRecordEarning, 'C') CurrentRecordEarning,
					   PreviousRecordYear,
					   PreviousRecordStarts,
					   PreviousRecordWins,
					   PreviousRecordPlaces,
					   PreviousRecordShows,
					   PreviousRecordWins,
					   FORMAT(PreviousRecordEarning, 'C') PreviousRecordEarning,
					   LifeTimeRecordTodayTrackStarts,
					   LifeTimeRecordTodayTrackWins,
					   LifeTimeRecordTodayTrackPlaces,
					   LifeTimeRecordTodayTrackShows,
					   FORMAT(LifeTimeRecordTodayTrackEarning, 'C') LifeTimeRecordTodayTrackEarning,
					   LifeTimeWetRecordStarts,
					   LifeTimeWetRecordWins,
					   LifeTimeWetRecordPlaces,
					   LifeTimeWetRecordShows,
					   FORMAT(LifeTimeWetRecordEarning, 'C') LifeTimeWetRecordEarning,
					   LifeTimeTurfRecordStarts,
					   LifeTimeTurfRecordWins,
					   LifeTimeTurfRecordPlaces,
					   LifeTimeTurfRecordShows,
					   FORMAT(LifeTimeTurfRecordEarning, 'C') LifeTimeTurfRecordEarning,
					   LifeTimeRecordTodayDistanceStarts,
					   LifeTimeRecordTodayDistanceWins,
					   LifeTimeRecordTodayDistancePlaces,
					   LifeTimeRecordTodayDistanceShows,
					   FORMAT(LifeTimeRecordTodayDistanceEarning, 'C') LifeTimeRecordTodayDistanceEarning,
					   Jockey,
					   JockeyRecordCurrentYear,
					   JockeyRecordPreviousYear,
					   Trainer,
					   TrainerRecordCurrentYear,
					   TrainerRecordPreviousYear
				FROM @dr2
				WHERE HorseName = @HorseName
				ORDER BY RaceNum, PostPosition
				FOR XML PATH('Info')
			);

			DECLARE @PastPerformance NVARCHAR(MAX) =
			(
				SELECT CAST(FORMAT(PreviousRaceDate, 'ddMMMyy') AS VARCHAR) RaceDt,
					   PreviousTrackCd TrackCd,
					   TrackCondition,
					   CAST((Distance / 220.00) AS DECIMAL(10,2)) Furlong,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction1, 'K')) = 0 OR ISNUMERIC(ISNULL(FirstCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FirstCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FirstCallPosition = 1 THEN ROUND(Fraction1, 1)
						ELSE ROUND(Fraction1  + (FirstCallBtnLngthsOnly * @perLength), 1)
					   END AS DECIMAL(18, 1)) FirstCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction2, 'K')) = 0 OR ISNUMERIC(ISNULL(SecondCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(SecondCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN SecondCallPosition = 1 THEN ROUND(Fraction2, 1)
						ELSE ROUND((Fraction2 + (SecondCallBtnLngthsOnly * @perLength)) , 1)
					   END AS DECIMAL(18, 1)) SecondCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(Fraction3, 'K')) = 0 OR ISNUMERIC(ISNULL(StretchCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(StretchBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN StretchCallPosition = 1 AND Fraction3 < 60.00 THEN ROUND(Fraction3, 1)
						WHEN StretchCallPosition = 1 AND Fraction3 >= 60.00 THEN (ROUND(Fraction3 / 60, 0) * 100) + ROUND(Fraction3 % 60, 1) 
						WHEN Fraction3 < 60.00 THEN ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1)
						ELSE (ROUND(ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1) / 60, 0) * 100) + ROUND(ROUND(Fraction3 + (StretchBtnLngthsOnly * @perLength), 1) % 60, 1)
					   END AS DECIMAL(18, 1)) StretchCall,
					   CAST(CASE
						WHEN ISNUMERIC(ISNULL(FinalTime, 'K')) = 0 OR ISNUMERIC(ISNULL(FinishPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FinishCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FinishPosition = 1 AND FinalTime < 60 THEN ROUND(FinalTime, 1)
						WHEN FinishPosition = 1 AND FinalTime >= 60 THEN (ROUND(FinalTime / 60, 0) * 100) + ROUND(FinalTime % 60, 1)
						WHEN FinalTime < 60 THEN ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1)
						ELSE (ROUND(ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1) / 60, 0) * 100) + ROUND(ROUND(FinalTime + (FinishCallBtnLngthsOnly * @perLength), 1) % 60, 1)
					   END AS DECIMAL(18, 1)) FinalCall,
					   RaceClassification,
					   Purse,
					   BrisSpeedRating,
					   PreviousPostPosition,
					   StartCallPosition,
					   CAST(FirstCallPosition AS VARCHAR) + '-' + CAST(FirstCallBtnLngthsOnly AS VARCHAR) FirstCallPosition,
					   CAST(SecondCallPosition AS VARCHAR) + '-' + CAST(SecondCallBtnLngthsOnly AS VARCHAR) SecondCallPosition,
					   CAST(StretchCallPosition AS VARCHAR) + '-' + CAST(StretchBtnLngthsOnly AS VARCHAR) StretchCallPosition,
					   CAST(FinishPosition AS VARCHAR) + '-' + CAST(FinishCallBtnLngthsOnly AS VARCHAR) FinishPosition,
					   SpeedRating + '-' + TrackVariant SpeedRating,
					   WinnerName,
					   CAST(WinnerWeight AS VARCHAR) + '-' + CAST(WinnerMargin AS VARCHAR) FirstPlace,
					   SecondPlaceFinisherName,
					   CAST(SecondPlaceWeight AS VARCHAR) + '-' + CAST(SecondPlaceMargin AS VARCHAR) SecondPlace,
					   ThirdPlaceFinisherName,
					   CAST(ThirdPlaceWeight AS VARCHAR) + '-' + CAST(ThirdPlaceMargin AS VARCHAR) ThirdPlace,
					   TripComment,
					   ExtendedStartComment
				FROM @dr3
				WHERE HorseName = @HorseName
				ORDER BY RaceNum, PostPosition, PreviousRaceDate DESC
				FOR XML PATH('PastPerformance'), ROOT('PastPerformances')
			);

			DECLARE @Workout NVARCHAR(MAX) = '';
			WITH WorkoutCTE AS
			(
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout1Date WorkoutDate,
					   Workout1Track WorkoutTrack,
					   Workout1Distance WorkoutDistance,
					   Workout1Time WorkoutTime,
					   WorkoutTrackCondition1 WorkoutTrackCondition,
					   Workout1Description WorkoutDescription,
					   WorkoutRank1 + '/' + NumberOfWorkout1 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName 
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout2Date WorkoutDate,
					   Workout2Track,
					   Workout2Distance,
					   Workout2Time,
					   WorkoutTrackCondition2,
					   Workout2Description,
					   WorkoutRank2 + '/' + NumberOfWorkout2 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout3Date WorkoutDate,
					   Workout3Track,
					   Workout3Distance,
					   Workout3Time,
					   WorkoutTrackCondition3,
					   Workout3Description,
					   WorkoutRank3 + '/' + NumberOfWorkout3 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout4Date,
					   Workout4Track,
					   Workout4Distance,
					   Workout4Time,
					   WorkoutTrackCondition4,
					   Workout4Description,
					   WorkoutRank4 + '/' + NumberOfWorkout4 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout5Date,
					   Workout5Track,
					   Workout5Distance,
					   Workout5Time,
					   WorkoutTrackCondition5,
					   Workout5Description,
					   WorkoutRank5 + '/' + NumberOfWorkout5 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout6Date,
					   Workout6Track,
					   Workout6Distance,
					   Workout6Time,
					   WorkoutTrackCondition6,
					   Workout6Description,
					   WorkoutRank6 + '/' + NumberOfWorkout6 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout7Date,
					   Workout7Track,
					   Workout7Distance,
					   Workout7Time,
					   WorkoutTrackCondition7,
					   Workout7Description,
					   WorkoutRank7 + '/' + NumberOfWorkout7 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout8Date,
					   Workout8Track,
					   Workout8Distance,
					   Workout8Time,
					   WorkoutTrackCondition8,
					   Workout8Description,
					   WorkoutRank8 + '/' + NumberOfWorkout8 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout9Date,
					   Workout9Track,
					   Workout9Distance,
					   Workout9Time,
					   WorkoutTrackCondition9,
					   Workout9Description,
					   WorkoutRank9 + '/' + NumberOfWorkout9 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout10Date,
					   Workout10Track,
					   Workout10Distance,
					   Workout10Time,
					   WorkoutTrackCondition10,
					   Workout10Description,
					   WorkoutRank10 + '/' + NumberOfWorkout10 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout11Date,
					   Workout11Track,
					   Workout11Distance,
					   Workout11Time,
					   WorkoutTrackCondition11,
					   Workout11Description,
					   WorkoutRank11 + '/' + NumberOfWorkout11 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout12Date,
					   Workout12Track,
					   Workout12Distance,
					   Workout12Time,
					   WorkoutTrackCondition12,
					   Workout12Description,
					   WorkoutRank12 + '/' + NumberOfWorkout12 WorkoutRanking
				FROM @dr2
				WHERE HorseName = @HorseName
			)
			SELECT @Workout =
			(
				SELECT CAST(FORMAT(WorkoutDate, 'MMMdd') AS VARCHAR) DisplayWorkoutDate ,
					   WorkoutDate,
					   WorkoutTrack,
					   CAST((WorkoutDistance / 220.00) AS DECIMAL(10,2)) Furlong,
					   CAST(CAST(CASE WHEN WorkoutTime < 60 THEN WorkoutTime ELSE (ROUND(WorkoutTime / 60, 0) * 100) + ROUND(WorkoutTime % 60, 1) END AS DECIMAL(18,1)) AS VARCHAR) WorkoutTime,
					   WorkoutTrackCondition,
					   WorkoutDescription,
					   WorkoutRanking
				FROM WorkoutCTE
				ORDER BY WorkoutDate DESC
				FOR XML PATH('Workout'), ROOT('Workouts')
			);

			SET @xmlHorses = @xmlHorses + '<Horse>' + @Info + ISNULL(@PastPerformance, '<PastPerformances />') + @Workout + '</Horse>';
			SET @HorseId = @HorseId + 1;
		END

		SET @xmlHorses = @xmlHorses + '</Horses>';
		SET @xmlRace = ISNULL(@xmlRace, '') + @xmlHorses + '</Race>';

		INSERT INTO @Program (RaceNum, Race)
		SELECT @cnt, @xmlRace;

		SET @cnt = @cnt + 1;
	END

	SELECT RaceNum, Race
	FROM @Program;

END

GO









