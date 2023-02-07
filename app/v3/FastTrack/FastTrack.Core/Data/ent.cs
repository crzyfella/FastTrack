using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Data
{
    public class ent
    {
        public int EntID { get; set; }
        public int RacID { get; set; }
        public DateTime RaceDt { get; set; }
        public string TrackCd { get; set; }
        public int RaceNum { get; set; }
        public string HorseName { get; set; }
        public int HorseID { get; set; }
        public string PolePosition { get; set; }
        public string MorningLine { get; set; }
        public int PaceLines { get; set; }
        public string EntryChar { get; set; }
        public int ScratchFlagInd { get; set; }
        public int CurrentYr { get; set; }
        public int StartsThisYr { get; set; }
        public int WinThisYr { get; set; }
        public int PlacesThisYr { get; set; }
        public int ShowsThisYr { get; set; }
        public float EarningThisYr { get; set; }
        public int PrevYearForEarning { get; set; }
        public int StartsPrevYr { get; set; }
        public int WinPrevYr { get; set; }
        public int PlacesPrevYr { get; set; }
        public int ShowsPrevYr { get; set; }
        public float EarningPrevYr { get; set; }
        public string OwnerName { get; set; }
        public string Color { get; set; }
        public int YearBorn { get; set; }
        public int MonthBorn { get; set; }
        public string StateBredInd { get; set; }
        public int Age { get; set; }
        public string Sex { get; set; }
        public string SireName { get; set; }
        public string SiresSire { get; set; }
        public string Dam { get; set; }
        public string DamsSire { get; set; }
        public string TrainerName { get; set; }
        public string BreederName { get; set; }
        public int TrainerStarts { get; set; }
        public int TrainerWins { get; set; }
        public int TrainerPlaces { get; set; }
        public int TrainerShows { get; set; }
        public float TrainerPercentage { get; set; }
        public int LasixInd { get; set; }
        public int ButeInd { get; set; }
        public float WeightAssigned { get; set; }
        public float ApprenticeWtAllowance { get; set; }
        public string JockeyName { get; set; }
        public int JockeyStarts { get; set; }
        public int JockeyWins { get; set; }
        public int JockeyPlaces { get; set; }
        public int JockeyShows { get; set; }
        public float JockeyPercentage { get; set; }
        public float ClaimingPrice { get; set; }
        public int LifetimeStarts { get; set; }
        public int LifetimeWins { get; set; }
        public int LifetimePlaces { get; set; }
        public int LifetimeShows { get; set; }
        public float LifetimeEarnings { get; set; }
        public int TrackStarts { get; set; }
        public int TrackWins { get; set; }
        public int TrackPlaces { get; set; }
        public int TrackShows { get; set; }
        public float TrackEarnings { get; set; }
        public int TurfStarts { get; set; }
        public int TurfWins { get; set; }
        public int TurfPlaces { get; set; }
        public int TurfShows { get; set; }
        public float TurfEarnings { get; set; }
        public int WetStarts { get; set; }
        public int WetWins { get; set; }
        public int WetPlaces { get; set; }
        public int WetShows { get; set; }
        public float WetEarnings { get; set; }
        public int DistanceStarts { get; set; }
        public int DistanceWins { get; set; }
        public int DistancePlaces { get; set; }
        public int DistanceShows { get; set; }
        public float DistanceEarnings { get; set; }
        public int AlsoEligibleInd { get; set; }
        public int PartOfFieldInd { get; set; }
        public int BlinkersToday { get; set; }
        public int BandagesTodayInd { get; set; }
        public string JockeyStatsYTD { get; set; }
        public string TrainerStatsYTD { get; set; }
        public string ReservedString3 { get; set; }
        public string ReservedString4 { get; set; }
        public int PostPosition { get; set; }
        public int OffTrackRating { get; set; }
        public int TurfRating { get; set; }
        public int FirstTimeLasix { get; set; }
    }
}
