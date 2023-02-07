IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_PredictedTimeHorseHistorySelect]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_PredictedTimeHorseHistorySelect]
GO

CREATE PROCEDURE [kelso].[vsp_PredictedTimeHorseHistorySelect]
(
	@HorseID INT,
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT *
	FROM [kelso].[vw_HorseHistoryPercentageRanking]
	WHERE HorseID = @HorseID
		  AND RaceDt < @RaceDt
	ORDER BY RaceDt;

END

GO






