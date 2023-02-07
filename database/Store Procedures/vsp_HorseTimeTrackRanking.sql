IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorseTimeTrackRanking]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorseTimeTrackRanking]
GO

CREATE PROCEDURE [kelso].[vsp_HorseTimeTrackRanking]
	@CalculateTime FLOAT,
	@TrackCd VARCHAR(25),
	@Distance FLOAT
AS
	SET NOCOUNT ON;

	SELECT ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((@CalculateTime - HS.AvgFinishTime) / HS.StdevFinishTime)) * 100.00, 2.0) PercentRanking
	FROM kelso.vw_HorseHistoryStats HS
	WHERE HS.TrackCd = @TrackCd
		  AND HS.Distance = @Distance;
GO







