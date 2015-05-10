using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Authenticate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            tbUname.Text = Request.QueryString["korIme"];
            tbKod.Text = Request.QueryString["aktKod"];
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
                conn.Open();
                string provjeriKorisnika = "select count(*) from Korisnici where korisnicko_ime='" + tbUname.Text + "'";
                SqlCommand comm = new SqlCommand(provjeriKorisnika, conn);
                int temp = Convert.ToInt32(comm.ExecuteScalar().ToString());
                conn.Close();

                if (temp == 1)
                {
                    conn.Open();
                    string passwordQuery = "select aktivacijski_kod from Korisnici where korisnicko_ime='" + tbUname.Text + "'";
                    SqlCommand passComm = new SqlCommand(passwordQuery, conn);
                    string aktivacijski_kod = passComm.ExecuteScalar().ToString().Replace(" ", "");

                    if (aktivacijski_kod == tbKod.Text)
                    {
                        try
                        {
                            string insertQuerry = "update Korisnici set aktiviran = (@Aktiviran) where korisnicko_ime='" + tbUname.Text + "'";
                            SqlCommand insertComm = new SqlCommand(insertQuerry, conn);
                            insertComm.Parameters.AddWithValue("@Aktiviran", 1);
                            insertComm.ExecuteNonQuery();

                            Response.Redirect("Login.aspx");
                            Response.Write("Aktivacija uspjesna");
                        }
                        catch (Exception ex)
                        {
                            Response.Write("Error:" + ex.ToString());
                        }
                    }
                    else
                    {
                        Response.Write("Kod nije točan!");
                    }
                }
                else
                {
                    Response.Write("Username is incorrect!");
                }
                conn.Close();
            }
        }
    }
}