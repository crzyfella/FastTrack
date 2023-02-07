using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Reflection;

namespace FastTrack.Core.Business.Utilities
{
    public static class ObjectConversion
    {
        /// <summary>
        /// Convert the DataTable into an object, the properties of the object have the same name as the column
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="datatable"></param>
        /// <returns></returns>
        public static List<T> ConvertTo<T>(DataTable datatable) where T : new()
        {

            List<T> Temp = new List<T>();
            try
            {
                List<string> columnsNames = new List<string>();
                foreach (DataColumn DataColumn in datatable.Columns)
                    columnsNames.Add(DataColumn.ColumnName);
                Temp = datatable.AsEnumerable().ToList().ConvertAll<T>(row => getObject<T>(row, columnsNames));
                return Temp;
            }
            catch
            {
                return Temp;
            }

        }

        /// <summary>
        ///  Convert the DataTable into an object, the properties of the object will be converted according to the map parameter
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="datatable"></param>
        /// <param name="map"></param>
        /// <returns></returns>
        public static List<T> ConvertTo<T>(DataTable datatable, Hashtable map) where T : new()
        {
            List<T> Temp = new List<T>();
            try
            {
                List<string> columnsNames = new List<string>();
                foreach (DataColumn DataColumn in datatable.Columns)
                    columnsNames.Add(DataColumn.ColumnName);
                Temp = datatable.AsEnumerable().ToList().ConvertAll<T>(row => getMapObject<T>(row, columnsNames, map));
                return Temp;
            }
            catch
            {
                return Temp;
            }

        }

        /// <summary>
        ///  Generate an object based on the DataTable, the properties of the object have the same name as the column
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="row"></param>
        /// <param name="columnsName"></param>
        /// <returns></returns>
        public static T getObject<T>(DataRow row, List<string> columnsName) where T : new()
        {
            T obj = new T();
            try
            {
                string columnname = string.Empty;
                string value = string.Empty;
                PropertyInfo[] Properties;
                Properties = typeof(T).GetProperties();
                foreach (PropertyInfo objProperty in Properties)
                {
                    columnname = columnsName.Find(name => name.ToLower() == objProperty.Name.ToLower());
                    if (!string.IsNullOrEmpty(columnname))
                    {
                        value = row[columnname].ToString();
                        if (!string.IsNullOrEmpty(value))
                        {
                            if (Nullable.GetUnderlyingType(objProperty.PropertyType) != null)
                            {
                                value = row[columnname].ToString();
                                objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(Nullable.GetUnderlyingType(objProperty.PropertyType).ToString())), null);
                            }
                            else
                            {

                                value = row[columnname].ToString();
                                
                                if (objProperty.PropertyType.Name == "Guid")
                                    objProperty.SetValue(obj, Guid.Parse(value), null);
                                else
                                    objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(objProperty.PropertyType.ToString())), null);
                            }
                        }
                    }
                }
                return obj;
            }
            catch(Exception ex)
            {
                return obj;
            }
        }

        /// <summary>
        ///  Generate objects based on the DataTable, and the properties of the objects will be converted according to the map parameters
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="row"></param>
        /// <param name="columnsName"></param>
        /// <returns></returns>
        public static T getMapObject<T>(DataRow row, List<string> columnsName, Hashtable map) where T : new()
        {
            T obj = new T();
            try
            {
                string columnname = string.Empty;
                string value = string.Empty;
                PropertyInfo[] Properties;
                Properties = typeof(T).GetProperties();
                foreach (PropertyInfo objProperty in Properties)
                {
                    string prpertyName = objProperty.Name;
                    columnname = columnsName.Find(name => name.ToLower() == map[prpertyName].ToString().ToLower());
                    if (!string.IsNullOrEmpty(columnname))
                    {
                        value = row[columnname].ToString();
                        if (!string.IsNullOrEmpty(value))
                        {
                            if (Nullable.GetUnderlyingType(objProperty.PropertyType) != null)
                            {
                                value = row[columnname].ToString().Replace("$", string.Empty).Replace(",", string.Empty);
                                objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(Nullable.GetUnderlyingType(objProperty.PropertyType).ToString())), null);
                            }
                            else
                            {
                                value = row[columnname].ToString().Replace("%", string.Empty);
                                objProperty.SetValue(obj, Convert.ChangeType(value, Type.GetType(objProperty.PropertyType.ToString())), null);
                            }
                        }
                    }
                }
                return obj;
            }
            catch (Exception e)
            {
                string error = e.Message;
                return obj;
            }
        }

        public static DataTable ToDataTable<T>(IEnumerable<T> collection)
        {
            DataTable newDataTable = new DataTable();
            Type impliedType = typeof(T);
            PropertyInfo[] _propInfo = impliedType.GetProperties();
            foreach (PropertyInfo pi in _propInfo)
                newDataTable.Columns.Add(pi.Name, pi.PropertyType);

            foreach (T item in collection)
            {
                DataRow newDataRow = newDataTable.NewRow();
                newDataRow.BeginEdit();
                foreach (PropertyInfo pi in _propInfo)
                    newDataRow[pi.Name] = pi.GetValue(item, null);
                newDataRow.EndEdit();
                newDataTable.Rows.Add(newDataRow);
            }
            return newDataTable;
        }

    }
}
