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

	INSERT INTO kelso.brisnet_HorseHistory( Dr3Id
											,HorseId
											,HorseName
											,RaceDt
											,TrackCd
											,RaceNum
											,TrackCondition
											,Distance
											,Surface
											,NumOfEntrants
											,PostPosition
											,Equipment
											,Medication
											,TripComment
											,ExtraCommentLine
											,WinnerMargin
											,SecondPlaceMargin
											,ThirdPlaceMargin
											,Odds
											,RaceClassification
											,ClaimingPrice
											,Purse
											,StartCallPosition
											,FirstCallPosition
											,SecondCallPosition
											,GateCallPosition
											,StretchCallPosition
											,FinishPosition
											,MoneyPosition
											,StartCallBtnLngthLdrMargin
											,StartCallBtnLngthsOnly
											,FirstCallBtnLngthLdrMargin
											,FirstCallBtnLngthsOnly
											,SecondCallBtnLngthLdrMargin
											,SecondCallBtnLngthsOnly
											,StretchBtnLngthLdrMargin
											,StretchBtnLngthsOnly
											,FinishBtnLngthLdrMargin
											,FinishCallBtnLngthsOnly
											,BrisRaceShapeSecondCall
											,Bris2FPace
											,Bris4FPace
											,Bris6FPace
											,Bris8FPace
											,Bris10FPace
											,BrisLateFPace
											,BrisRaceShapeFirstCall
											,BrisSpeedRating
											,SpeedRating
											,TrackVariant
											,TwoFurlongFraction
											,ThreeFurlongFraction
											,FourFurlongFraction
											,FiveFurlongFraction
											,SixFurlongFraction
											,SevenFurlongFraction
											,EightFurlongFraction
											,TenFurlongFraction
											,TwelveFurlongFraction
											,FourteenFurlongFraction
											,SixteenFurlongFraction
											,Fraction1
											,Fraction2
											,Fraction3
											,FinalTime
											,JockeyId
											,Jockey
											,RaceType
											,FavoriteIndicator
											,FrontBandagesIndicator
											,BrisSpeedParPrior
											,LowClaimingPriceOfRace
											,HighClaimingPriceOfRace
											,ExtendedStartComment
	)
	SELECT DR3.Dr3Id
		   ,DR3.HorseId
	       ,DR3.HorseName
	       ,DR3.PreviousRaceDate RaceDt
	       ,DR3.PreviousTrackCd TrackCd
	       ,DR3.PreviousRaceNum RaceNum
	       ,DR3.TrackCondition
	       ,DR3.Distance
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
	       ,CASE WHEN DR3.Bris2FPace > 0 AND DR3.FirstCallBtnLngthsOnly > 0 THEN 
	       ,DR3.Bris4FPace
	       ,DR3.Bris6FPace
	       ,DR3.Bris8FPace
	       ,DR3.Bris10FPace
	       ,DR3.BrisLateFPace
	       ,DR3.BrisRaceShapeFirstCall
	       ,DR3.BrisSpeedRating
	       ,DR3.SpeedRating
	       ,DR3.TrackVariant
	       ,DR3.TwoFurlongFraction
	       ,DR3.ThreeFurlongFraction
	       ,DR3.FourFurlongFraction
	       ,DR3.FiveFurlongFraction
	       ,DR3.SixFurlongFraction
	       ,DR3.SevenFurlongFraction
	       ,DR3.EightFurlongFraction
	       ,DR3.TenFurlongFraction
	       ,DR3.TwelveFurlongFraction
	       ,DR3.FourteenFurlongFraction
	       ,DR3.SixteenFurlongFraction
	       ,DR3.Fraction1
	       ,DR3.Fraction2
	       ,DR3.Fraction3
	       ,DR3.FinalTime
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
		  AND HH.HorseId IS NULL;
END

GO

