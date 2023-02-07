DECLARE @TrackCd VARCHAR(10) = 'SA';
DECLARE @RaceDt DATE = '01/22/2023';
DECLARE @NumberOfStart INT = 11;
DECLARE @FirstTimeJockeyScore DECIMAL(12,2) = 40.0;
DECLARE @FirstTimeTrainerScore DECIMAL(12,2) = 10.0;
DECLARE @FirstTimeWorkoutScore DECIMAL(12,2) = 40.0;
DECLARE @FirstTimeBettingLineScore DECIMAL(12,2) = 10.0;
DECLARE @JockeyScore DECIMAL(12,2) = 20.0;
DECLARE @TrainerScore DECIMAL(12,2) = 10.0;
DECLARE @WorkoutScore DECIMAL(12,2) = 5.0;                              
DECLARE @BettingLineScore DECIMAL(12,2) = 5.0;
DECLARE @ClaimScore DECIMAL(12,2) = 5.0;
DECLARE @CloserScore DECIMAL(12,2) = 5.0;
DECLARE @FastTrackScore DECIMAL(12,2) = 40.0;
DECLARE @TimePlacementScore DECIMAL(12,2) = 10.0;
                                                                                                                                                         

DECLARE @MaxRaceNum INT = 0;
SELECT @MaxRaceNum = MAX(P.RaceNum)
FROM kelso.Process P	          
WHERE P.TrackCd = @TrackCd
	AND P.RaceDt = @RaceDt;                                                                                                                                                         
	                                                                                                                                             
DECLARE @Result TABLE
(
	TrackCd VARCHAR(3),
	RaceDt DATETIME,
	RaceNum INT,
	HorseName VARCHAR(75),
	PolePosition VARCHAR(10),
	CompositeScore DECIMAL(18,2)                                        
);

DECLARE @cnt INT = 1;

WHILE @cnt <= @MaxRaceNum
BEGIN                                              
	DECLARE @RaceNum INT = @cnt;

	WITH mainCTE AS
	(	
		SELECT P.*,
			   CASE
				WHEN ISNULL(P.CalculateTimeUsingPaceOverallAvg, 0.0) = 0.0 THEN NULL
				ELSE ROUND((1.0 - kelso.fn_GetNormalDistributionCalc((p.CalculateTimeUsingPaceOverallAvg - HS.AvgFinishTime) / HS.StdevFinishTime)) * 100.00, 2.0)
			   END PercentRanking
		FROM kelso.Process P
			 JOIN kelso.vw_HorseHistoryStats HS ON HS.TrackCd = P.TrackCd
												   AND HS.Distance = P.Distance
		WHERE P.TrackCd = @TrackCd
		AND P.RaceDt = @RaceDt
		AND RaceNum = @RaceNum
	),
	favoriteCTE AS
	(
		SELECT TOP 1 *
		FROM mainCTE
		ORDER BY BettingLine
	),
	numOfHorsesCTE AS
	(
		SELECT RaceNum, COUNT(1) NumOfHorses
		FROM mainCTE
		GROUP BY RaceNum
	),
	bettingLineSortCTE AS
	(
		SELECT ROW_NUMBER() OVER (ORDER BY BettingLine DESC) AS rn, 
			   HorseID, 
			   BettingLine,
			   CONVERT(DECIMAL(6,3), (ROW_NUMBER() OVER (ORDER BY BettingLine DESC)) / CONVERT(DECIMAL(6,3), (SELECT COUNT(1) FROM mainCTE))) Perc 
		FROM mainCTE
	),
	etcCTE AS
	(
		SELECT HorseId, 
		(
			CASE
				WHEN LifetimeTop3Finish > 0 THEN 1
				ELSE 0
			END 
			+
			CASE 
				WHEN TurfInd = 1 AND TurfStarts > 0 THEN 1
				WHEN TurfInd = 0 AND NonTurfStarts > 0 THEN 1
				ELSE 0
			END
			+
			CASE
				WHEN DistanceStart > 0 THEN 1
				ELSE 0
			END
			+
			DistanceTop3Finishes
			+
			CASE 
				WHEN TrackStart > 0 THEN 1
				ELSE 0
			END
		) etcPoint
		FROM mainCTE
	),
	workoutCTE AS
	(
		SELECT HorseId,
			   CASE
				WHEN WorkoutAvgCurrentMonth > WorkoutAvgPreviousMonth THEN WorkoutAvgCurrentMonth
				ELSE WorkoutAvgPreviousMonth 
			   END WorkoutPerc
		FROM mainCTE
	),
	previousRaceClassCTE AS
	(
		SELECT P.*
		FROM kelso.HorseHistory P
			 JOIN 
			 (
				SELECT H.HorseID, MAX(H.RaceDt) RaceDt
				FROM mainCTE M
					 JOIN kelso.HorseHistory H ON H.HorseID = M.HorseID AND H.RaceDt < M.RaceDt
				GROUP BY H.HorseID
			) PP ON PP.HorseID = P.HorseID AND PP.RaceDt = P.RaceDt
	),
	HorseHistoryCTE AS
	(
		SELECT M.HorseID,
			   M.RaceDt,
			   R.RaceClass,
			   R.RacePurse,
			   P.RaceClass PreviousRaceClass,
			   IIF(P.ClaimingPrice = 0, P.Purse, P.ClaimingPrice) PreviousPurse
		FROM mainCTE M
			 JOIN kelso.rac R ON R.TrackCd = M.TrackCd AND R.RaceDt = M.RaceDt AND R.RaceNum = M.RaceNum
			 JOIN previousRaceClassCTE P ON P.HorseID = M.HorseID	
	),
	maxJockeyCTE AS
	(
		SELECT 1 Id,
			   MAX(CASE
					WHEN JockeyStarts >= 10 THEN JockeyWinningPerc
					ELSE JockeyLifetimeWinningPerc
				   END) JockeyPercentage,
			   MAX(TrainerLifetimeWinningPerc)TrainerLifetimeWinningPercentage
		FROM mainCTE
	),
	processCTE AS
	(
		SELECT M.TrackCd,
			   M.RaceDt,
			   M.RaceNum,
			   M.HorseName,
			   M.PolePosition,
			   (
			   CASE 
				WHEN M.LifetimeStarts > 0 THEN
				   CASE
					WHEN M.JockeyStarts >= 10 THEN M.JockeyWinningPerc / J.JockeyPercentage
					ELSE M.JockeyLifetimeWinningPerc / J.JockeyPercentage
				   END * @JockeyScore  -- JOCKEY SCORE 
				ELSE
				   CASE
					WHEN M.JockeyStarts >= 10 THEN M.JockeyWinningPerc / J.JockeyPercentage
					ELSE M.JockeyLifetimeWinningPerc / J.JockeyPercentage
				   END * @FirstTimeJockeyScore  -- JOCKEY SCORE FIRST TIME 
				END
			   + 
			   CASE 
				WHEN M.LifetimeStarts > 0 THEN
					(M.TrainerLifetimeWinningPerc / J.TrainerLifetimeWinningPercentage) * @TrainerScore -- TRAINER SCORE
				ELSE
					(M.TrainerLifetimeWinningPerc / J.TrainerLifetimeWinningPercentage) * @FirstTimeTrainerScore -- TRAINER SCORE FIRST TIME
			   END
			   +  
			   (ISNULL(PercentRanking, 0) / 100) * @TimePlacementScore
			   +
			   CASE 
				WHEN M.LifetimeStarts > 0 THEN
					W.WorkoutPerc * @WorkoutScore -- WORKOUT SCORE
				ELSE
					W.WorkoutPerc * @FirstTimeWorkoutScore -- WORKOUT SCORE FIRST TIME 
			   END
			   +
			   CASE
				WHEN H.RaceClass < H.PreviousRaceClass THEN @ClaimScore
				WHEN H.RaceClass = H.PreviousRaceClass THEN 0
				WHEN H.RaceClass > H.PreviousRaceClass THEN -1 * @ClaimScore
				ELSE 0
			   END
			   +
			   (ISNULL(AdvancedSpeedFigure, 0) / 100) * @FastTrackScore 
			   +
			   CASE
				WHEN M.LifetimeStarts > 0 THEN
					B.Perc * @BettingLineScore -- BETTING LINE SCORE
				ELSE
					B.Perc * @FirstTimeBettingLineScore -- BETTING LINE SCORE FIRST TIME 
			   END
			   ) CompositeScore
		FROM mainCTE M
			 JOIN maxJockeyCTE J ON J.Id = 1
			 JOIN workoutCTE W ON W.HorseID = M.HorseID
			 LEFT JOIN HorseHistoryCTE H ON H.HorseID = M.HorseID
			 JOIN bettingLineSortCTE B ON B.HorseID = M.HorseID
	)
	INSERT INTO @Result
	SELECT TrackCd,
		   RaceDt,
		   RaceNum,
		   
		   HorseName,
		   PolePosition,
		   CompositeScore
	FROM processCTE
	ORDER BY CompositeScore DESC;

	SET @cnt = @cnt + 1;
END;

SELECT *
FROM @Result
ORDER BY RaceNum, CompositeScore DESC;
