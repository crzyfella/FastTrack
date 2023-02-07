using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace FastTrack.Core.Business.Utilities
{
    public static class Extensions
    {
        /// <summary>
        /// Converts a DataTable to a list with generic objects
        /// </summary>
        /// <typeparam name="T">Generic object</typeparam>
        /// <param name="table">DataTable</param>
        /// <returns>List with generic objects</returns>
        public static List<T> DataTableToList<T>(this DataTable table) where T : class, new()
        {
            try
            {
                List<T> list = new List<T>();

                foreach (var row in table.AsEnumerable())
                {
                    T obj = new T();

                    foreach (var prop in obj.GetType().GetProperties())
                    {
                        if (row.Table.Columns.Contains(prop.Name))
                        {
                            try
                            {
                                Type propertyType = prop.PropertyType;
                                Type dataType = propertyType;
                                PropertyInfo propertyInfo = obj.GetType().GetProperty(prop.Name);

                                if (dataType.Equals(typeof(Single)))
                                {
                                    float value = 0.0f;
                                    if (row[prop.Name] != DBNull.Value)
                                    {
                                        value = float.Parse(row[prop.Name].ToString());
                                    }

                                    propertyInfo.SetValue(obj, Convert.ChangeType(value, propertyInfo.PropertyType), null);
                                }
                                else
                                {
                                    if (row[prop.Name] != DBNull.Value)
                                    {
                                        propertyInfo.SetValue(obj, Convert.ChangeType(row[prop.Name], propertyInfo.PropertyType), null);
                                    }
                                }
                            }
                            catch
                            {
                                Console.WriteLine(prop.PropertyType);
                                Console.WriteLine(row[prop.Name].ToString());
                                continue;
                            }
                        }
                    }
                    list.Add(obj);
                }

                return list;
            }
            catch
            {
                return null;
            }
        }

        public static T ToObject<T>(this DataRow row) where T : class, new()
        {
            T obj = new T();

            foreach (var prop in obj.GetType().GetProperties())
            {
                try
                {
                    if (row.Table.Columns.Contains(prop.Name))
                    {
                        if (prop.PropertyType.IsGenericType && prop.PropertyType.Name.Contains("Nullable"))
                        {
                            if (!string.IsNullOrEmpty(row[prop.Name].ToString()))
                                prop.SetValue(obj, Convert.ChangeType(row[prop.Name],
                                Nullable.GetUnderlyingType(prop.PropertyType), null));
                        }
                        else
                        {
                            Type propertyType = prop.PropertyType;
                            Type dataType = propertyType;
                            PropertyInfo propertyInfo = obj.GetType().GetProperty(prop.Name);

                            if (dataType.Equals(typeof(Single)))
                            {
                                float value = 0.0f;
                                if (row[prop.Name] != DBNull.Value)
                                {
                                    value = float.Parse(row[prop.Name].ToString());
                                }

                                propertyInfo.SetValue(obj, Convert.ChangeType(value, propertyInfo.PropertyType), null);
                            }
                            else
                            {
                                if (row[prop.Name] != DBNull.Value)
                                {
                                    propertyInfo.SetValue(obj, Convert.ChangeType(row[prop.Name], propertyInfo.PropertyType), null);
                                }
                            }
                        }
                    }
                }
                catch
                {
                    continue;
                }
            }
            return obj;
        }

    }
}

