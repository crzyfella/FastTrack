IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_WorkoutHistoryInsert]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_WorkoutHistoryInsert]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_WorkoutHistoryInsert]
(
	@RaceIds VARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO kelso.brisnet_Workouts( HorseId
										,HorseName
										,WorkoutDate
										,WorkoutTrack
										,WorkoutDistance
										,WorkoutTime
										,WorkoutTrackCondition
										,WorkoutDescription
										,MainInnerTrackIndicator
										,NumberOfWorkouts
										,WorkoutRank
	)
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout1Date
		   ,DR.Workout1Track
		   ,DR.Workout1Distance
		   ,DR.Workout1Time
		   ,DR.WorkoutTrackCondition1
		   ,DR.Workout1Description
		   ,DR.MainInnerTrackIndicator1
		   ,DR.NumberOfWorkout1
		   ,DR.WorkoutRank1
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout1Date
									       AND W.WorkoutTrack = DR.Workout1Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout1Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout2Date
		   ,DR.Workout2Track
		   ,DR.Workout2Distance
		   ,DR.Workout2Time
		   ,DR.WorkoutTrackCondition2
		   ,DR.Workout2Description
		   ,DR.MainInnerTrackIndicator2
		   ,DR.NumberOfWorkout2
		   ,DR.WorkoutRank2
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout2Date
									       AND W.WorkoutTrack = DR.Workout2Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout2Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout3Date
		   ,DR.Workout3Track
		   ,DR.Workout3Distance
		   ,DR.Workout3Time
		   ,DR.WorkoutTrackCondition3
		   ,DR.Workout3Description
		   ,DR.MainInnerTrackIndicator3
		   ,DR.NumberOfWorkout3
		   ,DR.WorkoutRank3
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout3Date
									       AND W.WorkoutTrack = DR.Workout3Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout3Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout4Date
		   ,DR.Workout4Track
		   ,DR.Workout4Distance
		   ,DR.Workout4Time
		   ,DR.WorkoutTrackCondition4
		   ,DR.Workout4Description
		   ,DR.MainInnerTrackIndicator4
		   ,DR.NumberOfWorkout4
		   ,DR.WorkoutRank4
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout4Date
									       AND W.WorkoutTrack = DR.Workout4Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout4Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout5Date
		   ,DR.Workout5Track
		   ,DR.Workout5Distance
		   ,DR.Workout5Time
		   ,DR.WorkoutTrackCondition5
		   ,DR.Workout5Description
		   ,DR.MainInnerTrackIndicator5
		   ,DR.NumberOfWorkout5
		   ,DR.WorkoutRank5
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout5Date
									       AND W.WorkoutTrack = DR.Workout5Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout5Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout6Date
		   ,DR.Workout6Track
		   ,DR.Workout6Distance
		   ,DR.Workout6Time
		   ,DR.WorkoutTrackCondition6
		   ,DR.Workout6Description
		   ,DR.MainInnerTrackIndicator6
		   ,DR.NumberOfWorkout6
		   ,DR.WorkoutRank6
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout6Date
									       AND W.WorkoutTrack = DR.Workout6Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout6Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout7Date
		   ,DR.Workout7Track
		   ,DR.Workout7Distance
		   ,DR.Workout7Time
		   ,DR.WorkoutTrackCondition7
		   ,DR.Workout7Description
		   ,DR.MainInnerTrackIndicator7
		   ,DR.NumberOfWorkout7
		   ,DR.WorkoutRank7
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout7Date
									       AND W.WorkoutTrack = DR.Workout7Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout7Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout8Date
		   ,DR.Workout8Track
		   ,DR.Workout8Distance
		   ,DR.Workout8Time
		   ,DR.WorkoutTrackCondition8
		   ,DR.Workout8Description
		   ,DR.MainInnerTrackIndicator8
		   ,DR.NumberOfWorkout8
		   ,DR.WorkoutRank8
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout8Date
									       AND W.WorkoutTrack = DR.Workout8Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout8Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout9Date
		   ,DR.Workout9Track
		   ,DR.Workout9Distance
		   ,DR.Workout9Time
		   ,DR.WorkoutTrackCondition9
		   ,DR.Workout9Description
		   ,DR.MainInnerTrackIndicator9
		   ,DR.NumberOfWorkout9
		   ,DR.WorkoutRank9
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout9Date
									       AND W.WorkoutTrack = DR.Workout9Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout9Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout10Date
		   ,DR.Workout10Track
		   ,DR.Workout10Distance
		   ,DR.Workout10Time
		   ,DR.WorkoutTrackCondition10
		   ,DR.Workout10Description
		   ,DR.MainInnerTrackIndicator10
		   ,DR.NumberOfWorkout10
		   ,DR.WorkoutRank10
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout10Date
									       AND W.WorkoutTrack = DR.Workout10Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout10Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout11Date
		   ,DR.Workout11Track
		   ,DR.Workout11Distance
		   ,DR.Workout11Time
		   ,DR.WorkoutTrackCondition11
		   ,DR.Workout11Description
		   ,DR.MainInnerTrackIndicator11
		   ,DR.NumberOfWorkout11
		   ,DR.WorkoutRank11
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout11Date
									       AND W.WorkoutTrack = DR.Workout11Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout11Distance > 0
	UNION
	SELECT H.HorseId
		   ,DR.HorseName
		   ,DR.Workout12Date
		   ,DR.Workout12Track
		   ,DR.Workout12Distance
		   ,DR.Workout12Time
		   ,DR.WorkoutTrackCondition12
		   ,DR.Workout12Description
		   ,DR.MainInnerTrackIndicator12
		   ,DR.NumberOfWorkout12
		   ,DR.WorkoutRank12
	FROM kelso.brisnet_dr2 DR
	LEFT JOIN kelso.brisnet_Workouts W ON (W.HorseName = DR.HorseName
									       AND W.WorkoutDate = DR.Workout12Date
									       AND W.WorkoutTrack = DR.Workout12Track)
	JOIN kelso.brisnet_Horses H ON H.HorseName = DR.HorseName
	WHERE DR.RaceId IN (SELECT value FROM STRING_SPLIT(@RaceIds, ','))
	AND W.HorseId IS NULL
	AND DR.Workout12Distance > 0

END

GO

