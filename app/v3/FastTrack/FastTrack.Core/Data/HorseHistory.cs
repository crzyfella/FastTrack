using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public class HorseHistory
    {
        public int HorseHistoryID { get; set; }
        public int HorseID { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public string RaceNum { get; set; }
        public float Distance { get; set; }
        public float Furlong { get; set; }
        public int InnerInd { get; set; }
        public int TurfInd { get; set; }
        public string TrackCondition { get; set; }
        public int StateBredInd { get; set; }
        public float Purse { get; set; }
        public float ClaimingPrice { get; set; }
        public int RaceClass { get; set; }
        public int StkHandicapGrade { get; set; }
        public float FirstCallTime { get; set; }
        public float SecondCallTime { get; set; }
        public float FinalTime { get; set; }
        public float AdditionalFractionalTime { get; set; }
        public int PostPosition { get; set; }
        public int StartCallPosition { get; set; }
        public int FirstCallPosition { get; set; }
        public int SecondCallPosition { get; set; }
        public int StretchCallPosition { get; set; }
        public int FinalCallPosition { get; set; }
        public float FirstCallBeatenLengths { get; set; }
        public float SecondCallBeatenLengths { get; set; }
        public float StretchCallBeatenLengths { get; set; }
        public float FinalBeatenLengths { get; set; }
        public string JockeyName { get; set; }
        public int LasixInd { get; set; }
        public int FavoriteFlagInd { get; set; }
        public float PostTimeOdds { get; set; }
        public int FavortismOddRanking { get; set; }
        public float SpeedRating { get; set; }
        public float TrackVariant { get; set; }
        public float AdvancedSpeedFigure { get; set; }
        public float PTSEarlyPaceRating { get; set; }
        public float PTSLatePaceRating { get; set; }
        public float PTSTruePaceRating { get; set; }
        public string TroubleLine { get; set; }
        public string ExtendedTroubleLineInfo { get; set; }
        public int NumberOfEntrants { get; set; }
        public float Furlong_1 { get; set; }
        public float Furlong_2 { get; set; }
        public float Furlong_3 { get; set; }
        public float Furlong_4 { get; set; }
        public float Furlong_5 { get; set; }
        public float Furlong5RankingPerc { get; set; }
        public float Furlong_6 { get; set; }
        public float Furlong6RankingPerc { get; set; }
        public float Furlong_8 { get; set; }
        public float Furlong8RankingPerc { get; set; }
        public float FinishTime { get; set; }
        public float AvgFinishTime { get; set; }
        public float MinFinishTime { get; set; }
        public float MaxFinishTime { get; set; }
        public float StdevFinishTime { get; set; }
        public float FinishTimeRankingPerc { get; set; }
        public float FirstCallPace { get; set; }
        public float SecondCallPace { get; set; }
        public float StretchCallPace { get; set; }
        public float FinishCallPace { get; set; }
        public float OverallPace { get; set; }
    }
}
