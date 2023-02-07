IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_WorkoutHistoryInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_WorkoutHistoryInsert]
GO

CREATE PROCEDURE [kelso].[vsp_WorkoutHistoryInsert]
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.WorkoutHistory
	SELECT (SELECT HorseID FROM kelso.Horses WHERE HorseName = W.HorseName),
		   W.HorseName,
		   W.WorkOutDt,
		   W.WorkOutTrack,
		   W.WorkOutDistance,
		   ROUND(W.WorkOutDistance / 660.0, 2),
		   W.TurfInd,
		   W.TrainingTrackInd,
		   W.WorkOutTrackCond,
		   W.WorkOutTime,
		   W.BulletInd,
		   W.BreezingInd,
		   W.WorkOutRank,
		   W.WorkOutTotalNum
	FROM kelso.wor_staging W
	WHERE NOT EXISTS (
						SELECT *
						FROM kelso.WorkoutHistory 
						WHERE HorseName = W.HorseName
							  AND TrackCd = W.WorkOutTrack
							  AND WorkOutDt = W.WorkOutDt
					 );

END
  
GO


