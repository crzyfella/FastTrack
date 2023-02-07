using FastTrack.Core.Business.Processor;
using log4net;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FastTrack
{
    public partial class frmMain : Form
    {
        private List<string> _filesName = new List<string>();
        private string _connection = ConfigurationManager.AppSettings["Kelso"];
        private string _archiveRacing = ConfigurationManager.AppSettings["ArchiveRacing"];
        private string _archiveResult = ConfigurationManager.AppSettings["ArchiveResult"];
        private string _errorFiles = ConfigurationManager.AppSettings["ErrorFiles"];
        private ILog _log = null;
        private BindingSource bindingSource = new BindingSource();
        private SqlDataAdapter dataAdapter = new SqlDataAdapter();

        public frmMain()
        {
            InitializeComponent();
            log4net.GlobalContext.Properties["LogLocation"] = ConfigurationManager.AppSettings["ErrorFiles"];
            log4net.Config.XmlConfigurator.Configure();
            _log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

            lblFileLocationPath.Text = ConfigurationManager.AppSettings["SourceLocation"];

            if (Directory.GetFiles(lblFileLocationPath.Text, "*.zip").Length > 0)
            {
                var files = Directory.GetFiles(lblFileLocationPath.Text, "*.zip");
                var files_no_extension = files.Select(x => x.Replace(lblFileLocationPath.Text, string.Empty)).Distinct();
                files_no_extension = files_no_extension.Select(x => x.Replace(".zip", string.Empty));
                lBoxFiles.Items.AddRange(files_no_extension.ToArray());
                lblTotalFilesCount.Text = lBoxFiles.Items.Count.ToString();
                lblFilesInQueueCount.Text = lBoxFiles.Items.Count.ToString();
                lblProcessCount.Text = "0";
            }
            else
            {
                var files = Directory.GetFiles(lblFileLocationPath.Text);
                var files_no_extension = files.Select(x => x.Remove(x.Length - 3, 1).Replace(".", ".*").Replace(lblFileLocationPath.Text, string.Empty)).Distinct();
                lBoxFiles.Items.AddRange(files_no_extension.ToArray());
                lblTotalFilesCount.Text = lBoxFiles.Items.Count.ToString();
                lblFilesInQueueCount.Text = lBoxFiles.Items.Count.ToString();
                lblProcessCount.Text = "0";

                GlobalContext.Properties["LogLocation"] = ConfigurationManager.AppSettings["LogLocation"];
                log4net.Config.XmlConfigurator.Configure();
                _log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
            }
        }

        private void bttnStart_Click(object sender, EventArgs e)
        {
            var import = new DataFiles();
            import.DataBaseConnection = _connection;

            Task task = Task.Factory.StartNew(() =>
            {
                int idx = 0;

                while(lBoxFiles.Items.Count > 0)
                {
                    lblFileName.Invoke(new Action(() => lblFileName.Text = lBoxFiles.Items[0].ToString()));
                    lblFilesInQueueCount.Invoke(new Action(() => lblFilesInQueueCount.Text = (int.Parse(lblFilesInQueueCount.Text) - 1).ToString()));
                    idx++;

                    try
                    {
                        string[] operators = { "n", "x" };
                        var isZipFile = operators.Any(x => lblFileName.Text.EndsWith(x)) ? true : false; 
                        var raceInfo = isZipFile ? import.ProcessFiles(lblFileLocationPath.Text, lblFileName.Text, true) : import.ProcessFiles(lblFileLocationPath.Text, lblFileName.Text);
                        lblRaceNum.Text = string.Empty;

                        if (raceInfo != null)
                        {
                            foreach (var race in raceInfo)
                            {
                                var processRace = new Races();
                                processRace.DataBaseConnection = _connection;

                                lblRaceNum.Invoke(new Action(() => lblRaceNum.Text = "Processing Race Num " + race.RaceNum.ToString()));
                                processRace.Process(race);
                                lblRaceNum.Invoke(new Action(() => lblRaceNum.Text = "Completed Processing Race Num " + race.RaceNum.ToString()));
                            }
                            
                            ArchiveFiles(_archiveRacing);
                        }
                        else
                        {
                            if (isZipFile)
                            {
                                string zipPath = $@"{lblFileLocationPath.Text}\{lblFileName.Text}.zip";
                                File.Delete(zipPath);
                            }
                            else
                            {
                                ArchiveFiles(_archiveResult);
                            }
                        }
                    }
                    catch (Exception Ex)
                    {
                        _log.Debug("File: " + lblFileName.Text, Ex);
                        ArchiveFiles(_errorFiles);
                    }

                    lblProcessCount.Invoke(new Action(() => lblProcessCount.Text = idx.ToString()));
                    lBoxFiles.Invoke(new Action(() => lBoxFiles.Items.RemoveAt(0)));
                    var files = Directory.GetFiles(lblFileLocationPath.Text, lblFileName.Text);
                }
            });
        }

        private void ArchiveFiles(string location)
        {
            var files = Directory.GetFiles(lblFileLocationPath.Text, lblFileName.Text);

            foreach (string file in files)
            {
                var info = new FileInfo(file);

                if (File.Exists(location + info.Name))
                    File.Delete(location + info.Name);

                File.Move(info.FullName, location + info.Name);
            }
        }

        private void cbTrack_Enter(object sender, EventArgs e)
        {
            var program = new RaceProgram();
            program.DataBaseConnection = _connection;
            
            this.cbTrack.Items.Clear();
            var list = program.Get(this.pickerRaceDt.Value);

            this.cbTrack.Items.AddRange(list.ToArray());
        }

        private void btnProgram_Click(object sender, EventArgs e)
        {
            var program = new RaceProgram();
            program.DataBaseConnection = _connection;

            program.Create(this.pickerRaceDt.Value, this.cbTrack.Text);
        }
    }
}
