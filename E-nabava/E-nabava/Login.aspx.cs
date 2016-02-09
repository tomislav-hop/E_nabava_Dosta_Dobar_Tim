using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;
namespace E_nabava
{
    public partial class Login : System.Web.UI.Page
    {
        string referent = Convert.ToString(1);
        string dobavljac = Convert.ToString(2);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Baza baza = new Baza();
            string JQueryVer = "1.7.1";
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-" + JQueryVer + ".min.js",
                DebugPath = "~/Scripts/jquery-" + JQueryVer + ".js",
                CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".min.js",
                CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-" + JQueryVer + ".js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
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
                    string passwordQuery = "select lozinka from Korisnici where korisnicko_ime='" + tbUname.Text + "'";
                    SqlCommand passComm = new SqlCommand(passwordQuery, conn);
                    string password = passComm.ExecuteScalar().ToString().Replace(" ", "");

                    if (password == tbPass.Text)
                    {
                        if (baza.DohvatiVrijednost("SELECT aktiviran FROM korisnici WHERE korisnicko_ime='" + tbUname.Text + "'").Equals("1"))
                        {
                            string sessionQuery = "select tip_korisnika from Korisnici where korisnicko_ime='" + tbUname.Text + "'";
                            SqlCommand sessComm = new SqlCommand(sessionQuery, conn);
                            string tip = sessComm.ExecuteScalar().ToString().Replace(" ", "");
                            if (tip.Equals(referent))
                            {
                                Session["sesija"] = referent;
                                Session["korIme"] = tbUname.Text;
                                Response.Write("Password is correct!");
                                Response.Redirect("Pregled_ponuda.aspx");

                            }
                            else if (tip.Equals(dobavljac))
                            {
                                Session["sesija"] = dobavljac;
                                Session["korIme"] = tbUname.Text;
                                Response.Write("Password is correct!");
                                Response.Redirect("Dobavljac.aspx");
                            }
                        }
                        else
                        {
                            Response.Write("Korisnik nije aktiviran!");
                        }
                    }
                    else
                    {
                        Response.Write("Password is incorrect!");
                    }
                }
                else
                {
                    Response.Write("Username is incorrect!");
                }
                conn.Close();
            }
        }

        protected void Button2_Click2(object sender, EventArgs e)
        {
            Response.Redirect("Pregled_Investicijskih_projekata.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("CRUDArtikli.aspx");
        }

        protected void btnLozinka_Click(object sender, EventArgs e)
        {
            Response.Redirect("ZaboravljenaLozinka.aspx");
        }
    }
}