IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_WorkoutHistoryStatsSelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_WorkoutHistoryStatsSelect]
GO

CREATE PROCEDURE [kelso].[vsp_WorkoutHistoryStatsSelect]
(
	@HorseID INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH CTE AS
	(
		SELECT *
		FROM kelso.WorkoutHistory 
		WHERE HorseID = @HorseID
			  AND WorkOutDt <= @RaceDt
	)
	SELECT C.WorkoutHistoryID,
			C.HorseID,
			C.WorkOutDt,
			C.TrackCd,
			C.Distance,
			C.Furlong,
			C.TurfInd,
			C.TrackCond,
			C.WorkOutTime,
			ROUND(1.0 - kelso.fn_GetNormalDistributionCalc((C.WorkOutTime - S.WorkoutTimeAvg) / S.WorkoutTimeStdv), 2) WorkoutRankingPerc,
			S.WorkoutTimeAvg,
			S.WorkoutTimeMin,
			S.WorkoutTimeMax,
			S.WorkoutTimeStdv,
			C.BreezingInd,
			C.BulletInd
	FROM CTE C
			JOIN kelso.vw_WorkoutStats S ON S.TrackCd = C.TrackCd 
										    AND S.Distance = C.Distance 
											AND S.TrackCond = C.TrackCond 
											AND S.TurfInd = C.TurfInd
	ORDER BY C.WorkOutDt DESC;
END

GO






