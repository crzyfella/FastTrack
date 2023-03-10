IF EXISTS (SELECT * FROM sysobjects 
      WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_dr3Insert]') 
       AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
 DROP PROCEDURE [kelso].[vsp_brisnet_dr3Insert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_dr3Insert]
AS
BEGIN
	INSERT INTO kelso.brisnet_dr3 ([DRFId]
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
	SELECT (SELECT DRFId FROM kelso.brisnet_drf WHERE TrackCd = [SOURCE].[TrackCd] AND [RaceDt] = CAST([SOURCE].[RaceDt] AS DATETIME) AND RaceNum = CAST([SOURCE].[RaceNum] AS INT))
			,GETDATE()
			,GETDATE()
			,[SOURCE].[TrackCd]
			,CAST([SOURCE].[RaceDt] AS DATETIME)
			,CAST([SOURCE].[RaceNum] AS INT)
			,NULL --(SELECT Id FROM kelso.brisnet_horses WHERE [HorseName] IN (SELECT [HorseName] FROM kelso.brisnet_dr2 WHERE TrackCd = [SOURCE].[TrackCd] AND [RaceDt] = CAST([SOURCE].[RaceDt] AS DATETIME) AND RaceNum = CAST([SOURCE].[RaceNum] AS INT) AND [PostPosition] = CAST([SOURCE].[PostPosition] AS INT)))
			,NULL --(SELECT [HorseName] FROM kelso.brisnet_dr2 WHERE TrackCd = [SOURCE].[TrackCd] AND [RaceDt] = CAST([SOURCE].[RaceDt] AS DATETIME) AND RaceNum = CAST([SOURCE].[RaceNum] AS INT) AND [PostPosition] = [SOURCE].[PostPosition])
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
			,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthLdrMargin] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[StartCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StartCallBtnLngthsOnly] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthLdrMargin] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[FirstCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FirstCallBtnLngthsOnly] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthLdrMargin] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[SecondCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[SecondCallBtnLngthsOnly] AS DECIMAL(18,2)) END 
			,[SOURCE].[Reserved50]
			,[SOURCE].[Reserved51]
			,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthLdrMargin] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[StretchBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[StretchBtnLngthsOnly] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[FinishBtnLngthLdrMargin], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishBtnLngthLdrMargin] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[FinishCallBtnLngthsOnly], '') = '' THEN 0 ELSE CAST([SOURCE].[FinishCallBtnLngthsOnly] AS DECIMAL(18,2)) END 
			,CASE WHEN ISNULL([SOURCE].[BrisRaceShapeSecondCall], '') = '' THEN 0 ELSE CAST([SOURCE].[BrisRaceShapeSecondCall] AS DECIMAL(18,2)) END 
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
			,CASE WHEN ISNULL([SOURCE].[LowClaimingPriceOfRace], '') = '' THEN 0 ELSE [SOURCE].[LowClaimingPriceOfRace] END
			,CASE WHEN ISNULL([SOURCE].[HighClaimingPriceOfRace], '') = '' THEN 0 ELSE [SOURCE].[HighClaimingPriceOfRace] END
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
		FROM kelso.brisnet_dr3_staging [SOURCE]
			LEFT JOIN kelso.brisnet_dr3 [TARGET] ON [TARGET].[TrackCd] = [SOURCE].[TrackCd]
												   AND [TARGET].[RaceDt] = CAST([SOURCE].[RaceDt] AS DATETIME)
												   AND [TARGET].[RaceNum] = CAST([SOURCE].[RaceNum] AS INT)
												   AND [TARGET].[PostPosition] = [SOURCE].[PostPosition]
		WHERE [TARGET].[TrackCd] IS NULL;
END

GO



