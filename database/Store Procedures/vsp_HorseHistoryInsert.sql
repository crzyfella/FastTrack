IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseHistoryInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseHistoryInsert]
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistoryInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.HorseHistory
	SELECT (SELECT HorseID FROM kelso.Horses WHERE HorseName = S.HorseName) HorseID,
		   S.HorseName,
		   S.PaceLineDt RaceDt,
		   S.PaceLineTrackCd TrackCd,
		   S.PaceLineRaceNum RaceNum,
		   S.PaceLineDistance Distance,
		   (ROUND(S.PaceLineDistance / 660.00, 2)) Furlong,
		   S.InnerInd,
		   S.TurfInd,
		   S.TrackCondition,
		   S.StateBredInd,
		   S.ClassString,
		   S.ExtendedClassInfo,
		   S.Purse,
		   S.ClaimingPrice,
		   S.RaceClass,
		   S.StkHandicapGrade,
		   S.FirstCallTime,
		   S.SecondCallTime,
		   S.FinalTime,
		   S.AdditionalFractionalTime,
		   S.PostPosition, 
		   S.StartCallPosition,
		   S.FirstCallPosition,
		   S.SecondCallPosition,
		   S.StretchCallPosition,
		   S.FinalCallPosition,
		   S.FirstCallBeatenLengths,
		   S.SecondCallBeatenLengths,
		   S.StretchCallBeatenLengths,
		   S.FinalBeatenLengths,
		   CASE
			WHEN S.PaceLineDistance < (660.0 * 8.0) THEN S.FirstCallTime
			WHEN S.PaceLineDistance BETWEEN (660.0 * 8.0) AND (660.0 * 8.5) THEN S.AdditionalFractionalTime
		   END Furlong2,
		   CASE
			WHEN S.PaceLineDistance > 0 THEN 0
		   END Furlong3,
		   CASE
			WHEN S.PaceLineDistance < (660.0 * 8.0) THEN S.SecondCallTime
			WHEN S.PaceLineDistance >= (660.0 * 8.0) THEN S.FirstCallTime
		   END Furlong4,
		   CASE
			WHEN S.PaceLineDistance BETWEEN (660.0 * 5.5) AND (660.0 * 6.0) THEN S.AdditionalFractionalTime
		   END Furlong5,
		   CASE
			WHEN S.PaceLineDistance BETWEEN (660.0 * 6.5) AND (660.0 * 7.5) THEN S.AdditionalFractionalTime
			WHEN S.PaceLineDistance >= (660.0 * 8.0) THEN S.SecondCallTime
		   END Furlong6,
		   CASE
			WHEN S.PaceLineDistance > (660.0 * 8.5) THEN S.AdditionalFractionalTime
		   END Furlong8,
		   S.FinalTime FinnishTime,
		   NULL RankingPercentage,
		   S.JockeyName,
		   S.LasixInd,
		   S.FavoriteFlagInd,
		   S.PostTimeOdds,
		   S.FavortismOddRanking,
		   S.SpeedRating,
		   S.TrackVariant,
		   S.AdvancedSpeedFigure,
		   S.PTSEarlyPaceRating,
		   S.PTSLatePaceRating,
		   S.PTSTruePaceRating,
		   S.TroubleLine,
		   S.ExtendedTroubleLineInfo,
		   S.NumberOfEntrants
	FROM kelso.hor_staging S
	WHERE NOT EXISTS (SELECT *
					  FROM kelso.HorseHistory HH
					  WHERE HH.HorseName = S.HorseName
							AND HH.TrackCd = S.PaceLineTrackCd
							AND HH.RaceDt = S.PaceLineDt);
END
  
GO


