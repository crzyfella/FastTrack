IF EXISTS (SELECT * FROM sysobjects 
           WHERE id = OBJECT_ID(N'[kelso].[vsp_ProcessMerge]') 
              AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
  DROP PROCEDURE [kelso].[vsp_ProcessMerge]
GO

CREATE PROCEDURE [kelso].[vsp_ProcessMerge]
(
	@datatable ProcessTableType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	MERGE INTO kelso.Process P
	USING (
			SELECT *
			FROM @datatable 
		  ) DT
	ON DT.RacID = P.RacID AND DT.EntID = P.EntID
	WHEN MATCHED THEN
		UPDATE 
			SET P.ChangeDt = GETDATE(),
				P.Distance = DT.Distance,
				P.Furlong = DT.Furlong,
				P.LastRaceDt = DT.LastRaceDt,
				P.NumOfDaysSinceLastRace = DT.NumOfDaysSinceLastRace,
				P.LastWorkoutDt = DT.LastWorkoutDt,
				P.NumOfDaysSinceLastWorkout = DT.NumOfDaysSinceLastWorkout,
				P.BettingLine = DT.BettingLine,
				P.StartsThisYr = DT.StartsThisYr,
				P.WinThisYr = DT.WinThisYr,
				P.WinsPerc = DT.WinsPerc,
				P.Top3Finishes = DT.Top3Finishes,
				P.Top3FinishesWinPerc = DT.Top3FinishesWinPerc,
				P.LifetimeStarts = DT.LifetimeStarts,
				P.LifetimeWins = DT.LifetimeWins,
				P.LifetimeWinsPerc = DT.LifetimeWinsPerc,
				P.LifetimeTop3Finish = DT.LifetimeTop3Finish,
				P.Top3FinishesLifetimePerc = DT.Top3FinishesLifetimePerc,
				P.TurfStarts = DT.TurfStarts,
				P.TurfWins = DT.TurfWins,
				P.TurfWinsPerc = DT.TurfWinsPerc,
				P.TurfTop3Finishes = DT.TurfTop3Finishes,
				P.Top3FinishesTurfPerc = DT.Top3FinishesTurfPerc,
				P.NonTurfStarts = DT.NonTurfStarts,
				P.NonTurfWins = DT.NonTurfWins,
				P.NonTurfWinsPerc = DT.NonTurfWinsPerc,
				P.NonTurfTop3Finishes = DT.NonTurfTop3Finishes,
				P.Top3FinishesNonTurfPerc = DT.Top3FinishesNonTurfPerc,
				P.TrackStart = DT.TrackStart,
				P.TrackEarnings = DT.TrackEarnings,
				P.TrackWins = DT.TrackWins,
				P.TrackTop3Finishes = DT.TrackTop3Finishes,
				P.DistanceStart = DT.DistanceStart,
				P.DistanceEarnings = DT.DistanceEarnings,
				P.DistanceWins = DT.DistanceWins,
				P.DistanceTop3Finishes = DT.DistanceTop3Finishes,
				P.TurfRating = DT.TurfRating,
				P.SpeedRating = DT.SpeedRating,
				P.TrackVariant = DT.TrackVariant,
				P.AdvancedSpeedFigure = DT.AdvancedSpeedFigure,
				P.PTSEarlyPaceRating = DT.PTSEarlyPaceRating,
				P.PTSLatePaceRating = DT.PTSLatePaceRating,
				P.PTSTruePaceRating = DT.PTSTruePaceRating,
				P.PTSSpeedRating = DT.PTSSpeedRating,
				P.OffTrackRating = DT.OffTrackRating,
				P.JockeyStarts = DT.JockeyStarts,
				P.JockeyWins = DT.JockeyWins,
				P.JockeyTop3Finishes = DT.JockeyTop3Finishes,
				P.JockeyWinningPerc = DT.JockeyWinningPerc,
				P.JockeyLifetimeWinningPerc = DT.JockeyLifetimeWinningPerc,
				P.TrainerLifetimeWinningPerc = DT.TrainerLifetimeWinningPerc,
				P.LastWorkoutRankingPercentage = DT.LastWorkoutRankingPercentage,
				P.LastWorkoutDistance = DT.LastWorkoutDistance,
				P.Workout4FurlongAvg = DT.Workout4FurlongAvg,
				P.Workout5FurlongAvg = DT.Workout5FurlongAvg,
				P.Workout6FurlongAvg = DT.Workout6FurlongAvg,
				P.Workout7FurlongAvg = DT.Workout7FurlongAvg,
				P.Workout8FurlongAvg = DT.Workout8FurlongAvg,
				P.WorkoutTop3RankingAvg = DT.WorkoutTop3RankingAvg,
				P.Workout3MonthAvg = DT.Workout3MonthAvg,
				P.Workout6MonthAvg = DT.Workout6MonthAvg,
				P.Workout4FurlongBest = DT.Workout4FurlongBest,
				P.Workout5FurlongBest = DT.Workout5FurlongBest,
				P.Workout6FurlongBest = DT.Workout6FurlongBest,
				P.Workout7FurlongBest = DT.Workout7FurlongBest,
				P.Workout8FurlongBest = DT.Workout8FurlongBest,
				P.WorkoutAvgCurrentMonth = DT.WorkoutAvgCurrentMonth,
				P.Workout4FurlongCurrentMonth = DT.Workout4FurlongCurrentMonth,
				P.Workout5FurlongCurrentMonth = DT.Workout5FurlongCurrentMonth,
				P.Workout6FurlongCurrentMonth = DT.Workout6FurlongCurrentMonth,
				P.Workout7FurlongCurrentMonth = DT.Workout7FurlongCurrentMonth,
				P.Workout8FurlongCurrentMonth = DT.Workout8FurlongCurrentMonth,
				P.WorkoutAvgPreviousMonth = DT.WorkoutAvgPreviousMonth,
				P.Workout4FurlongPreviousMonth = DT.Workout4FurlongPreviousMonth,
				P.Workout5FurlongPreviousMonth = DT.Workout5FurlongPreviousMonth,
				P.Workout6FurlongPreviousMonth = DT.Workout6FurlongPreviousMonth,
				P.Workout7FurlongPreviousMonth = DT.Workout7FurlongPreviousMonth,
				P.Workout8FurlongPreviousMonth = DT.Workout8FurlongPreviousMonth,
				P.WorkoutAvgPrevious2Month = DT.WorkoutAvgPrevious2Month,
				P.Workout4FurlongPrevious2Month = DT.Workout4FurlongPrevious2Month,
				P.Workout5FurlongPrevious2Month = DT.Workout5FurlongPrevious2Month,
				P.Workout6FurlongPrevious2Month = DT.Workout6FurlongPrevious2Month,
				P.Workout7FurlongPrevious2Month = DT.Workout7FurlongPrevious2Month,
				P.Workout8FurlongPrevious2Month = DT.Workout8FurlongPrevious2Month,
				P.WorkoutAvgPrevious3Month = DT.WorkoutAvgPrevious3Month,
				P.Workout4FurlongPrevious3Month = DT.Workout4FurlongPrevious3Month,
				P.Workout5FurlongPrevious3Month = DT.Workout5FurlongPrevious3Month,
				P.Workout6FurlongPrevious3Month = DT.Workout6FurlongPrevious3Month,
				P.Workout7FurlongPrevious3Month = DT.Workout7FurlongPrevious3Month,
				P.Workout8FurlongPrevious3Month = DT.Workout8FurlongPrevious3Month,
				P.WorkoutSameTrackBest = DT.WorkoutSameTrackBest,
				P.WorkoutSameTrackBest3 = DT.WorkoutSameTrackBest3,
				P.WorkoutSameTrackAvg = DT.WorkoutSameTrackAvg,
				P.CalculateTimeMethod = DT.CalculateTimeMethod,
				P.CalculateTime = DT.CalculateTime,
				P.CalculateTimePercentageAvg = DT.CalculateTimePercentageAvg,
				P.CalculateTimeUsingPaceAvg = DT.CalculateTimeUsingPaceAvg,
				P.CalculateTimeUsingPaceOverallAvg = DT.CalculateTimeUsingPaceOverallAvg,
				P.CalculateTimeTrendCorrelation = DT.CalculateTimeTrendCorrelation,
				P.CalculateTimeTrendIntercept = DT.CalculateTimeTrendIntercept,
				P.CalculateTimeTrendR2 = DT.CalculateTimeTrendR2,
				P.CalculateTimeTrendSlope = DT.CalculateTimeTrendSlope,
				P.Furlong5Time = DT.Furlong5Time,
				P.Furlong5TimeRankingPerc = DT.Furlong5TimeRankingPerc,
				P.Furlong6Time = DT.Furlong6Time,
				P.Furlong6TimeRankingPerc = DT.Furlong6TimeRankingPerc,
				P.Furlong8Time = DT.Furlong8Time,
				P.Furlong8TimeRankingPerc = DT.Furlong8TimeRankingPerc,
				P.CalculateTimeUsingPaceOverallRankingPerc = DT.CalculateTimeUsingPaceOverallRankingPerc
    WHEN NOT MATCHED THEN  
		INSERT (
				RacID,
				EntID,
				CreatedDt,
				ChangeDt,
				RaceDt,
				TrackCd,
				Distance,
				Furlong,
				RaceNum,
				TurfInd,
				HorseID,
				HorseName,
				PolePosition,
				LastRaceDt,
				NumOfDaysSinceLastRace,
				LastWorkoutDt,
				NumOfDaysSinceLastWorkout,
				BettingLine,
				StartsThisYr,
				WinThisYr,
				WinsPerc,
				Top3Finishes,
				Top3FinishesWinPerc,
				LifetimeStarts,
				LifetimeWins,
				LifetimeWinsPerc,
				LifetimeTop3Finish,
				Top3FinishesLifetimePerc,
				TurfStarts,
				TurfWins,
				TurfWinsPerc,
				TurfTop3Finishes,
				Top3FinishesTurfPerc,
				NonTurfStarts,
				NonTurfWins,
				NonTurfWinsPerc,
				NonTurfTop3Finishes,
				Top3FinishesNonTurfPerc,
				TrackStart,
				TrackEarnings,
				TrackWins,
				TrackTop3Finishes,
				DistanceStart,
				DistanceEarnings,
				DistanceWins,
				DistanceTop3Finishes,
				TurfRating,
				SpeedRating,
				TrackVariant,
				AdvancedSpeedFigure,
				PTSEarlyPaceRating,
				PTSLatePaceRating,
				PTSTruePaceRating,
				PTSSpeedRating,
				OffTrackRating,
				JockeyStarts,
				JockeyWins,
				JockeyTop3Finishes,
				JockeyWinningPerc,
				JockeyLifetimeWinningPerc,
				TrainerLifetimeWinningPerc,
				LastWorkoutRankingPercentage,
				LastWorkoutDistance,
				Workout4FurlongAvg,
				Workout5FurlongAvg,
				Workout6FurlongAvg,
				Workout7FurlongAvg,
				Workout8FurlongAvg,
				WorkoutTop3RankingAvg,
				Workout3MonthAvg,
				Workout6MonthAvg,
				Workout4FurlongBest,
				Workout5FurlongBest,
				Workout6FurlongBest,
				Workout7FurlongBest,
				Workout8FurlongBest,
				WorkoutAvgCurrentMonth,
				Workout4FurlongCurrentMonth,
				Workout5FurlongCurrentMonth,
				Workout6FurlongCurrentMonth,
				Workout7FurlongCurrentMonth,
				Workout8FurlongCurrentMonth,
				WorkoutAvgPreviousMonth,
				Workout4FurlongPreviousMonth,
				Workout5FurlongPreviousMonth,
				Workout6FurlongPreviousMonth,
				Workout7FurlongPreviousMonth,
				Workout8FurlongPreviousMonth,
				WorkoutAvgPrevious2Month,
				Workout4FurlongPrevious2Month,
				Workout5FurlongPrevious2Month,
				Workout6FurlongPrevious2Month,
				Workout7FurlongPrevious2Month,
				Workout8FurlongPrevious2Month,
				WorkoutAvgPrevious3Month,
				Workout4FurlongPrevious3Month,
				Workout5FurlongPrevious3Month,
				Workout6FurlongPrevious3Month,
				Workout7FurlongPrevious3Month,
				Workout8FurlongPrevious3Month,
				WorkoutSameTrackBest,
				WorkoutSameTrackBest3,
				WorkoutSameTrackAvg,
				CalculateTimeMethod,
				CalculateTime,
				CalculateTimePercentageAvg,
				CalculateTimeUsingPaceAvg,
				CalculateTimeUsingPaceOverallAvg,
				CalculateTimeTrendCorrelation,
				CalculateTimeTrendIntercept,
				CalculateTimeTrendR2,
				CalculateTimeTrendSlope,
				Furlong5Time,
				Furlong5TimeRankingPerc,
				Furlong6Time,
				Furlong6TimeRankingPerc,
				Furlong8Time,
				Furlong8TimeRankingPerc,
				CalculateTimeUsingPaceOverallRankingPerc
			   )
			   VALUES
			   (
				DT.RacID,
				DT.EntID,
				GETDATE(),
				GETDATE(),
				DT.RaceDt,
				DT.TrackCd,
				DT.Distance,
				DT.Furlong,
				DT.RaceNum,
				DT.TurfInd,
				DT.HorseID,
				DT.HorseName,
				DT.PolePosition,
				DT.LastRaceDt,
				DT.NumOfDaysSinceLastRace,
				DT.LastWorkoutDt,
				DT.NumOfDaysSinceLastWorkout,
				DT.BettingLine,
				DT.StartsThisYr,
				DT.WinThisYr,
				DT.WinsPerc,
				DT.Top3Finishes,
				DT.Top3FinishesWinPerc,
				DT.LifetimeStarts,
				DT.LifetimeWins,
				DT.LifetimeWinsPerc,
				DT.LifetimeTop3Finish,
				DT.Top3FinishesLifetimePerc,
				DT.TurfStarts,
				DT.TurfWins,
				DT.TurfWinsPerc,
				DT.TurfTop3Finishes,
				DT.Top3FinishesTurfPerc,
				DT.NonTurfStarts,
				DT.NonTurfWins,
				DT.NonTurfWinsPerc,
				DT.NonTurfTop3Finishes,
				DT.Top3FinishesNonTurfPerc,
				DT.TrackStart,
				DT.TrackEarnings,
				DT.TrackWins,
				DT.TrackTop3Finishes,
				DT.DistanceStart,
				DT.DistanceEarnings,
				DT.DistanceWins,
				DT.DistanceTop3Finishes,
				DT.TurfRating,
				DT.SpeedRating,
				DT.TrackVariant,
				DT.AdvancedSpeedFigure,
				DT.PTSEarlyPaceRating,
				DT.PTSLatePaceRating,
				DT.PTSTruePaceRating,
				DT.PTSSpeedRating,
				DT.OffTrackRating,
				DT.JockeyStarts,
				DT.JockeyWins,
				DT.JockeyTop3Finishes,
				DT.JockeyWinningPerc,
				DT.JockeyLifetimeWinningPerc,
				DT.TrainerLifetimeWinningPerc,
				DT.LastWorkoutRankingPercentage,
				DT.LastWorkoutDistance,
				DT.Workout4FurlongAvg,
				DT.Workout5FurlongAvg,
				DT.Workout6FurlongAvg,
				DT.Workout7FurlongAvg,
				DT.Workout8FurlongAvg,
				DT.WorkoutTop3RankingAvg,
				DT.Workout3MonthAvg,
				DT.Workout6MonthAvg,
				DT.Workout4FurlongBest,
				DT.Workout5FurlongBest,
				DT.Workout6FurlongBest,
				DT.Workout7FurlongBest,
				DT.Workout8FurlongBest,
				DT.WorkoutAvgCurrentMonth,
				DT.Workout4FurlongCurrentMonth,
				DT.Workout5FurlongCurrentMonth,
				DT.Workout6FurlongCurrentMonth,
				DT.Workout7FurlongCurrentMonth,
				DT.Workout8FurlongCurrentMonth,
				DT.WorkoutAvgPreviousMonth,
				DT.Workout4FurlongPreviousMonth,
				DT.Workout5FurlongPreviousMonth,
				DT.Workout6FurlongPreviousMonth,
				DT.Workout7FurlongPreviousMonth,
				DT.Workout8FurlongPreviousMonth,
				DT.WorkoutAvgPrevious2Month,
				DT.Workout4FurlongPrevious2Month,
				DT.Workout5FurlongPrevious2Month,
				DT.Workout6FurlongPrevious2Month,
				DT.Workout7FurlongPrevious2Month,
				DT.Workout8FurlongPrevious2Month,
				DT.WorkoutAvgPrevious3Month,
				DT.Workout4FurlongPrevious3Month,
				DT.Workout5FurlongPrevious3Month,
				DT.Workout6FurlongPrevious3Month,
				DT.Workout7FurlongPrevious3Month,
				DT.Workout8FurlongPrevious3Month,
				DT.WorkoutSameTrackBest,
				DT.WorkoutSameTrackBest3,
				DT.WorkoutSameTrackAvg,
				DT.CalculateTimeMethod,
				DT.CalculateTime,
				DT.CalculateTimePercentageAvg,
				DT.CalculateTimeUsingPaceAvg,
				DT.CalculateTimeUsingPaceOverallAvg,
				DT.CalculateTimeTrendCorrelation,
				DT.CalculateTimeTrendIntercept,
				DT.CalculateTimeTrendR2,
				DT.CalculateTimeTrendSlope,
				DT.Furlong5Time,
				DT.Furlong5TimeRankingPerc,
				DT.Furlong6Time,
				DT.Furlong6TimeRankingPerc,
				DT.Furlong8Time,
				DT.Furlong8TimeRankingPerc,
				DT.CalculateTimeUsingPaceOverallRankingPerc
			   );
END

GO





