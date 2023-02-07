IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_brisnet_Program') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_brisnet_Program]
GO

CREATE PROCEDURE [kelso].[vsp_brisnet_Program]
(
	@TrackCd VARCHAR(50),
	@RaceDt DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @perLength DECIMAL (18,2) = 0.20;

	DECLARE @Races TABLE
	( 
		RaceDt DATETIME,
		TrackCd VARCHAR(25),
		TrackName VARCHAR(50),
		RaceNum INT,
		Distance DECIMAL(18, 2),
		Furlong DECIMAL(10, 2),
		Surface VARCHAR(10),
		RaceType VARCHAR(100),
		RaceCondition VARCHAR(MAX)
	);

	DECLARE @Horses TABLE
	(
		Id INT,
		HorseName VARCHAR(100)
	);

	DECLARE @Program TABLE
	(
		RaceNum INT,
		Race NVARCHAR(MAX)
	);

	INSERT INTO @Races
	SELECT DRF.RaceDt,
			T.TrackCd,
			T.TrackName,
			DRF.RaceNum,
			DRF.Distance,
			CAST((DRF.Distance / 220.00) AS DECIMAL(10, 2)) Furlong,
			DRF.Surface,
			DRF.Reserved9 RaceType,
			DRF.RaceConditions
	FROM kelso.brisnet_drf DRF
	JOIN kelso.brisnet_Tracks T ON T.TrackCd = DRF.TrackCd
	WHERE DRF.TrackCd = @TrackCd
	AND DRF.RaceDt = @RaceDt
	ORDER BY DRF.RaceNum;

	DECLARE @numOfRaces INT = 0;
	DECLARE @cnt INT = 1;

	SELECT @numOfRaces = COUNT(1)
	FROM @Races;

	WHILE @cnt <= @numOfRaces
	BEGIN
		DELETE FROM @Horses;
		DECLARE @xmlRace NVARCHAR(MAX) = '<Race>';

		DECLARE @xmlInfo NVARCHAR(MAX) =
		(
			SELECT *
			FROM @Races
			WHERE RaceNum = @cnt
			FOR XML PATH('Info')
		);

		SET @xmlRace = @xmlRace + @xmlInfo;

		INSERT INTO @Horses
		SELECT ROW_NUMBER() OVER(ORDER BY PostPosition) Id, HorseName
		FROM kelso.brisnet_dr2
		WHERE RaceDt = @RaceDt
			  AND TrackCd = @TrackCd
			  AND RaceNum = @cnt;
	
		DECLARE @numOfHorses INT = NULL;
		DECLARE @HorseId INT = 1;
		DECLARE @xmlHorses VARCHAR(MAX) = '<Horses>';

		SELECT @numOfHorses = COUNT(1)
		FROM @Horses;

		WHILE @HorseId <= @numOfHorses
		BEGIN
			DECLARE @HorseName VARCHAR(100) = (SELECT HorseName FROM @Horses WHERE Id = @HorseId);

			DECLARE @Info NVARCHAR(MAX) = 
			(
				SELECT PostPosition,
					   HorseName,
					   Jockey,
					   JockeyRecordCurrentYear,
					   JockeyRecordPreviousYear,
					   Trainer,
					   TrainerRecordCurrentYear,
					   TrainerRecordPreviousYear
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					  AND TrackCd = @TrackCd
					  AND HorseName = @HorseName
				ORDER BY RaceNum, PostPosition
				FOR XML PATH('INFO')
			);

			DECLARE @PastPerformance NVARCHAR(MAX) =
			(
				SELECT PreviousRaceDate RaceDt,
					   PreviousTrackCd TrackCd,
					   TrackCondition,
					   CAST((Distance / 220.00) AS DECIMAL(10,2)) Furlong,
					   CASE
						WHEN ISNUMERIC(ISNULL(Fraction1, 'K')) = 0 OR ISNUMERIC(ISNULL(FirstCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FirstCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FirstCallPosition = 1 THEN Fraction1
						ELSE CAST(Fraction1 AS DECIMAL(18, 2)) + (CAST(FirstCallBtnLngthsOnly AS DECIMAL(18,2)) * @perLength)
					   END FirstCall,
					   CASE
						WHEN ISNUMERIC(ISNULL(Fraction2, 'K')) = 0 OR ISNUMERIC(ISNULL(SecondCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(SecondCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN SecondCallPosition = 1 THEN Fraction2
						ELSE Fraction2 + (SecondCallBtnLngthsOnly * @perLength)
					   END SecondCall,
					   CASE
						WHEN ISNUMERIC(ISNULL(Fraction3, 'K')) = 0 OR ISNUMERIC(ISNULL(StretchCallPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(StretchBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN StretchCallPosition = 1 THEN Fraction3
						ELSE Fraction3 + (StretchBtnLngthsOnly * @perLength)
					   END StretchCall,
					   CASE
						WHEN ISNUMERIC(ISNULL(FinalTime, 'K')) = 0 OR ISNUMERIC(ISNULL(FinishPosition, 'K')) = 0  OR ISNUMERIC(ISNULL(FinishCallBtnLngthsOnly, 'K')) = 0 THEN NULL
						WHEN FinishPosition = 1 THEN FinalTime
						ELSE FinalTime + (FinishCallBtnLngthsOnly * @perLength)
					   END FinalCall,
					   RaceClassification,
					   Purse,
					   BrisSpeedRating,
					   PreviousPostPosition,
					   StartCallPosition
					   FirstCallPosition,
					   FirstCallBtnLngthsOnly,
					   SecondCallPosition,
					   SecondCallBtnLngthsOnly
					   StretchCallPosition,
					   StretchBtnLngthsOnly,
					   FinishPosition,
					   FinishCallBtnLngthsOnly,
					   SpeedRating + '-' + TrackVariant SpeedRating,
					   WinnerName,
					   WinnerWeight,
					   WinnerMargin,
					   SecondPlaceFinisherName,
					   SecondPlaceWeight,
					   SecondPlaceMargin,
					   ThirdPlaceFinisherName,
					   ThirdPlaceWeight,
					   ThirdPlaceMargin,
					   TripComment,
					   ExtendedStartComment
				FROM kelso.brisnet_dr3
				WHERE RaceDt = @RaceDt
					  AND TrackCd = @TrackCd
					  AND HorseName = @HorseName
				ORDER BY RaceNum, PostPosition, PreviousRaceDate DESC
				FOR XML PATH('PastPerformance'), ROOT('PastPerformances')
			);

			DECLARE @Workout NVARCHAR(MAX) = '';
			WITH WorkoutCTE AS
			(
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout1Date WorkoutDate,
					   Workout1Track WorkoutTrack,
					   Workout1Time WorkoutTime,
					   WorkoutTrackCondition1 WorkoutTrackCondition,
					   Workout1Description WorkoutDescription,
					   WorkoutRank1 + '/' + NumberOfWorkout1 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName 
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout2Date,
					   Workout2Track,
					   Workout2Time,
					   WorkoutTrackCondition2,
					   Workout2Description,
					   WorkoutRank2 + '/' + NumberOfWorkout2 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout3Date,
					   Workout3Track,
					   Workout3Time,
					   WorkoutTrackCondition3,
					   Workout3Description,
					   WorkoutRank3 + '/' + NumberOfWorkout3 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout4Date,
					   Workout4Track,
					   Workout4Time,
					   WorkoutTrackCondition4,
					   Workout4Description,
					   WorkoutRank4 + '/' + NumberOfWorkout4 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout5Date,
					   Workout5Track,
					   Workout5Time,
					   WorkoutTrackCondition5,
					   Workout5Description,
					   WorkoutRank5 + '/' + NumberOfWorkout5 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout6Date,
					   Workout6Track,
					   Workout6Time,
					   WorkoutTrackCondition6,
					   Workout6Description,
					   WorkoutRank6 + '/' + NumberOfWorkout6 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout7Date,
					   Workout7Track,
					   Workout7Time,
					   WorkoutTrackCondition7,
					   Workout7Description,
					   WorkoutRank7 + '/' + NumberOfWorkout7 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout8Date,
					   Workout8Track,
					   Workout8Time,
					   WorkoutTrackCondition8,
					   Workout8Description,
					   WorkoutRank8 + '/' + NumberOfWorkout8 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout9Date,
					   Workout9Track,
					   Workout9Time,
					   WorkoutTrackCondition9,
					   Workout9Description,
					   WorkoutRank9 + '/' + NumberOfWorkout9 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout10Date,
					   Workout10Track,
					   Workout10Time,
					   WorkoutTrackCondition10,
					   Workout10Description,
					   WorkoutRank10 + '/' + NumberOfWorkout10 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout11Date,
					   Workout11Track,
					   Workout11Time,
					   WorkoutTrackCondition11,
					   Workout11Description,
					   WorkoutRank11 + '/' + NumberOfWorkout11 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
				UNION
				SELECT TrackCd,
					   RaceDt,
					   RaceNum,
					   PostPosition,
					   HorseName,
					   Workout12Date,
					   Workout12Track,
					   Workout12Time,
					   WorkoutTrackCondition12,
					   Workout12Description,
					   WorkoutRank12 + '/' + NumberOfWorkout12 WorkoutRanking
				FROM kelso.brisnet_dr2
				WHERE RaceDt = @RaceDt
					AND TrackCd = @TrackCd
					AND HorseName = @HorseName
			)
			SELECT @Workout =
			(
				SELECT WorkoutDate,
					   WorkoutTrack,
					   WorkoutTime,
					   WorkoutTrackCondition,
					   WorkoutDescription,
					   WorkoutRanking
				FROM WorkoutCTE
				ORDER BY RaceNum, PostPosition, WorkoutDate DESC
				FOR XML PATH('Workout'), ROOT('Workouts')
			);

			SET @xmlHorses = @xmlHorses + '<Horse>' + @Info + ISNULL(@PastPerformance, '<PastPerformances />') + @Workout + '</Horse>';
			SET @HorseId = @HorseId + 1;
		END

		SET @xmlHorses = @xmlHorses + '</Horses>';
		SET @xmlRace = ISNULL(@xmlRace, '') + @xmlHorses + '</Race>';

		INSERT INTO @Program (RaceNum, Race)
		SELECT @cnt, @xmlRace;

		SET @cnt = @cnt + 1;
	END

	SELECT RaceNum, Race
	FROM @Program;

END

GO









