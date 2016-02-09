using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace E_nabava
{
    public class Baza
    {
        public string DohvatiVrijednost(string sql)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
            conn.Open();
            string passwordQuery = sql;
            SqlCommand passComm = new SqlCommand(passwordQuery, conn);
            string vrati = passComm.ExecuteScalar().ToString();
            conn.Close();
            return vrati;
        }

        public int izvrsiSQLinsert(String sql)
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
                Guid guid = Guid.NewGuid();
                conn.Open();
                string insertQuerry = sql;
                SqlCommand comm = new SqlCommand(insertQuerry, conn);
                Int32 newId = (Int32)comm.ExecuteScalar();
                conn.Close();
                return newId;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
    }
}