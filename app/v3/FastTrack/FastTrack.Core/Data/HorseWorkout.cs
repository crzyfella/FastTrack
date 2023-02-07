using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public class HorseWorkout
    {
        public int WorkoutHistoryID { get; set; }
        public int HorseID { get; set; }
        public DateTime WorkOutDt { get; set; }
        public string TrackCd { get; set; }
        public float Distance { get; set; }
        public float Furlong { get; set; }
        public int TurfInd { get; set; }
        public string TrackCond { get; set; }
        public float WorkOutTime { get; set; }
        public float WorkoutRankingPerc { get; set; }
        public float WorkoutTimeAvg { get; set; }
        public float WorkoutTimeMin { get; set; }
        public float WorkoutTimeMax { get; set; }
        public float WorkoutTimeStdv { get; set; }
        public int BreezingInd { get; set; }
        public int BulletInd { get; set; }
    }
}
