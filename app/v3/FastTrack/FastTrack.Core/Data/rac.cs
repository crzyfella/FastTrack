using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public class rac
    {
        public int RacID { get; set; } 
        public string Version { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public int RaceNum { get; set; }
        public string SimulCastTrackCd { get; set; }
        public int SimulCastRaceNum { get; set; }
        public float Distance { get; set; }
        public int InnerInd { get; set; }
        public int TurfInd { get; set; }
        public int AboutInd { get; set; }
        public int RaceClass { get; set; }
        public float TopClaimPrice { get; set; }
        public float BottomClaimPrice { get; set; }
        public float RacePurse { get; set; }
        public string AgeRestriction { get; set; }
        public int SexRestriction { get; set; }
        public int StateBred { get; set; }
        public int RestrictedStakes { get; set; }
        public int StkHandicapGrade { get; set; }
        public string AbbreviationClass { get; set; }
        public string PostTime { get; set; }
        public string TrackTimeZone { get; set; }
        public string GmtAdjustmentFactor { get; set; }
        public string TrackName { get; set; }
        public string DistanceTrackRecord { get; set; }
        public string ReservedString1 { get; set; }
        public string ReservedString2 { get; set; }
        public int ReservedNum1 { get; set; }
        public int ReservedNum2 { get; set; }
    }
}
