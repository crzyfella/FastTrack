using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public class wor
    {
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public int RaceNum { get; set; }
        public string HorseName { get; set; }
        public DateTime WorkOutDt { get; set; }
        public string WorkOutTrack { get; set; }
        public float WorkOutDistance { get; set; }
        public int InnerInd { get; set; }
        public int TurfInd { get; set; }
        public int TrainingTrackInd { get; set; }
        public string WorkOutTrackCond { get; set; }
        public float WorkOutTime { get; set; }
        public int BreezingInd { get; set; }
        public int HandilyInd { get; set; }
        public int BulletInd { get; set; }
        public int DogsUpInd { get; set; }
        public int GateWorkOutInd { get; set; }
        public int WorkOutRank { get; set; }
        public int WorkOutTotalNum { get; set; }
        public string ReservedString1 { get; set; }
        public string ReservedString2 { get; set; }
        public int ReservedNum1 { get; set; }
        public int ReservedNum2 { get; set; }
    }
}
