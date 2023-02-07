using System;

namespace FastTrack.Core.Data
{
    public class ProgramFile
    {
        public int Id { get; set; }
        public Guid FileId { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public string TrackName { get; set; }
    }

    public class ProgramRace
    {
        public int Id { get; set; }
        public Guid FileId { get; set; }
        public Guid RaceId { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public string TrackName { get; set; }
        public int RaceNum { get; set; }
        public decimal Furlong { get; set; }
        public decimal DistanceFeet { get; set; }
        public string TurfInd { get; set; }
        public string RaceType { get; set; }
    }
}
