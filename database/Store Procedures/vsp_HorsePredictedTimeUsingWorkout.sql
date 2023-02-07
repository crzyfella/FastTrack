IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_HorsePredictedTimeUsingWorkout]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_HorsePredictedTimeUsingWorkout]
GO

CREATE PROCEDURE [kelso].[vsp_HorsePredictedTimeUsingWorkout]
	@HorseID INT,
	@TrackCd VARCHAR(25),
	@RaceDt DATETIME,
	@TurfInd INT,
	@Distance FLOAT,
	@PredictedTime FLOAT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @MinDistance FLOAT = 0.0;
	DECLARE @MaxDistance FLOAT = 0.0;
	DECLARE @MinTime FLOAT = 0.0;
	DECLARE @MaxTime FLOAT = 0.0;
	DECLARE @Slope FLOAT = 0.0;

	SET @PredictedTime = 0.0;
	
	WITH CTE AS
	(
		SELECT TrackCd,
			   Distance,
			   AVG(WorkOutTime) WorkoutTime
		FROM kelso.WorkoutHistory
		WHERE HorseID = @HorseID
			AND TrackCd = @TrackCd
		GROUP BY TrackCd, Distance
	)
	SELECT @MaxDistance = MAX(Distance / 660.0),
		   @MinDistance = MIN(Distance / 660.0),
		   @MinTime = MIN(WorkoutTime),
		   @MaxTime = MAX(WorkoutTime)
	FROM CTE;

	IF @MaxDistance IS NULL AND @MinDistance IS NULL
	BEGIN
		WITH CTE AS
		(
			SELECT TrackCd,
					Distance,
					AVG(WorkOutTime) WorkoutTime
			FROM kelso.WorkoutHistory
			WHERE HorseID = @HorseID
			GROUP BY TrackCd, Distance
		)
		SELECT @MaxDistance = MAX(Distance / 660.0),
			   @MinDistance = MIN(Distance / 660.0),
			   @MinTime = MIN(WorkoutTime),
			   @MaxTime = MAX(WorkoutTime)
		FROM CTE;
	END 

	IF @MaxDistance = @MinDistance
	BEGIN
		SELECT @PredictedTime = @MaxTime;		
	END
	ELSE
	BEGIN
		SET @Slope = (LOG10(@MaxTime) - LOG10(@MinTime)) / (LOG10(@MaxDistance) - LOG10(@MinDistance));
		SELECT @PredictedTime = POWER(10.00000, (@Slope * (LOG10(@Distance / 660.0) - LOG10(@MinDistance))) + LOG10(@MinTime));
	END

	DECLARE @AdjustedPredictedTime FLOAT = 0.0;
	SELECT @AdjustedPredictedTime = (@PredictedTime * PercentageDiff)
	FROM [kelso].[vw_PercentageDiffWorkoutRacesTrack]
	WHERE TrackCd = @TrackCd
		AND Distance = @Distance;

	IF @AdjustedPredictedTime = 0.0 OR @AdjustedPredictedTime IS NULL
	BEGIN
		SELECT @AdjustedPredictedTime = @PredictedTime * PercDiff
		FROM [kelso].[vw_PercentageDiffWorkoutRaces]
		WHERE Distance = @Distance;
	END
	
	IF @AdjustedPredictedTime != 0.0
	BEGIN
		SET @PredictedTime = @AdjustedPredictedTime;
	END

	RETURN @PredictedTime;
END
  
GO