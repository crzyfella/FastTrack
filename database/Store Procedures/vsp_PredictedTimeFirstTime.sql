IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_PredictedTimeFirstTime]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_PredictedTimeFirstTime]
GO

CREATE PROCEDURE [kelso].[vsp_PredictedTimeFirstTime]
(
	@HorseID INT,
	@RaceDt DATETIME,
	@RaceNum INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Pace DECIMAL = NULL;
	DECLARE @Distance FLOAT = NULL;
	DECLARE @TurfInd INT = NULL;
	DECLARE @RaceClass INT = NULL;
	DECLARE @RaceID INT = NULL;
	DECLARE @TrackCd NVARCHAR(3) = NULL;
	DECLARE @PolePosition VARCHAR(20) = NULL;
	DECLARE @PredictedTime FLOAT = 0.0;

	SELECT @RaceID = RacID,
		   @Distance = Distance,
		   @TurfInd = TurfInd,
		   @RaceClass = RaceClass,
		   @TrackCd = TrackCd
	FROM kelso.rac
	WHERE RaceDt = @RaceDt
		AND RaceNum = @RaceNum; 

	SELECT @PolePosition = PolePosition
	FROM kelso.ent
	WHERE RacID = @RaceID
		AND HorseID = @HorseID;

	SELECT @Pace = ROUND(AVG(Distance / WorkOutTime), 3)
	FROM kelso.WorkoutHistory
	WHERE HorseID = @HorseID
		AND TrackCd = @TrackCd;

	IF @Pace IS NULL
	BEGIN
		SELECT TOP 1 @Pace = ROUND(AVG(Distance / WorkOutTime), 3)
		FROM kelso.WorkoutHistory
		WHERE TrackCd IN (
							SELECT TrackCd
							FROM kelso.WorkoutHistory
							WHERE HorseID = @HorseID
						 );
	END

	IF @Pace IS NOT NULL
	BEGIN
		WITH CTE AS
		(
			SELECT *
			FROM kelso.WorkoutHistory
			WHERE ISNULL(WorkOutTime, 0) != 0
				AND TrackCd = @TrackCd 
		)
		SELECT @PredictedTime = AVG(FinnishTime)
		FROM kelso.HorseHistory
		WHERE HorseID IN
			(
				SELECT HorseID
				FROM CTE C
				WHERE ROUND((Distance / WorkOutTime), 3) BETWEEN (@Pace - 0.1) AND (@Pace + 0.1)
			)
			AND TrackCd = @TrackCd
			AND Distance = @Distance
			AND TurfInd = @TurfInd
			AND PostPosition = @PolePosition
			AND RaceClass = @RaceClass;
	END
	
	SELECT @PredictedTime;
END

GO






