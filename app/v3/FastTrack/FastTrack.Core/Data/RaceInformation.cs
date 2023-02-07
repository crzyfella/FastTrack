using System;

namespace FastTrack.Core.Data
{
    public class RaceInformation
    {
        public int RacID { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public float Distance { get; set; }
        public float Furlong { get; set;  }
        public int RaceNum { get; set; }
        public int TurfInd { get; set; }
    }
}
