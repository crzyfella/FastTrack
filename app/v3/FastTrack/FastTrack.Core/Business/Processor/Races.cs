using FastTrack.Core.Business.Utilities;
using FastTrack.Core.Business.Utilities.Trendlines;
using FastTrack.Core.DAL;
using FastTrack.Core.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Processor
{
    public class Races
    {
        private const float FURLONG = 660.0f;
        public string DataBaseConnection { get; set; }
        public Races() { }

        public void Process(RaceInformation raceInfo)
        {
            var dal = new FastTrackContext(DataBaseConnection);

            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_RacSelect, raceInfo.RacID);
            List<rac> records = race.DataTableToList<rac>();

            foreach (var record in records)
            {
                DataTable entTable = dal.ExecuteStoreProcedure(StoreProcedures.vsp_EntSelect, record.RacID);
                List<ent> entRecords = entTable.DataTableToList<ent>();

                var processTable = dal.GetTableStructure(TableName.PROCESS);

                Parallel.ForEach(entRecords, new ParallelOptions { MaxDegreeOfParallelism = 4 }, entRecord =>
                 {
                     var processInfo = ProcessHorseInfo(entRecord, raceInfo, dal);
                     var row = InputOutput.ConvertObjectToArray(processInfo);
                     processTable.Rows.Add(row.ToArray());
                 });

                dal.InsertDataTable(StoreProcedures.vsp_ProcessMerge, processTable);
            }
        }

        private Data.Process ProcessHorseInfo(ent entRecord, RaceInformation raceInfo, FastTrackContext dal)
        {
            var processInfo = HorseInfo(entRecord, raceInfo, dal);
            JockeyTrainer(processInfo, entRecord);
            Workout(processInfo, dal);

            var dictionary = new Dictionary<string, string>();
            dictionary.Add("HorseId", processInfo.HorseID.ToString());
            dictionary.Add("RaceDt", processInfo.RaceDt.ToShortDateString());

            DataTable horseHistoryTable = dal.ExecuteStoreProcedure(StoreProcedures.vsp_HorseHistorySelect, dictionary);
            List<HorseHistory> horseHistory = horseHistoryTable.DataTableToList<HorseHistory>();

            if (horseHistory.Where(q => q.AdvancedSpeedFigure > 0).Count() > 0)
                processInfo.AdvancedSpeedFigure = horseHistory.Average(q => q.AdvancedSpeedFigure);

            if (horseHistory.Where(q => q.PTSEarlyPaceRating > 0).Count() > 0)
                processInfo.PTSEarlyPaceRating = horseHistory.Average(q => q.PTSEarlyPaceRating);

            if (horseHistory.Where(q => q.PTSLatePaceRating > 0).Count() > 0)
                processInfo.PTSLatePaceRating = horseHistory.Average(q => q.PTSLatePaceRating);

            if (horseHistory.Where(q => q.PTSTruePaceRating > 0).Count() > 0)
                processInfo.PTSTruePaceRating = horseHistory.Average(q => q.PTSTruePaceRating);

            if (horseHistory.Where(q => q.SpeedRating > 0).Count() > 0)
                processInfo.SpeedRating = horseHistory.Average(q => q.SpeedRating);

            if (horseHistory.Where(q => q.TrackVariant > 0).Count() > 0)
                processInfo.TrackVariant = horseHistory.Average(q => q.TrackVariant);

            GetFurlongTime(processInfo, horseHistory);
            CalculateTimeBaseUponPace(processInfo, horseHistory, dal);

            return processInfo;
        }

        private Process HorseInfo(ent horse, RaceInformation raceInfo, FastTrackContext dal)
        {
            Process processInfo = null;

            var dictionary = new Dictionary<string, string>();
            dictionary.Add("HorseId", horse.HorseID.ToString());
            dictionary.Add("RaceDt", raceInfo.RaceDt.ToShortDateString());

            DataTable horseHistoryTable = dal.ExecuteStoreProcedure(StoreProcedures.vsp_HorseHistorySelect, dictionary);
            List<HorseHistory> horseHistory = horseHistoryTable.DataTableToList<HorseHistory>();

            dictionary.Clear();
            dictionary.Add("HorseId", horse.HorseID.ToString());
            dictionary.Add("RacId", raceInfo.RacID.ToString());
            dictionary.Add("RaceDt", raceInfo.RaceDt.ToShortDateString());
            DataTable processInfoTable = dal.ExecuteStoreProcedure(StoreProcedures.vsp_HorseInformation, dictionary);

            processInfo = processInfoTable.Rows[0].ToObject<Process>();
            processInfo.RacID = raceInfo.RacID;
            processInfo.EntID = horse.EntID;
            processInfo.PolePosition = horse.PolePosition;
            processInfo.CreatedDt = DateTime.Now;
            processInfo.ChangeDt = DateTime.Now;
            processInfo.RaceDt = raceInfo.RaceDt;
            processInfo.TrackCd = raceInfo.TrackCd;
            processInfo.Distance = raceInfo.Distance;
            processInfo.Furlong = raceInfo.Furlong;
            processInfo.TurfInd = raceInfo.TurfInd;
            processInfo.RaceNum = raceInfo.RaceNum;
            processInfo.TrackStart = horse.TrackStarts;
            processInfo.TrackWins = horse.TrackWins;
            processInfo.TrackTop3Finishes = horse.TrackWins + horse.TrackShows + horse.TrackPlaces;
            processInfo.DistanceStart = horse.DistanceStarts;
            processInfo.DistanceWins = horse.DistanceWins;
            processInfo.DistanceTop3Finishes = horse.DistanceWins + horse.DistanceShows + horse.DistancePlaces;

            if (processInfo.LastRaceDt == DateTime.MinValue)
                processInfo.LastRaceDt = null;

            if (processInfo.LastWorkoutDt == DateTime.MinValue)
                processInfo.LastWorkoutDt = null;

            return processInfo;
        }

        private void JockeyTrainer(Process processInfo, ent horse)
        {
            processInfo.JockeyStarts = horse.JockeyStarts;
            processInfo.JockeyWins = horse.JockeyWins;
            processInfo.JockeyTop3Finishes = horse.JockeyWins + horse.JockeyPlaces + horse.JockeyShows;
            processInfo.JockeyWinningPerc = horse.JockeyPercentage;

            if (string.IsNullOrWhiteSpace(horse.JockeyStatsYTD))
            {
                processInfo.JockeyLifetimeWinningPerc = 0.0f;
            }
            else
            {
                processInfo.JockeyLifetimeWinningPerc = float.Parse(horse.JockeyStatsYTD.Split(' ')[2].Replace(")", string.Empty));
            }

            if (string.IsNullOrWhiteSpace(horse.TrainerStatsYTD))
            {
                processInfo.TrainerLifetimeWinningPerc = 0.0f;
            }
            else
            {
                processInfo.TrainerLifetimeWinningPerc = float.Parse(horse.TrainerStatsYTD.Split(' ')[2].Replace(")", string.Empty));
            }
        }

        private void Workout(Process process, FastTrackContext dal)
        {
            var dictionary = new Dictionary<string, string>();
            dictionary.Add("HorseId", process.HorseID.ToString());
            dictionary.Add("RaceDt", process.RaceDt.ToShortDateString());
            DataTable workoutTable = dal.ExecuteStoreProcedure(StoreProcedures.vsp_WorkoutHistoryStatsSelect, dictionary);
            List<HorseWorkout> workoutRecords = workoutTable.DataTableToList<HorseWorkout>();

            if (workoutRecords.Count > 0)
            {
                process.LastWorkoutDt = workoutRecords.FirstOrDefault().WorkOutDt;
                process.LastWorkoutDistance = workoutRecords.FirstOrDefault().Distance;
                process.Workout4FurlongAvg = GetDistanceAverage(workoutRecords, 4.0f);
                process.Workout5FurlongAvg = GetDistanceAverage(workoutRecords, 5.0f);
                process.Workout6FurlongAvg = GetDistanceAverage(workoutRecords, 6.0f);
                process.Workout7FurlongAvg = GetDistanceAverage(workoutRecords, 7.0f);
                process.Workout8FurlongAvg = GetDistanceAverage(workoutRecords, 8.0f);

                if (workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-6) && q.WorkOutDt <= process.RaceDt).Count() > 0)
                    process.WorkoutTop3RankingAvg = workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-6) && q.WorkOutDt <= process.RaceDt).OrderByDescending(q => q.WorkoutRankingPerc).Take(3).Average(a => a.WorkoutRankingPerc);

                if (workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-3) && q.WorkOutDt <= process.RaceDt).Count() > 0)
                    process.Workout3MonthAvg = workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-3) && q.WorkOutDt <= process.RaceDt).Average(a => a.WorkoutRankingPerc);

                if (workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-6) && q.WorkOutDt <= process.RaceDt).Count() > 0)
                    process.Workout6MonthAvg = workoutRecords.Where(q => q.WorkOutDt >= process.RaceDt.AddMonths(-6) && q.WorkOutDt <= process.RaceDt).DefaultIfEmpty().Average(a => a.WorkoutRankingPerc);

                process.Workout4FurlongBest = GetDistanceBest(workoutRecords, 4.0f, process.RaceDt);
                process.Workout5FurlongBest = GetDistanceBest(workoutRecords, 5.0f, process.RaceDt);
                process.Workout6FurlongBest = GetDistanceBest(workoutRecords, 6.0f, process.RaceDt);
                process.Workout7FurlongBest = GetDistanceBest(workoutRecords, 7.0f, process.RaceDt);
                process.Workout8FurlongBest = GetDistanceBest(workoutRecords, 8.0f, process.RaceDt);
                process.WorkoutAvgCurrentMonth = GetPercentageAvgByMonth(workoutRecords, 0, process.RaceDt);
                process.Workout4FurlongCurrentMonth = GetPercentageByMonth(workoutRecords, 0, 4.0f, process.RaceDt);
                process.Workout5FurlongCurrentMonth = GetPercentageByMonth(workoutRecords, 0, 5.0f, process.RaceDt);
                process.Workout6FurlongCurrentMonth = GetPercentageByMonth(workoutRecords, 0, 6.0f, process.RaceDt);
                process.Workout7FurlongCurrentMonth = GetPercentageByMonth(workoutRecords, 0, 7.0f, process.RaceDt);
                process.Workout8FurlongCurrentMonth = GetPercentageByMonth(workoutRecords, 0, 8.0f, process.RaceDt);
                process.WorkoutAvgPreviousMonth = GetPercentageAvgByMonth(workoutRecords, -1, process.RaceDt);
                process.Workout4FurlongPreviousMonth = GetPercentageByMonth(workoutRecords, -1, 4.0f, process.RaceDt);
                process.Workout5FurlongPreviousMonth = GetPercentageByMonth(workoutRecords, -1, 5.0f, process.RaceDt);
                process.Workout6FurlongPreviousMonth = GetPercentageByMonth(workoutRecords, -1, 6.0f, process.RaceDt);
                process.Workout7FurlongPreviousMonth = GetPercentageByMonth(workoutRecords, -1, 7.0f, process.RaceDt);
                process.Workout8FurlongPreviousMonth = GetPercentageByMonth(workoutRecords, -1, 8.0f, process.RaceDt);
                process.WorkoutAvgPrevious2Month = GetPercentageAvgByMonth(workoutRecords, -2, process.RaceDt);
                process.Workout4FurlongPrevious2Month = GetPercentageByMonth(workoutRecords, -2, 4.0f, process.RaceDt);
                process.Workout5FurlongPrevious2Month = GetPercentageByMonth(workoutRecords, -2, 5.0f, process.RaceDt);
                process.Workout6FurlongPrevious2Month = GetPercentageByMonth(workoutRecords, -2, 6.0f, process.RaceDt);
                process.Workout7FurlongPrevious2Month = GetPercentageByMonth(workoutRecords, -2, 7.0f, process.RaceDt);
                process.Workout8FurlongPrevious2Month = GetPercentageByMonth(workoutRecords, -2, 8.0f, process.RaceDt);
                process.WorkoutAvgPrevious3Month = GetPercentageAvgByMonth(workoutRecords, -3, process.RaceDt);
                process.Workout4FurlongPrevious3Month = GetPercentageByMonth(workoutRecords, -3, 4.0f, process.RaceDt);
                process.Workout5FurlongPrevious3Month = GetPercentageByMonth(workoutRecords, -3, 5.0f, process.RaceDt);
                process.Workout6FurlongPrevious3Month = GetPercentageByMonth(workoutRecords, -3, 6.0f, process.RaceDt);
                process.Workout7FurlongPrevious3Month = GetPercentageByMonth(workoutRecords, -3, 7.0f, process.RaceDt);
                process.Workout8FurlongPrevious3Month = GetPercentageByMonth(workoutRecords, -3, 8.0f, process.RaceDt);
                SameTrackWorkoutAndRace(process, workoutRecords, process.RaceDt, process.TrackCd);
            }
        }

        private float GetDistanceAverage(List<HorseWorkout> list, float distance)
        {
            var records = list.Where(q => q.Distance == FURLONG * distance);

            if (records.Count() > 0)
            {
                return records.Average(q => q.WorkoutRankingPerc);
            }

            return 0.0f;
        }

        private float GetDistanceBest(List<HorseWorkout> list, float distance, DateTime raceDt)
        {
            var record = list.Where(q => q.Distance == (FURLONG * distance) && q.WorkOutDt >= raceDt.AddMonths(-6) && q.WorkOutDt <= raceDt).OrderByDescending(q => q.WorkoutRankingPerc).FirstOrDefault();

            if (record != null)
            {
                return record.WorkoutRankingPerc;
            }

            return 0.0f;
        }

        private float GetPercentageByMonth(List<HorseWorkout> list, int numOfMonth, float distance, DateTime raceDt)
        {
            var record = list.Where(q => q.Distance == (FURLONG * distance) && q.WorkOutDt.ToString("YYYYMM") == raceDt.AddMonths(numOfMonth).ToString("YYYYMM")).OrderByDescending(q => q.WorkoutRankingPerc).FirstOrDefault();

            if (record != null)
            {
                return record.WorkoutRankingPerc;
            }

            return 0.0f;
        }

        private float GetPercentageAvgByMonth(List<HorseWorkout> list, int numOfMonth, DateTime raceDt)
        {
            var record = list.Where(q => q.WorkOutDt.ToString("YYYYMM") == raceDt.AddMonths(numOfMonth).ToString("YYYYMM"));

            if (record.Count() > 0)
            {
                return record.Average(q => q.WorkoutRankingPerc);
            }

            return 0.0f;
        }

        private void SameTrackWorkoutAndRace(Process process, List<HorseWorkout> list, DateTime raceDt, string trackCd)
        {
            var record = list.Where(q => q.WorkOutDt >= raceDt.AddMonths(-6) && q.WorkOutDt <= raceDt && q.TrackCd == trackCd);

            if (record.Count() > 0)
            {
                process.WorkoutSameTrackBest = record.OrderByDescending(q => q.WorkoutRankingPerc).FirstOrDefault().WorkoutRankingPerc;
                process.WorkoutSameTrackBest3 = record.OrderByDescending(q => q.WorkoutRankingPerc).Take(3).Average(q => q.WorkoutRankingPerc);
                process.WorkoutSameTrackAvg = record.Average(q => q.WorkoutRankingPerc);
            }
        }

        private void PredictedTimeCalculation(Process process, FastTrackContext dal)
        {
            var dictionary = new Dictionary<string, string>();
            dictionary.Add("HorseId", process.HorseID.ToString());
            dictionary.Add("RaceDt", process.RaceDt.ToShortDateString());
            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_PredictedTimeHorseHistorySelect, dictionary);
            var records = race.DataTableToList<TimeCalculation>();

            Trending(process, records);

            if (!CalculateTimeSameTrackSameDistance(process, records))
            {
                CalculateTimeBaseUponDatapoints(process, records);
            }
        }

        private bool CalculateTimeSameTrackSameDistance(Process process, List<TimeCalculation> list)
        {
            var records = list.Where(q => q.TrackCd == process.TrackCd && q.Distance == process.Distance && q.TurfInd == process.TurfInd && q.PercentRanking >= 15.0f);

            if (records.Count() > 0)
            {
                process.CalculateTime = records.Average(q => q.PercentRanking);
                process.CalculateTimePercentageAvg = records.Average(q => q.FinishTime);
                process.CalculateTimeMethod = PredictiveMethod.SameTrackDistanceSurface;

                return true;
            }

            return false;
        }

        private void CalculateTimeBaseUponDatapoints(Process process, List<TimeCalculation> list)
        {
            var records = list.Where(q => q.TrackCd == process.TrackCd && q.PercentRanking >= 15.0f);

            if (records.Count() > 0)
            {
                records = list.Where(q => q.PercentRanking >= 15.0f);
            }

            if (records.Count() > 0)
            {
                float minY = records.Where(q => q.Furlong_2 > 0).Count() > 0.0f ? records.Where(q => q.Furlong_2 > 0).Average(q => q.Furlong_2) : 0.0f;
                float minX = 2.0f;

                if (minY == 0.0f)
                {
                    minY = records.Where(q => q.Furlong_4 > 0).Count() > 0.0f ? records.Where(q => q.Furlong_4 > 0).Average(q => q.Furlong_4) : 0.0f;
                    minX = 4.0f;
                }

                float maxX = records.Max(q => q.Furlong);
                float maxY = records.Where(q => q.Furlong == maxX).Average(q => q.FinishTime);

                if (minX > 0.0f && minY > 0.0f && maxX > 0.0f && maxY > 0.0f)
                {
                    var trend = new LinearTrend<IValueItem>();
                    trend.DataItems.Add(new NumberItem { X = minX, Y = minY });
                    trend.DataItems.Add(new NumberItem { X = maxX, Y = maxY });

                    if (trend.Calculate())
                    {
                        process.CalculateTime = (float)((trend.Slope * (process.Furlong - minX)) + minY);
                        process.CalculateTimePercentageAvg = 0.0f;
                        process.CalculateTimeMethod = PredictiveMethod.CalculateTime;
                    }
                }
            }
        }

        private void Trending(Process process, List<TimeCalculation> list)
        {
            var points = list.Where(q => q.RaceDt >= process.RaceDt.AddMonths(-12) && q.RaceDt <= process.RaceDt).OrderBy(q => q.RaceDt);
            double idx = 1.0d;

            if (points.Count() > 0)
            {
                var trend = new LinearTrend<IValueItem>();

                foreach (var point in points)
                {
                    trend.DataItems.Add(new NumberItem { X = idx, Y = point.PercentRanking });
                    idx++;
                }

                if (trend.Calculate())
                {
                    process.CalculateTimeTrendCorrelation = double.IsNaN((double)trend.Correllation) ? -99.0f : (float)trend.Correllation;
                    process.CalculateTimeTrendIntercept = double.IsNaN((double)trend.Intercept) ? -99.0f : (float)trend.Intercept;
                    process.CalculateTimeTrendR2 = double.IsNaN((double)trend.R2) ? -99.0f : (float)trend.R2;
                    process.CalculateTimeTrendSlope = double.IsNaN((double)trend.Slope) ? -99.0f : (float)trend.Slope;
                }
            }
        }

        private void GetFurlongTime(Process process, List<HorseHistory> horseHistory)
        {
            if (horseHistory.Where(q => q.Furlong_5 > 0).Count() > 0)
            {
                process.Furlong5Time = horseHistory.Where(q => q.Furlong_5 > 0).Average(q => q.Furlong_5);
                process.Furlong5TimeRankingPerc = horseHistory.Where(q => q.Furlong_5 > 0).Average(q => q.Furlong5RankingPerc);
            }

            if (horseHistory.Where(q => q.Furlong_6 > 0).Count() > 0)
            {
                process.Furlong6Time = horseHistory.Where(q => q.Furlong_6 > 0).Average(q => q.Furlong_6);
                process.Furlong6TimeRankingPerc = horseHistory.Where(q => q.Furlong_6 > 0).Average(q => q.Furlong6RankingPerc);
            }

            if (horseHistory.Where(q => q.Furlong_8 > 0).Count() > 0)
            {
                process.Furlong8Time = horseHistory.Where(q => q.Furlong_8 > 0).Average(q => q.Furlong_8);
                process.Furlong8TimeRankingPerc = horseHistory.Where(q => q.Furlong_8 > 0).Average(q => q.Furlong8RankingPerc);
            }
        }

        private void CalculateTimeBaseUponPace(Process process, List<HorseHistory> horseHistory, FastTrackContext dal)
        {
            if (horseHistory.Where(q => q.OverallPace > 0.0f).Count() > 0)
            {
                process.CalculateTimeUsingPaceOverallAvg = (float)Math.Round(process.Distance / horseHistory.Where(q => q.OverallPace > 0.0f).Average(q => q.OverallPace), 2);
                process.CalculateTimeUsingPaceOverallAvgRankingPerc = GetRanking(process, dal);
            }
            else if (process.LifetimeStarts == 0)
            {
                process.CalculateTimeUsingPaceOverallAvg = GetPredictedTimeFirstTimer(process, dal);
                process.CalculateTimeUsingPaceOverallAvgRankingPerc = GetRanking(process, dal);
            }
        }

        private float GetPredictedTimeFirstTimer(Process process, FastTrackContext dal)
        {
            var dictionary = new Dictionary<string, object>();

            dictionary.Add("HorseID", process.HorseID);
            dictionary.Add("RaceDt", process.RaceDt);
            dictionary.Add("RaceNum", process.RaceNum);

            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_PredictedTimeFirstTime, dictionary);

            return race.Rows[0].ItemArray[0] == System.DBNull.Value ? 0.0f : float.Parse(race.Rows[0].ItemArray[0].ToString());
        }

        private float GetRanking(Process process, FastTrackContext dal)
        {
            var dictionary = new Dictionary<string, object>();

            dictionary.Add("CalculateTime", process.CalculateTimeUsingPaceOverallAvg);
            dictionary.Add("TrackCd", process.TrackCd);
            dictionary.Add("Distance", process.Distance);

            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_HorseTimeTrackRanking, dictionary);

            return race.Rows[0].ItemArray[0] == System.DBNull.Value ? 0.0f : float.Parse(race.Rows[0].ItemArray[0].ToString());
        }

        private float GetFirstCallTime(Process process, List<HorseHistory> list)
        {
            float time = 0.0f;

            if (process.Distance >= (660.0f * 5.5f) && process.Distance < (660.0f * 9.0f))
            {
                time = list.Average(q => q.FirstCallPace) * (660.0f * 2.0f);
            }
            else if (process.Distance >= (660.0f * 9.0f))
            {
                time = list.Average(q => q.FirstCallPace) * (660.0f * 4.0f);
            }

            return time;
        }

        private float GetSecondCallTime(Process process, List<HorseHistory> list)
        {
            return list.Average(q => q.SecondCallPace) * (660.0f * 2.0f);
        }

        private float GetStretchCallTime(Process process, List<HorseHistory> list)
        {
            return list.Average(q => q.StretchCallPace) * (660.0f * 2.0f);
        }

        private float GetTimeUsingPace(Process process, List<HorseHistory> list)
        {
            return 0.0f;
        }
    }
}
