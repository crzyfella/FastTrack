using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace FastTrack.Core.DAL
{
    public class FastTrackContext 
    {
        private readonly string _connectionString;

        public FastTrackContext(string connection)
        {
            _connectionString = connection;
        }

        public DataTable GetTableStructure(string tableName)
        {
            DataTable table = new DataTable();

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var cmd = new SqlCommand("SELECT TOP 0 * FROM " + tableName, conn))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            return table;
        }

        public void ImportData(DataTable table)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(conn))
                {
                    sqlBulkCopy.DestinationTableName = table.TableName;
                    sqlBulkCopy.WriteToServer(table);
                }
            }
        }

        public DataSet InsertData(string storeProcedure)
        {
            var ds = new DataSet();

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(comm);
                    da.Fill(ds);
                }
            }

            return ds;
        }

        public void InsertDataTable(string storeProcedure, DataTable table)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@datatable", table).SqlDbType = SqlDbType.Structured;

                    comm.ExecuteNonQuery();
                }
            }
        }

        public void ExecuteStoreProcedure(string storeProcedure)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.ExecuteNonQuery();
                }
            }
        }

        public void TruncateTable(string tableName)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand("TRUNCATE TABLE " + tableName, conn))
                {
                    comm.CommandType = CommandType.Text;

                    comm.ExecuteNonQuery();
                }
            }
        }

        public DataTable ExecuteStoreProcedure(string storeProcedure, int id)
        {
            DataTable table = new DataTable();

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@Id", id);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(comm))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            return table;
        }

        public DataTable ExecuteStoreProcedure(string storeProcedure, Dictionary<string, string> parameters)
        {
            DataTable table = new DataTable();

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.CommandTimeout = 180;

                    foreach (var item in parameters)
                    {
                        comm.Parameters.AddWithValue(item.Key, item.Value);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(comm))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            return table;
        }

        public DataTable ExecuteStoreProcedure(string storeProcedure, Dictionary<string, object> parameters)
        {
            DataTable table = new DataTable();

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open(); 

                using (var comm = new SqlCommand(storeProcedure, conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        foreach (var item in parameters)
                        {
                            comm.Parameters.AddWithValue(item.Key, item.Value);
                        }
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(comm))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            return table;
        }
    }     
}
