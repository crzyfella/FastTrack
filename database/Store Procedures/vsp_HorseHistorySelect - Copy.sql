IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseHistorySelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseHistorySelect]
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistorySelect]
(
	@Id INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT HH.HorseHistoryID,
		   HH.HorseID,
		   HH.RaceDt,
		   HH.TrackCd,
		   HH.RaceNum,
		   HH.Distance,
		   HH.Furlong,
		   HH.InnerInd,
		   HH.TurfInd,
		   HH.TrackCondition,
		   HH.StateBredInd,
		   HH.Purse,
		   HH.ClaimingPrice,
		   HH.RaceClass,
		   HH.StkHandicapGrade,
		   HH.FirstCallTime,
		   HH.SecondCallTime,
		   HH.FinalTime,
		   HH.AdditionalFractionalTime,
		   HH.PostPosition,
		   HH.StartCallPosition,
		   HH.FirstCallPosition,
		   HH.SecondCallPosition,
		   HH.StretchCallPosition,
		   HH.FinalCallPosition,
		   HH.FirstCallBeatenLengths,
		   HH.SecondCallBeatenLengths,
	 	   HH.StretchCallBeatenLengths,
		   HH.FinalBeatenLengths,
		   HH.JockeyName,
		   HH.LasixInd,
		   HH.FavoriteFlagInd,
		   HH.PostTimeOdds,
		   HH.FavortismOddRanking,
		   HH.SpeedRating,
		   HH.TrackVariant,
		   HH.AdvancedSpeedFigure,
		   HH.PTSEarlyPaceRating,
		   HH.PTSLatePaceRating,
		   PTSTruePaceRating,
		   HH.TroubleLine,
		   HH.ExtendedTroubleLineInfo,
		   HH.NumberOfEntrants,
		   CASE
			WHEN HS.Furlong_5 IS NOT NULL THEN HS.Furlong_5
			WHEN HS.Distance = (660.0 * 5.0) THEN HS.FinishTime
		   END Furlong5,
		   CASE
			WHEN HS.Furlong_5 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_5 - STATS5.AvgFurlongTime) / STATS5.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 5.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS5.AvgFurlongTime) / STATS5.StdevFurlongTime)) * 100.0, 2)
		   END Furlong5RankingPerc,
		   CASE
			WHEN HS.Furlong_6 IS NOT NULL THEN HS.Furlong_6
			WHEN HS.Furlong = 6.0 THEN HS.FinishTime
		   END Furlong6,
		   CASE
			WHEN HS.Furlong_6 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_6 - STATS6.AvgFurlongTime) / STATS6.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 6.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS6.AvgFurlongTime) / STATS6.StdevFurlongTime)) * 100.0, 2)
		   END Furlong6RankingPerc,
		   CASE
			WHEN HS.Furlong_8 IS NOT NULL THEN HS.Furlong_8
			WHEN HS.Furlong = 8.0 THEN HS.FinishTime
		   END Furlong8,
		   CASE
			WHEN HS.Furlong_8 IS NOT NULL THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.Furlong_8 - STATS8.AvgFurlongTime) / STATS8.StdevFurlongTime)) * 100.0, 2)
			WHEN HS.Distance = (660.0 * 8.0) AND ISNULL(HS.FinishTime, 0.0) > 0.0 THEN ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS8.AvgFurlongTime) / STATS8.StdevFurlongTime)) * 100.0, 2)
		   END Furlong8RankingPerc,
		   HS.FinishTime,
		   STATS.AvgFinishTime,
		   STATS.MinFinishTime,
		   STATS.MaxFinishTime,
		   STATS.StdevFinishTime,
		   CASE
			WHEN ISNULL(STATS.StdevFinishTime, 0.0) = 0.0 THEN NULL
			ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - STATS.AvgFinishTime) / STATS.StdevFinishTime)) * 100, 2)
		   END FinishTimeRankingPerc,
		   HS.FirstCallPace,
		   HS.SecondCallPace,
		   HS.StretchCallPace,
		   HS.FinishCallPace
	FROM kelso.HorseHistory HH
		 JOIN kelso.HorseHistoryStats HS ON HS.HorseHistoryID = HH.HorseHistoryID
		 JOIN kelso.vw_HorseHistoryStatsTrackCondition STATS ON STATS.TrackCd = HH.TrackCd 
																AND STATS.Distance = HH.Distance 
																AND STATS.TurfInd = HH.TurfInd
																AND STATS.TrackCondition = HH.TrackCondition
		LEFT JOIN kelso.vw_5FurlongStats STATS5 ON STATS5.TrackCd = HH.TrackCd 
																AND STATS5.TurfInd = HH.TurfInd
																AND STATS5.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 5.0) OR HH.Furlong5 IS NOT NULL)
		LEFT JOIN kelso.vw_6FurlongStats STATS6 ON STATS6.TrackCd = HH.TrackCd 
																AND STATS6.TurfInd = HH.TurfInd
																AND STATS6.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 6.0) OR HH.Furlong6 IS NOT NULL)
		LEFT JOIN kelso.vw_8FurlongStats STATS8 ON STATS8.TrackCd = HH.TrackCd 
																AND STATS8.TurfInd = HH.TurfInd
																AND STATS8.TrackCondition = HH.TrackCondition
																AND (HH.Distance = (660.0 * 8.0) OR HH.Furlong8 IS NOT NULL)
	WHERE HH.HorseID = @Id
	ORDER BY HH.RaceDt;

END

GO









