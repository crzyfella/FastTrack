using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CsvHelper;
using FastTrack.Core.Data;
using System.Collections.Generic;
using System.Reflection;
using System.Globalization;
using System.Configuration;

namespace FastTrack.Core.Business.Utilities
{
    public class InputOutput
    {
        public static List<string[]> ReadCSV(string fileName)
        {
            var records = new List<string[]>();
            var errors = new List<string>();

            using (TextReader fileReader = File.OpenText(fileName))
            {
                var parser = new CsvParser(fileReader);
                parser.Configuration.BadDataFound = context => errors.Add(context.RawRecord);

                while (true)
                {
                    string[] row = parser.Read();
                    if (row == null)
                    {
                        break;
                    }
                   
                    records.Add(row);
                }
            }

            if (errors.Count > 0)
            {
                return new List<string[]>();
            }

            return records;
        }

        public static void FillDatable(List<string[]> data, DataTable table)
        {
            string tableName = table.TableName.ToUpper();

            foreach (var line in data)
            {
                if (line != null)
                {
                    DataRow row = table.NewRow();
                    var array = line.ToArray();

                    if (string.Equals(tableName, TableName.XDR_STAGING, StringComparison.OrdinalIgnoreCase) || tableName.Contains("KELSO.BRISNET_"))
                    {
                        for (int i = 0; i < array.Count(); i++)
                        {
                            if (i == 1)
                            {
                                string date = array[1].ToString();
                                array[1] = date.Substring(4, 2) + "/" + date.Substring(6, 2) + "/" + date.Substring(0, 4);
                            }
                            else
                            {
                                if (string.IsNullOrWhiteSpace(array[i].ToString()))
                                {
                                    array[i] = null;
                                }
                            }
                        }
                    }

                    row.ItemArray = array;
                    table.Rows.Add(row);
                }
            }
        }

        public static string[] ConvertObjectToArray(object obj)
        {
            return obj.GetType()
                      .GetProperties()
                      .Select(p =>
                      {
                        object value = p.GetValue(obj, null);
                        return value == null ? null : value.ToString();
                      })
                      .ToArray();
        }
    }
}
