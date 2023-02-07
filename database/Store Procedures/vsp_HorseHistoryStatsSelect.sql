IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseHistoryStatsSelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseHistoryStatsSelect]
GO

CREATE PROCEDURE [kelso].[vsp_HorseHistoryStatsSelect]
(
	@HorseID INT
)
AS
BEGIN
	SET NOCOUNT ON;

	WITH CTE AS
	(
		SELECT *
		FROM kelso.HorseHistoryStats
		WHERE HorseID = @HorseID
	)
	SELECT HS.*,
		   C.AvgFinishTime,
		   C.MinFinishTime,
		   C.MaxFinishTime,
		   C.StdevFinishTime,
		   CASE
			WHEN ISNULL(StdevFinishTime, 0.0) = 0.0 THEN NULL
			ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((HS.FinishTime - C.AvgFinishTime) / C.StdevFinishTime)) * 100.00, 2)
		   END PercentRanking
	FROM CTE HS
		 JOIN kelso.vw_HorseHistoryStatsTrackCondition C ON C.TrackCd = HS.TrackCd
															AND C.Distance = HS.Distance
															AND C.TurfInd = HS.TurfInd
															AND C.TrackCondition = HS.TrackCondition
	ORDER BY HS.RaceDt;

END

GO






