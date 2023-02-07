USE FastTrackDev3;

IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_HorseHistoryInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_HorseHistoryInsert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_HorseHistoryInsert]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @LengthTime DECIMAL(18, 2) = 0.18;

	DECLARE @HorseHistory AS TABLE
	(
		[HorseId] [uniqueidentifier] NULL,
		[HorseName] [varchar](75) NULL,
		[RaceDt] [date] NULL,
		[TrackCd] [varchar](3) NULL,
		[RaceNum] [int] NULL,
		[TrackCondition] [varchar](2) NULL,
		[Distance] [decimal](18, 2) NULL,
		[Surface] [char](1) NULL,
		[NumOfEntrants] [int] NULL,
		[PostPosition] [int] NULL,
		[Equipment] [char](1) NULL,
		[Medication] [int] NULL,
		[TripComment] [varchar](100) NULL,
		[ExtraCommentLine] [varchar](200) NULL,
		[WinnerMargin] [decimal](18, 2) NULL,
		[SecondPlaceMargin] [decimal](18, 2) NULL,
		[ThirdPlaceMargin] [decimal](18, 2) NULL,
		[Odds] [decimal](18, 2) NULL,
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
		[FinalTime] [decimal](18, 2) NULL,
		[JockeyId] [int] NULL,
		[Jockey] [varchar](30) NULL,
		[RaceType] [varchar](2) NULL,
		[FavoriteIndicator] [int] NULL,
		[FrontBandagesIndicator] [int] NULL,
		[BrisSpeedParPrior] [int] NULL,
		[LowClaimingPriceOfRace] [decimal](18, 2) NULL,
		[HighClaimingPriceOfRace] [decimal](18, 2) NULL,
		[ExtendedStartComment] [varchar](100) NULL
	);

	INSERT INTO @HorseHistory
	SELECT DR3.HorseId
			,DR3.HorseName
			,DR3.PreviousRaceDate RaceDt
			,DR3.PreviousTrackCd TrackCd
			,DR3.PreviousRaceNum RaceNum
			,DR3.TrackCondition
			,ABS(DR3.Distance) 
			,DR3.Surface
			,DR3.NumOfEntrants
			,DR3.PreviousPostPosition PostPosition
			,DR3.Equipment
			,DR3.Medication
			,DR3.TripComment
			,DR3.ExtraCommentLine
			,DR3.WinnerMargin
			,DR3.SecondPlaceMargin
			,DR3.ThirdPlaceMargin
			,DR3.Odds
			,DR3.RaceClassification
			,DR3.ClaimingPrice
			,DR3.Purse
			,DR3.StartCallPosition
			,DR3.FirstCallPosition
			,DR3.SecondCallPosition
			,DR3.GateCallPosition
			,DR3.StretchCallPosition
			,DR3.FinishPosition
			,DR3.MoneyPosition
			,DR3.StartCallBtnLngthLdrMargin
			,DR3.StartCallBtnLngthsOnly
			,DR3.FirstCallBtnLngthLdrMargin
			,DR3.FirstCallBtnLngthsOnly
			,DR3.SecondCallBtnLngthLdrMargin
			,DR3.SecondCallBtnLngthsOnly
			,DR3.StretchBtnLngthLdrMargin
			,DR3.StretchBtnLngthsOnly
			,DR3.FinishBtnLngthLdrMargin
			,DR3.FinishCallBtnLngthsOnly
			,DR3.BrisRaceShapeSecondCall
			,DR3.Bris2FPace 
			,DR3.Bris4FPace
			,DR3.Bris6FPace
			,DR3.Bris8FPace
			,DR3.Bris10FPace
			,DR3.BrisLateFPace
			,DR3.BrisRaceShapeFirstCall
			,DR3.BrisSpeedRating
			,DR3.SpeedRating
			,DR3.TrackVariant
			,CASE WHEN DR3.TwoFurlongFraction = 0.00 THEN DR3.TwoFurlongFraction
				  WHEN DR3.Distance BETWEEN 870.00 AND 1750.00 THEN DR3.TwoFurlongFraction + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
				  WHEN DR3.Distance BETWEEN 1751.00 AND 1860.00 THEN DR3.TwoFurlongFraction + (DR3.StartCallBtnLngthsOnly * @LengthTime)
			 END TwoFurlongFraction
			,DR3.ThreeFurlongFraction
			,CASE WHEN DR3.FourFurlongFraction = 0.00 THEN DR3.FourFurlongFraction
				  WHEN DR3.Distance BETWEEN 870.00 AND 1750.00 THEN DR3.FourFurlongFraction + (DR3.SecondCallBtnLngthsOnly * @LengthTime)
				  ELSE DR3.FourFurlongFraction + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
			 END FourFurlongFraction
			,CASE WHEN DR3.FiveFurlongFraction = 0.00 THEN DR3.FiveFurlongFraction ELSE DR3.FiveFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime) END FiveFurlongFraction
			,CASE WHEN DR3.SixFurlongFraction = 0.00 THEN DR3.SixFurlongFraction
				  WHEN DR3.Distance BETWEEN 1430.00 AND 1760.00 THEN DR3.SixFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime)
				  ELSE DR3.SixFurlongFraction + (DR3.SecondCallBtnLngthsOnly * @LengthTime)
			 END SixFurlongFraction
			,DR3.SevenFurlongFraction
			,CASE WHEN DR3.EightFurlongFraction = 0.00 THEN DR3.EightFurlongFraction 
				  ELSE DR3.EightFurlongFraction + (DR3.StretchBtnLngthsOnly * @LengthTime)
			END EightFurlongFraction
			,DR3.TenFurlongFraction
			,DR3.TwelveFurlongFraction
			,DR3.FourteenFurlongFraction
			,DR3.SixteenFurlongFraction
			,CASE  WHEN DR3.Fraction1 = 0.00 THEN DR3.Fraction1 
				  WHEN DR3.Fraction1 > 0.00 THEN DR3.Fraction1 + (DR3.FirstCallBtnLngthsOnly * @LengthTime)
				  ELSE 0.00 
			 END Fraction1
			,CASE WHEN DR3.Fraction2 = 0.00 THEN DR3.Fraction2
				WHEN DR3.Fraction1 = 0.00 AND DR3.Fraction2 >= 250.00 THEN 0.00
				WHEN DR3.Fraction1> 0.00 AND DR3.Fraction3 = 0.00 THEN DR3.Fraction2 + (DR3.StretchBtnLngthsOnly * @LengthTime) 
				ELSE DR3.Fraction2 + (DR3.SecondCallBtnLngthsOnly * @LengthTime) 
			 END Fraction2
			,CASE WHEN DR3.Fraction3 = 0.00 THEN DR3.Fraction3
				  ELSE DR3.Fraction3 + (DR3.StretchBtnLngthsOnly * @LengthTime) 
			 END Fraction3
			,DR3.FinalTime + (DR3.FinishCallBtnLngthsOnly * @LengthTime) FinalTime
			,NULL JockeyId
			,DR3.Jockey
			,DR3.RaceType
			,DR3.FavoriteIndicator
			,DR3.FrontBandagesIndicator
			,DR3.BrisSpeedParPrior
			,DR3.LowClaimingPriceOfRace
			,DR3.HighClaimingPriceOfRace
			,DR3.ExtendedStartComment
	FROM kelso.brisnet_DR3 DR3
		LEFT JOIN kelso.brisnet_HorseHistory HH ON HH.RaceDt = DR3.PreviousRaceDate 
											   AND HH.TrackCd = DR3.PreviousTrackCd
											   AND HH.RaceNum = DR3.PreviousRaceNum
											   AND HH.HorseId = DR3.HorseId
	WHERE DR3.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
		  AND HH.HorseId IS NULL
	ORDER BY ABS(DR3.Distance);

	INSERT INTO kelso.brisnet_HorseHistory
	SELECT [HorseId]
          ,[HorseName]
          ,[RaceDt]
          ,[TrackCd]
          ,[RaceNum]
          ,[TrackCondition]
          ,[Distance]
          ,[Surface]
          ,[NumOfEntrants]
          ,[PostPosition]
          ,[Equipment]
          ,[Medication]
          ,[TripComment]
          ,[ExtraCommentLine]
          ,[WinnerMargin]
          ,[SecondPlaceMargin]
          ,[ThirdPlaceMargin]
          ,[Odds]
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
          ,[FinalTime]
          ,[JockeyId]
          ,[Jockey]
          ,[RaceType]
          ,[FavoriteIndicator]
          ,[FrontBandagesIndicator]
          ,[BrisSpeedParPrior]
          ,[LowClaimingPriceOfRace]
          ,[HighClaimingPriceOfRace]
          ,[ExtendedStartComment]
	FROM @HorseHistory DR3;
END

GO

