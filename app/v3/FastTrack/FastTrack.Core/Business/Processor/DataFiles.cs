using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FastTrack.Core.DAL;
using FastTrack.Core.Data;
using System.Data;
using System.Data.Common;
using System.IO;
using System.IO.Compression;
using System.Configuration;
using AutoMapper;

namespace FastTrack.Core.Business.Processor
{
    public class DataFiles
    {
        public string DataBaseConnection { get; set; }
        private string ErrorPath = ConfigurationManager.AppSettings["ErrorFiles"];
        public DataFiles()
        { }

        public List<RaceInformation> ProcessFiles(string path, string fileName, bool zip)
        {
            List<RaceInformation> raceInfo = null;

            var dal = new FastTrackContext(DataBaseConnection);
            string zipPath = $@"{path}\{fileName}.zip";
            var extractPath = $@"{path}\Processing";
            
            foreach(var file in Directory.GetFiles(extractPath))
            {
                File.Delete(file);
            }

            ZipFile.ExtractToDirectory(zipPath, extractPath);
            var files = Directory.GetFiles(extractPath);
            var drf = files.Where(x => x.Contains("DRF")).FirstOrDefault();

            if (drf == null)
            {
                var xrd = files.Where(x => x.Contains("XRD")).FirstOrDefault();
                ImportData(xrd, TableName.XRD_STAGING, dal);
                var programFile = dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_FilesMerge, new Dictionary<string, string>() { { "FileName", fileName }, { "Type", "Result" } });

                dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_xrdInsert);
            }
            else
            {
                if (ImportData(drf, TableName.DRF_STAGING, dal))
                {
                    var programFile = dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_FilesMerge, new Dictionary<string, string>() { { "FileName", fileName }, {  "Type", "Program"} });
                    var program = Utilities.ObjectConversion.ConvertTo<ProgramFile>(programFile);
                    var fileId = program[0].FileId;

                    var ids = dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_drfMerge, new Dictionary<string, object>() { { "FileId", fileId } } );
                    var races = Utilities.ObjectConversion.ConvertTo<ProgramRace>(ids);
                   
                    var dr2 = files.Where(x => x.Contains("DR2")).FirstOrDefault();
                    ImportData(dr2, TableName.DR2_STAGING, dal);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_dr2Merge);
                                     
                    var csv = string.Join(",", races.Select(p => p.RaceId.ToString()));

                    var dictionary = new Dictionary<string, string>()
                    {
                        { "RaceIds", csv }
                    };
                    
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_HorseInformationMerge, dictionary);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_HorseStatisticalAnalysisHistory, dictionary);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_JockeysMerge, dictionary);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_TrainersMerge, dictionary);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_RaceParticipantsInsert, new Dictionary<string, object>() { { "FileId", fileId } });
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_WorkoutHistoryInsert, dictionary);
                    
                    var dr3 = files.Where(x => x.Contains("DR3")).FirstOrDefault();
                    ImportData(dr3, TableName.DR3_STAGING, dal);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_dr3Merge);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_HorseHistoryInsert, dictionary);

                    var dr4 = files.Where(x => x.Contains("DR4")).FirstOrDefault();
                    ImportData(dr4, TableName.DR4_STAGING, dal);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_dr4Insert);
                    dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_TrntStatInsert);
                }
            }
            
            return raceInfo;
        }

        public List<RaceInformation> ProcessFiles(string path, string fileName)
        {
            List<RaceInformation> raceInfo = null;
            var dal = new FastTrackContext(DataBaseConnection);

            var files = Directory.GetFiles(path, fileName);

            string file = files.Where(x => x.IndexOf(FileType.RAC, StringComparison.OrdinalIgnoreCase) > 0).SingleOrDefault();

            if (!string.IsNullOrWhiteSpace(file))
            {
                if (!string.IsNullOrWhiteSpace(file))
                {
                    raceInfo = ProcessRACFile(file, dal);
                }

                ProcessFile(files, FileType.ENT, dal);
                ProcessFile(files, FileType.HOR, dal);
                ProcessFile(files, FileType.WOR, dal);
            }
            else
            {
                file = files.Where(x => x.IndexOf(FileType.XDR, StringComparison.OrdinalIgnoreCase) > 0).SingleOrDefault();
                ProcessFile(files, FileType.XDR, dal);
            }

            return raceInfo;
        }

        private bool ImportData(string fileName, string tableName, FastTrackContext dal)
        {
            DataTable table = dal.GetTableStructure(tableName);
            table.TableName = tableName;
            var data = Utilities.InputOutput.ReadCSV(fileName);
            if (data.Count > 0)
            {
                Utilities.InputOutput.FillDatable(data, table);
                dal.TruncateTable(tableName);
                dal.ImportData(table);
                return true;
            }

            var info = new FileInfo(fileName);
            var destination = $@"{ErrorPath}\{info.Name}";
            if (File.Exists(destination))
            {
                File.Delete(destination);
            }

            File.Move(fileName, destination);
            return false;
        }

        private void ProcessFile(string[] files, string type, FastTrackContext dal)
        {
            string file = files.Where(x => x.IndexOf(type, StringComparison.OrdinalIgnoreCase) > 0).SingleOrDefault();

            if (!string.IsNullOrWhiteSpace(file))
            {
                if (type == FileType.ENT)
                    ProcessDataFile(file, TableName.ENT_STAGING, dal, new string[] { StoreProcedures.vsp_HorsesMerge, StoreProcedures.vsp_JockeysMerge, StoreProcedures.vsp_TrainersMerge, StoreProcedures.vsp_EntMerge });
                else if (type == FileType.HOR)
                    ProcessDataFile(file, TableName.HOR_STAGING, dal, new string[] { StoreProcedures.vsp_HorseHistoryInsert, StoreProcedures.vsp_HorseHistoryStatsInsert });
                else if (type == FileType.WOR)
                    ProcessDataFile(file, TableName.WOR_STAGING, dal, new string[] { StoreProcedures.vsp_WorkoutHistoryInsert });
                else if (type == FileType.XDR)
                    ProcessDataFile(file, TableName.XDR_STAGING, dal, new string[] { StoreProcedures.vsp_ResultInsert });
            }
        }

        private List<RaceInformation> ProcessRACFile(string fileName, FastTrackContext dal)
        {
            var list = new List<RaceInformation>();
            ImportData(fileName, TableName.RAC_STAGING, dal);

            using (var ds = dal.InsertData(StoreProcedures.vsp_RacInsert))
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    var info = new RaceInformation();
                    info.RacID = row.Field<int>("RacID");
                    info.RaceDt = row.Field<DateTime>("RaceDt");
                    info.TrackCd = row.Field<string>("TrackCd");
                    info.RaceNum = row.Field<int>("RaceNum");
                    info.Distance = (float)row.Field<double>("Distance");
                    info.Furlong = (float)row.Field<double>("Furlong");
                    info.TurfInd = row.Field<int>("TurfInd");

                    list.Add(info);
                }
            }

            return list;
        }

        private void ProcessDataFile(string fileName, string tableName, FastTrackContext dal, string[] storeProcedures)
        {
            ImportData(fileName, tableName, dal);

            foreach (string storeProcedure in storeProcedures)
            {
                dal.ExecuteStoreProcedure(storeProcedure);
            }
        }
    }
}
