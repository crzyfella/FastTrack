using FastTrack.Core.Business.Utilities;
using FastTrack.Core.DAL;
using FastTrack.Core.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;

namespace FastTrack.Core.Business.Processor
{
    public class RaceProgram
    {
        public string DataBaseConnection { get; set; }
        private string ProgramFile = ConfigurationManager.AppSettings["ProgramLocation"];
        public RaceProgram() { }

        public void Create(DateTime raceDt, string trackName)
        {
            var dal = new FastTrackContext(DataBaseConnection);

            var dictionary = new Dictionary<string, string>();
            dictionary.Add("TrackName", trackName);
            dictionary.Add("RaceDt", raceDt.ToShortDateString());

            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_Program, dictionary);

            var program = new XmlDocument();
            program.LoadXml(@"<Program><Races></Races></Program>");

            var builder = new StringBuilder("<Program><Races>");

            foreach (DataRow row in race.Rows)
            {
                builder.Append(row.Field<string>("Race"));
            }

            builder.Append("</Races></Program>");

            var xml = new XmlDocument();
            xml.LoadXml(builder.ToString());

            string xsltFile = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + @"\Xslt\Program.xslt";
            var xslt = File.ReadAllText(xsltFile);

            XslCompiledTransform transform = new XslCompiledTransform();
            using (XmlReader reader = XmlReader.Create(new StringReader(xslt)))
            {
                transform.Load(reader);
            }

            StringWriter results = new StringWriter();
            using (XmlReader reader = XmlReader.Create(new StringReader(xml.OuterXml)))
            {
                transform.Transform(reader, null, results);
            }

            var fileName = $@"{ProgramFile}\{trackName} {raceDt.ToString("yyyMMdd")}.html";

            File.WriteAllText(fileName, results.ToString());
        }

        public List<string> Get(DateTime raceDt)
        {
            var track = new List<string>();
            var dal = new FastTrackContext(DataBaseConnection);

            var dictionary = new Dictionary<string, string>();
            dictionary.Add("RaceDt", raceDt.ToShortDateString());
            DataTable race = dal.ExecuteStoreProcedure(StoreProcedures.vsp_brisnet_ProgramGet, dictionary);

            track = (from DataRow row in race.Rows
                     select row.Field<string>("TrackName")).ToList();

            return track;
        }
    }
}
