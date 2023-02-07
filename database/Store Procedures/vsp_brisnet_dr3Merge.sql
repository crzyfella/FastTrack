USE FastTrackDev3;

IF EXISTS (SELECT * FROM sysobjects 
      WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_dr3Merge]') 
       AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
 DROP PROCEDURE [kelso].[vsp_brisnet_dr3Merge]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr3Merge]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @brisnet_dr3 TABLE
	(
		[CreatedDt] [datetime] NOT NULL,
		[ModifiedDt] [datetime] NOT NULL,
		[RaceId] [uniqueidentifier] NOT NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceDt] [datetime] NULL,
		[RaceNum] [int] NULL,
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](100) NULL,
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
		[ClaimedCd] [char](10) NULL,
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

	INSERT INTO @brisnet_dr3
	SELECT GETDATE()
		   ,GETDATE()
		   ,R.RaceId
		   ,[SOURCE].[TrackCd]
		   ,[SOURCE].[RaceDt]
		   ,[SOURCE].[RaceNum]
		   ,R.HorseId
		   ,R.HorseName
		   ,[SOURCE].[PostPosition]
		   ,[SOURCE].[PreviousRaceDate]
		   ,[SOURCE].[NumOfDaysSincePreviousRace]
		   ,[SOURCE].[PreviousTrackName]
		   ,[SOURCE].[PreviousTrackCd]
		   ,[SOURCE].[PreviousRaceNum]
		   ,[SOURCE].[TrackCondition]
		   ,[SOURCE].[Distance]
		   ,[SOURCE].[Surface]
		   ,[SOURCE].[SpecialChuteIndicator]
		   ,[SOURCE].[NumOfEntrants]
		   ,[SOURCE].[PreviousPostPosition]
		   ,[SOURCE].[Equipment]
		   ,[SOURCE].[Reserved18]
		   ,[SOURCE].[Medication]
		   ,[SOURCE].[TripComment]
		   ,[SOURCE].[WinnerName]
		   ,[SOURCE].[SecondPlaceFinisherName]
		   ,[SOURCE].[ThirdPlaceFinisherName]
		   ,[SOURCE].[WinnerWeight]
		   ,[SOURCE].[SecondPlaceWeight]
		   ,[SOURCE].[ThirdPlaceWeight]
		   ,CASE WHEN ISNULL([SOURCE].[WinnerMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[WinnerMargin] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SecondPlaceMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondPlaceMargin] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[ThirdPlaceMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[ThirdPlaceMargin] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[ExtraCommentLine]
		   ,[SOURCE].[Weight]
		   ,CASE WHEN ISNULL([SOURCE].[Odds], '') = '' THEN 0 ELSE CAST([SOURCE].[Odds] AS DECIMAL(18,2)) END
		   ,[SOURCE].[Entry]
		   ,[SOURCE].[RaceClassification]
		   ,CASE WHEN ISNULL([SOURCE].[ClaimingPrice], '') = '' THEN 0 ELSE CAST([SOURCE].[ClaimingPrice] AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[Purse], '') = '' THEN 0 ELSE CAST([SOURCE].[Purse] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[StartCallPosition]
		   ,[SOURCE].[FirstCallPosition]
		   ,[SOURCE].[SecondCallPosition]
		   ,[SOURCE].[GateCallPosition]
		   ,[SOURCE].[StretchCallPosition]
		   ,[SOURCE].[FinishPosition]
		   ,[SOURCE].[MoneyPosition]
		   ,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthLdrMargin]AS DECIMAL(18,2))END
		   ,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Reserved50]
		   ,[SOURCE].[Reserved51]
		   ,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FinishBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishBtnLngthLdrMargin]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[FinishCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishCallBtnLngthsOnly]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[BrisRaceShapeSecondCall], '') = '' THEN 0 ELSE CAST([SOURCE].[BrisRaceShapeSecondCall]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Bris2FPace]
		   ,[SOURCE].[Bris4FPace]
		   ,[SOURCE].[Bris6FPace]
		   ,[SOURCE].[Bris8FPace]
		   ,[SOURCE].[Bris10FPace]
		   ,[SOURCE].[BrisLateFPace]
		   ,[SOURCE].[BrisRaceShapeFirstCall]
		   ,[SOURCE].[Reserved64]
		   ,[SOURCE].[BrisSpeedRating]
		   ,[SOURCE].[SpeedRating]
		   ,[SOURCE].[TrackVariant]
		   ,CASE WHEN ISNULL([SOURCE].[TwoFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TwoFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[ThreeFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[ThreeFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FourFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FourFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FiveFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FiveFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SixFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SixFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SevenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SevenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[EightFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[EightFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[TenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[TwelveFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[TwelveFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[FourteenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[FourteenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[SixteenFurlongFraction], '') = '' THEN 0 ELSE CAST([SOURCE].[SixteenFurlongFraction] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction1], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction1] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction2], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction2] AS DECIMAL(18,2)) END 
		   ,CASE WHEN ISNULL([SOURCE].[Fraction3], '') = '' THEN 0 ELSE CAST([SOURCE].[Fraction3] AS DECIMAL(18,2)) END 
		   ,[SOURCE].[Reserved82]
		   ,[SOURCE].[Reserved83]
		   ,CASE WHEN ISNULL([SOURCE].[FinalTime], '') = '' THEN 0 ELSE CAST([SOURCE].[FinalTime] AS DECIMAL(18,2)) END
		   ,[SOURCE].[ClaimedCd]
		   ,[SOURCE].[Trainer]
		   ,[SOURCE].[Jockey]
		   ,[SOURCE].[ApprenticeWtAllow]
		   ,[SOURCE].[RaceType]
		   ,[SOURCE].[AgeAndSexRestrictions]
		   ,[SOURCE].[StatebredFlag]
		   ,[SOURCE].[RestrictedQualifierFlag]
		   ,[SOURCE].[FavoriteIndicator]
		   ,[SOURCE].[FrontBandagesIndicator]
		   ,[SOURCE].[BrisSpeedParPrior]
		   ,[SOURCE].[BarShoe]
		   ,[SOURCE].[CompanyLineCode]
		   ,CASE WHEN ISNULL([SOURCE].[LowClaimingPriceOfRace], '') = '' THEN 0 ELSE CAST([SOURCE].[LowClaimingPriceOfRace]AS DECIMAL(18,2)) END
		   ,CASE WHEN ISNULL([SOURCE].[HighClaimingPriceOfRace], '') = '' THEN 0 ELSE CAST([SOURCE].[HighClaimingPriceOfRace]AS DECIMAL(18,2)) END
		   ,[SOURCE].[Reserved100]
		   ,[SOURCE].[CodeForPriorStart]
		   ,[SOURCE].[Reserved101]
		   ,[SOURCE].[Reserved102]
		   ,[SOURCE].[Reserved103]
		   ,[SOURCE].[Reserved104]
		   ,[SOURCE].[Reserved105]
		   ,[SOURCE].[Reserved106]
		   ,[SOURCE].[ExtendedStartComment]
		   ,[SOURCE].[SealedTrackIndicator]
		   ,[SOURCE].[PrevAllWeatherSurfaceFlag]
		   ,[SOURCE].[Reserved110]
		   ,[SOURCE].[Reserved111]
		   ,[SOURCE].[Reserved112]
		   ,[SOURCE].[Reserved113]
		   ,[SOURCE].[Reserved114]
		   ,[SOURCE].[Reserved115]
		   ,[SOURCE].[Reserved116]
		   ,[SOURCE].[Reserved117]
		   ,[SOURCE].[Reserved118]
		   ,[SOURCE].[Reserved119]
		   ,[SOURCE].[Reserved120]
		   ,[SOURCE].[Reserved121]
		   ,[SOURCE].[Reserved122]
	FROM kelso.brisnet_dr3_staging AS [SOURCE]
	JOIN kelso.brisnet_RaceParticipants R ON R.RaceDt = [SOURCE].RaceDt 
											 AND R.TrackCd = [SOURCE].TrackCd 
											 AND R.RaceNum = [SOURCE].RaceNum
											 AND R.PostPosition = [SOURCE].PostPosition;

	MERGE kelso.brisnet_dr3 AS [TARGET]
	USING @brisnet_dr3 AS [SOURCE]
	ON ([SOURCE].[RaceId] = [TARGET].[RaceId] 
		AND [SOURCE].[HorseId] = [TARGET].[HorseId]
		AND [SOURCE].[PreviousRaceDate] = [TARGET].[PreviousRaceDate]) 
	WHEN MATCHED
	THEN UPDATE
		SET [TARGET].[ModifiedDt] = GETDATE()
			,[TARGET].[PreviousRaceDate] = [SOURCE].[PreviousRaceDate]
			,[TARGET].[NumOfDaysSincePreviousRace] = [SOURCE].[NumOfDaysSincePreviousRace]
			,[TARGET].[PreviousTrackName] = [SOURCE].[PreviousTrackName]
			,[TARGET].[PreviousTrackCd] = [SOURCE].[PreviousTrackCd]
			,[TARGET].[PreviousRaceNum] = [SOURCE].[PreviousRaceNum]
			,[TARGET].[TrackCondition] = [SOURCE].[TrackCondition]
			,[TARGET].[Distance] = [SOURCE].[Distance]
			,[TARGET].[Surface] = [SOURCE].[Surface]
			,[TARGET].[SpecialChuteIndicator] = [SOURCE].[SpecialChuteIndicator]
			,[TARGET].[NumOfEntrants] = [SOURCE].[NumOfEntrants]
			,[TARGET].[PreviousPostPosition] = [SOURCE].[PreviousPostPosition]
			,[TARGET].[Equipment] = [SOURCE].[Equipment]
			,[TARGET].[Reserved18] = [SOURCE].[Reserved18]
			,[TARGET].[Medication] = [SOURCE].[Medication]
			,[TARGET].[TripComment] = [SOURCE].[TripComment]
			,[TARGET].[WinnerName] = [SOURCE].[WinnerName]
			,[TARGET].[SecondPlaceFinisherName] = [SOURCE].[SecondPlaceFinisherName]
			,[TARGET].[ThirdPlaceFinisherName] = [SOURCE].[ThirdPlaceFinisherName]
			,[TARGET].[WinnerWeight] = [SOURCE].[WinnerWeight]
			,[TARGET].[SecondPlaceWeight] = [SOURCE].[SecondPlaceWeight]
			,[TARGET].[ThirdPlaceWeight] = [SOURCE].[ThirdPlaceWeight]
			,[TARGET].[WinnerMargin] = [SOURCE].[WinnerMargin]
			,[TARGET].[SecondPlaceMargin] = [SOURCE].[SecondPlaceMargin]
			,[TARGET].[ThirdPlaceMargin] = [SOURCE].[ThirdPlaceMargin]
			,[TARGET].[ExtraCommentLine] = [SOURCE].[ExtraCommentLine]
			,[TARGET].[Weight] = [SOURCE].[Weight]
			,[TARGET].[Odds] = [SOURCE].[Odds]
			,[TARGET].[Entry] = [SOURCE].[Entry]
			,[TARGET].[RaceClassification] = [SOURCE].[RaceClassification]
			,[TARGET].[ClaimingPrice] = [SOURCE].[ClaimingPrice]
			,[TARGET].[Purse] = [SOURCE].[Purse]
			,[TARGET].[StartCallPosition] = [SOURCE].[StartCallPosition]
			,[TARGET].[FirstCallPosition] = [SOURCE].[FirstCallPosition]
			,[TARGET].[SecondCallPosition] = [SOURCE].[SecondCallPosition]
			,[TARGET].[GateCallPosition] = [SOURCE].[GateCallPosition]
			,[TARGET].[StretchCallPosition] = [SOURCE].[StretchCallPosition]
			,[TARGET].[FinishPosition] = [SOURCE].[FinishPosition]
			,[TARGET].[MoneyPosition] = [SOURCE].[MoneyPosition]
			,[TARGET].[StartCallBtnLngthLdrMargin] = [SOURCE].[StartCallBtnLngthLdrMargin]
			,[TARGET].[StartCallBtnLngthsOnly] = [SOURCE].[StartCallBtnLngthsOnly]
			,[TARGET].[FirstCallBtnLngthLdrMargin] = [SOURCE].[FirstCallBtnLngthLdrMargin]
			,[TARGET].[FirstCallBtnLngthsOnly] = [SOURCE].[FirstCallBtnLngthsOnly]
			,[TARGET].[SecondCallBtnLngthLdrMargin] = [SOURCE].[SecondCallBtnLngthLdrMargin]
			,[TARGET].[SecondCallBtnLngthsOnly] = [SOURCE].[SecondCallBtnLngthsOnly]
			,[TARGET].[Reserved50] = [SOURCE].[Reserved50]
			,[TARGET].[Reserved51] = [SOURCE].[Reserved51]
			,[TARGET].[StretchBtnLngthLdrMargin] = [SOURCE].[StretchBtnLngthLdrMargin]
			,[TARGET].[StretchBtnLngthsOnly] = [SOURCE].[StretchBtnLngthsOnly]
			,[TARGET].[FinishBtnLngthLdrMargin] = [SOURCE].[FinishBtnLngthLdrMargin]
			,[TARGET].[FinishCallBtnLngthsOnly] = [SOURCE].[FinishCallBtnLngthsOnly]
			,[TARGET].[BrisRaceShapeSecondCall] = [SOURCE].[BrisRaceShapeSecondCall]
			,[TARGET].[Bris2FPace] = [SOURCE].[Bris2FPace]
			,[TARGET].[Bris4FPace] = [SOURCE].[Bris4FPace]
			,[TARGET].[Bris6FPace] = [SOURCE].[Bris6FPace]
			,[TARGET].[Bris8FPace] = [SOURCE].[Bris8FPace]
			,[TARGET].[Bris10FPace] = [SOURCE].[Bris10FPace]
			,[TARGET].[BrisLateFPace] = [SOURCE].[BrisLateFPace]
			,[TARGET].[BrisRaceShapeFirstCall] = [SOURCE].[BrisRaceShapeFirstCall]
			,[TARGET].[Reserved64] = [SOURCE].[Reserved64]
			,[TARGET].[BrisSpeedRating] = [SOURCE].[BrisSpeedRating]
			,[TARGET].[SpeedRating] = [SOURCE].[SpeedRating]
			,[TARGET].[TrackVariant] = [SOURCE].[TrackVariant]
			,[TARGET].[TwoFurlongFraction] = [SOURCE].[TwoFurlongFraction]
			,[TARGET].[ThreeFurlongFraction] = [SOURCE].[ThreeFurlongFraction]
			,[TARGET].[FourFurlongFraction] = [SOURCE].[FourFurlongFraction]
			,[TARGET].[FiveFurlongFraction] = [SOURCE].[FiveFurlongFraction]
			,[TARGET].[SixFurlongFraction] = [SOURCE].[SixFurlongFraction]
			,[TARGET].[SevenFurlongFraction] = [SOURCE].[SevenFurlongFraction]
			,[TARGET].[EightFurlongFraction] = [SOURCE].[EightFurlongFraction]
			,[TARGET].[TenFurlongFraction] = [SOURCE].[TenFurlongFraction]
			,[TARGET].[TwelveFurlongFraction] = [SOURCE].[TwelveFurlongFraction]
			,[TARGET].[FourteenFurlongFraction] = [SOURCE].[FourteenFurlongFraction]
			,[TARGET].[SixteenFurlongFraction] = [SOURCE].[SixteenFurlongFraction]
			,[TARGET].[Fraction1] = [SOURCE].[Fraction1]
			,[TARGET].[Fraction2] = [SOURCE].[Fraction2]
			,[TARGET].[Fraction3] = [SOURCE].[Fraction3]
			,[TARGET].[Reserved82] = [SOURCE].[Reserved82]
			,[TARGET].[Reserved83] = [SOURCE].[Reserved83]
			,[TARGET].[FinalTime] = [SOURCE].[FinalTime]
			,[TARGET].[ClaimedCd] = [SOURCE].[ClaimedCd]
			,[TARGET].[Trainer] = [SOURCE].[Trainer]
			,[TARGET].[Jockey] = [SOURCE].[Jockey]
			,[TARGET].[ApprenticeWtAllow] = [SOURCE].[ApprenticeWtAllow]
			,[TARGET].[RaceType] = [SOURCE].[RaceType]
			,[TARGET].[AgeAndSexRestrictions] = [SOURCE].[AgeAndSexRestrictions]
			,[TARGET].[StatebredFlag] = [SOURCE].[StatebredFlag]
			,[TARGET].[RestrictedQualifierFlag] = [SOURCE].[RestrictedQualifierFlag]
			,[TARGET].[FavoriteIndicator] = [SOURCE].[FavoriteIndicator]
			,[TARGET].[FrontBandagesIndicator] = [SOURCE].[FrontBandagesIndicator]
			,[TARGET].[BrisSpeedParPrior] = [SOURCE].[BrisSpeedParPrior]
			,[TARGET].[BarShoe] = [SOURCE].[BarShoe]
			,[TARGET].[CompanyLineCode] = [SOURCE].[CompanyLineCode]
			,[TARGET].[LowClaimingPriceOfRace] = [SOURCE].[LowClaimingPriceOfRace]
			,[TARGET].[HighClaimingPriceOfRace] = [SOURCE].[HighClaimingPriceOfRace]
			,[TARGET].[Reserved100] = [SOURCE].[Reserved100]
			,[TARGET].[CodeForPriorStart] = [SOURCE].[CodeForPriorStart]
			,[TARGET].[Reserved101] = [SOURCE].[Reserved101]
			,[TARGET].[Reserved102] = [SOURCE].[Reserved102]
			,[TARGET].[Reserved103] = [SOURCE].[Reserved103]
			,[TARGET].[Reserved104] = [SOURCE].[Reserved104]
			,[TARGET].[Reserved105] = [SOURCE].[Reserved105]
			,[TARGET].[Reserved106] = [SOURCE].[Reserved106]
			,[TARGET].[ExtendedStartComment] = [SOURCE].[ExtendedStartComment]
			,[TARGET].[SealedTrackIndicator] = [SOURCE].[SealedTrackIndicator]
			,[TARGET].[PrevAllWeatherSurfaceFlag] = [SOURCE].[PrevAllWeatherSurfaceFlag]
			,[TARGET].[Reserved110] = [SOURCE].[Reserved110]
			,[TARGET].[Reserved111] = [SOURCE].[Reserved111]
			,[TARGET].[Reserved112] = [SOURCE].[Reserved112]
			,[TARGET].[Reserved113] = [SOURCE].[Reserved113]
			,[TARGET].[Reserved114] = [SOURCE].[Reserved114]
			,[TARGET].[Reserved115] = [SOURCE].[Reserved115]
			,[TARGET].[Reserved116] = [SOURCE].[Reserved116]
			,[TARGET].[Reserved117] = [SOURCE].[Reserved117]
			,[TARGET].[Reserved118] = [SOURCE].[Reserved118]
			,[TARGET].[Reserved119] = [SOURCE].[Reserved119]
			,[TARGET].[Reserved120] = [SOURCE].[Reserved120]
			,[TARGET].[Reserved121]  = [SOURCE].[Reserved121] 
			,[TARGET].[Reserved122] = [SOURCE].[Reserved122]
	WHEN NOT MATCHED 
	THEN INSERT ([RaceId]
				,[CreatedDt]
				,[ModifiedDt]
				,[TrackCd]
				,[RaceDt]
				,[RaceNum]
				,[HorseId]
				,[HorseName]
				,[PostPosition]
				,[PreviousRaceDate]
				,[NumOfDaysSincePreviousRace]
				,[PreviousTrackName]
				,[PreviousTrackCd]
				,[PreviousRaceNum]
				,[TrackCondition]
				,[Distance]
				,[Surface]
				,[SpecialChuteIndicator]
				,[NumOfEntrants]
				,[PreviousPostPosition]
				,[Equipment]
				,[Reserved18]
				,[Medication]
				,[TripComment]
				,[WinnerName]
				,[SecondPlaceFinisherName]
				,[ThirdPlaceFinisherName]
				,[WinnerWeight]
				,[SecondPlaceWeight]
				,[ThirdPlaceWeight]
				,[WinnerMargin]
				,[SecondPlaceMargin]
				,[ThirdPlaceMargin]
				,[ExtraCommentLine]
				,[Weight]
				,[Odds]
				,[Entry]
				,[RaceClassification]
				,[ClaimingPrice]
				,[Purse]
				,[StartCallPosition]
				,[FirstCallPosition]
				,[SecondCallPosition]
				,[GateCallPosition]
				,[StretchCallPosition]
				,[FinishPosition]
				,[MoneyPosition]
				,[StartCallBtnLngthLdrMargin]
				,[StartCallBtnLngthsOnly]
				,[FirstCallBtnLngthLdrMargin]
				,[FirstCallBtnLngthsOnly]
				,[SecondCallBtnLngthLdrMargin]
				,[SecondCallBtnLngthsOnly]
				,[Reserved50]
				,[Reserved51]
				,[StretchBtnLngthLdrMargin]
				,[StretchBtnLngthsOnly]
				,[FinishBtnLngthLdrMargin]
				,[FinishCallBtnLngthsOnly]
				,[BrisRaceShapeSecondCall]
				,[Bris2FPace]
				,[Bris4FPace]
				,[Bris6FPace]
				,[Bris8FPace]
				,[Bris10FPace]
				,[BrisLateFPace]
				,[BrisRaceShapeFirstCall]
				,[Reserved64]
				,[BrisSpeedRating]
				,[SpeedRating]
				,[TrackVariant]
				,[TwoFurlongFraction]
				,[ThreeFurlongFraction]
				,[FourFurlongFraction]
				,[FiveFurlongFraction]
				,[SixFurlongFraction]
				,[SevenFurlongFraction]
				,[EightFurlongFraction]
				,[TenFurlongFraction]
				,[TwelveFurlongFraction]
				,[FourteenFurlongFraction]
				,[SixteenFurlongFraction]
				,[Fraction1]
				,[Fraction2]
				,[Fraction3]
				,[Reserved82]
				,[Reserved83]
				,[FinalTime]
				,[ClaimedCd]
				,[Trainer]
				,[Jockey]
				,[ApprenticeWtAllow]
				,[RaceType]
				,[AgeAndSexRestrictions]
				,[StatebredFlag]
				,[RestrictedQualifierFlag]
				,[FavoriteIndicator]
				,[FrontBandagesIndicator]
				,[BrisSpeedParPrior]
				,[BarShoe]
				,[CompanyLineCode]
				,[LowClaimingPriceOfRace]
				,[HighClaimingPriceOfRace]
				,[Reserved100]
				,[CodeForPriorStart]
				,[Reserved101]
				,[Reserved102]
				,[Reserved103]
				,[Reserved104]
				,[Reserved105]
				,[Reserved106]
				,[ExtendedStartComment]
				,[SealedTrackIndicator]
				,[PrevAllWeatherSurfaceFlag]
				,[Reserved110]
				,[Reserved111]
				,[Reserved112]
				,[Reserved113]
				,[Reserved114]
				,[Reserved115]
				,[Reserved116]
				,[Reserved117]
				,[Reserved118]
				,[Reserved119]
				,[Reserved120]
				,[Reserved121] 
				,[Reserved122]) 
    VALUES ([SOURCE].[RaceId]
				,GETDATE()
				,GETDATE()
				,[SOURCE].[TrackCd]
				,[SOURCE].[RaceDt]
				,[SOURCE].[RaceNum]
				,[SOURCE].[HorseId]
				,[SOURCE].[HorseName]
				,[SOURCE].[PostPosition]
				,[SOURCE].[PreviousRaceDate]
				,[SOURCE].[NumOfDaysSincePreviousRace]
				,[SOURCE].[PreviousTrackName]
				,[SOURCE].[PreviousTrackCd]
				,[SOURCE].[PreviousRaceNum]
				,[SOURCE].[TrackCondition]
				,[SOURCE].[Distance]
				,[SOURCE].[Surface]
				,[SOURCE].[SpecialChuteIndicator]
				,[SOURCE].[NumOfEntrants]
				,[SOURCE].[PreviousPostPosition]
				,[SOURCE].[Equipment]
				,[SOURCE].[Reserved18]
				,[SOURCE].[Medication]
				,[SOURCE].[TripComment]
				,[SOURCE].[WinnerName]
				,[SOURCE].[SecondPlaceFinisherName]
				,[SOURCE].[ThirdPlaceFinisherName]
				,[SOURCE].[WinnerWeight]
				,[SOURCE].[SecondPlaceWeight]
				,[SOURCE].[ThirdPlaceWeight]
				,[SOURCE].[WinnerMargin]
				,[SOURCE].[SecondPlaceMargin]
				,[SOURCE].[ThirdPlaceMargin]
				,[SOURCE].[ExtraCommentLine]
				,[SOURCE].[Weight]
				,[SOURCE].[Odds]
				,[SOURCE].[Entry]
				,[SOURCE].[RaceClassification]
				,[SOURCE].[ClaimingPrice]
				,[SOURCE].[Purse]
				,[SOURCE].[StartCallPosition]
				,[SOURCE].[FirstCallPosition]
				,[SOURCE].[SecondCallPosition]
				,[SOURCE].[GateCallPosition]
				,[SOURCE].[StretchCallPosition]
				,[SOURCE].[FinishPosition]
				,[SOURCE].[MoneyPosition]
				,[SOURCE].[StartCallBtnLngthLdrMargin]
				,[SOURCE].[StartCallBtnLngthsOnly]
				,[SOURCE].[FirstCallBtnLngthLdrMargin]
				,[SOURCE].[FirstCallBtnLngthsOnly]
				,[SOURCE].[SecondCallBtnLngthLdrMargin]
				,[SOURCE].[SecondCallBtnLngthsOnly]
				,[SOURCE].[Reserved50]
				,[SOURCE].[Reserved51]
				,[SOURCE].[StretchBtnLngthLdrMargin]
				,[SOURCE].[StretchBtnLngthsOnly]
				,[SOURCE].[FinishBtnLngthLdrMargin]
				,[SOURCE].[FinishCallBtnLngthsOnly]
				,[SOURCE].[BrisRaceShapeSecondCall]
				,[SOURCE].[Bris2FPace]
				,[SOURCE].[Bris4FPace]
				,[SOURCE].[Bris6FPace]
				,[SOURCE].[Bris8FPace]
				,[SOURCE].[Bris10FPace]
				,[SOURCE].[BrisLateFPace]
				,[SOURCE].[BrisRaceShapeFirstCall]
				,[SOURCE].[Reserved64]
				,[SOURCE].[BrisSpeedRating]
				,[SOURCE].[SpeedRating]
				,[SOURCE].[TrackVariant]
				,[SOURCE].[TwoFurlongFraction]
				,[SOURCE].[ThreeFurlongFraction]
				,[SOURCE].[FourFurlongFraction]
				,[SOURCE].[FiveFurlongFraction] 
				,[SOURCE].[SixFurlongFraction]
				,[SOURCE].[SevenFurlongFraction]
				,[SOURCE].[EightFurlongFraction]
				,[SOURCE].[TenFurlongFraction]
				,[SOURCE].[TwelveFurlongFraction]
				,[SOURCE].[FourteenFurlongFraction]
				,[SOURCE].[SixteenFurlongFraction]
				,[SOURCE].[Fraction1]
				,[SOURCE].[Fraction2]
				,[SOURCE].[Fraction3]
				,[SOURCE].[Reserved82]
				,[SOURCE].[Reserved83]
				,[SOURCE].[FinalTime]
				,[SOURCE].[ClaimedCd]
				,[SOURCE].[Trainer]
				,[SOURCE].[Jockey]
				,[SOURCE].[ApprenticeWtAllow]
				,[SOURCE].[RaceType]
				,[SOURCE].[AgeAndSexRestrictions]
				,[SOURCE].[StatebredFlag]
				,[SOURCE].[RestrictedQualifierFlag]
				,[SOURCE].[FavoriteIndicator]
				,[SOURCE].[FrontBandagesIndicator]
				,[SOURCE].[BrisSpeedParPrior]
				,[SOURCE].[BarShoe]
				,[SOURCE].[CompanyLineCode]
				,[SOURCE].[LowClaimingPriceOfRace]
				,[SOURCE].[HighClaimingPriceOfRace]
				,[SOURCE].[Reserved100]
				,[SOURCE].[CodeForPriorStart]
				,[SOURCE].[Reserved101]
				,[SOURCE].[Reserved102]
				,[SOURCE].[Reserved103]
				,[SOURCE].[Reserved104]
				,[SOURCE].[Reserved105]
				,[SOURCE].[Reserved106]
				,[SOURCE].[ExtendedStartComment]
				,[SOURCE].[SealedTrackIndicator]
				,[SOURCE].[PrevAllWeatherSurfaceFlag]
				,[SOURCE].[Reserved110]
				,[SOURCE].[Reserved111]
				,[SOURCE].[Reserved112]
				,[SOURCE].[Reserved113]
				,[SOURCE].[Reserved114]
				,[SOURCE].[Reserved115]
				,[SOURCE].[Reserved116]
				,[SOURCE].[Reserved117]
				,[SOURCE].[Reserved118]
				,[SOURCE].[Reserved119]
				,[SOURCE].[Reserved120]
				,[SOURCE].[Reserved121]
				,[SOURCE].[Reserved122]);

END

GO


