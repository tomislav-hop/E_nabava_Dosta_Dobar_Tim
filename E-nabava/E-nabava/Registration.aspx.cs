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
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                string provjeriKorisnika = "select count(*) from Korisnici where korisnicko_ime='" + tbKorisnickoIme.Text + "'";
                SqlCommand comm = new SqlCommand(provjeriKorisnika, conn);
                int temp = Convert.ToInt32(comm.ExecuteScalar().ToString());
                if (temp == 1)
                {
                    Response.Write("Korisnicko ime je zauzeto!");
                }
                conn.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (provjeraKorImena())
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
                try
                {
                    Random random = new Random();
                    int kod = random.Next(1000, 100000000);
                    Guid guid = Guid.NewGuid();
                    conn.Open();
                    string insertQuerry = "insert into  Korisnici (id_korisnici,naziv,adresa,email,broj_telefona,korisnicko_ime,lozinka,tip_korisnika,aktiviran,aktivacijski_kod) values (@Id,@Naziv,@Adresa,@Email,@Broj,@Korime,@Lozinka,@Tip,@Aktiviran,@Aktivacijski_kod)";
                    SqlCommand comm = new SqlCommand(insertQuerry, conn);
                    Response.Write("da");
                    comm.Parameters.AddWithValue("@Id", guid);
                    comm.Parameters.AddWithValue("@Naziv", tbNaziv.Text);
                    comm.Parameters.AddWithValue("@Adresa", tbAdresa.Text);
                    comm.Parameters.AddWithValue("@Email", tbEmail.Text);
                    comm.Parameters.AddWithValue("@Broj", tbBrojTelefona.Text);
                    comm.Parameters.AddWithValue("@Korime", tbKorisnickoIme.Text);
                    comm.Parameters.AddWithValue("@Lozinka", tbLozinka.Text);
                    comm.Parameters.AddWithValue("@Tip", 2);
                    comm.Parameters.AddWithValue("@Aktiviran", 0);
                    comm.Parameters.AddWithValue("@Aktivacijski_kod", kod.ToString());
                    comm.ExecuteNonQuery();

                    Mail mail = new Mail();
                    mail.saljiMail("fejk.tiskara@gmail.com", "tomislav.hop@gmail.com", "Aktivacija računa", "Korisničko ime: " + tbKorisnickoIme.Text + "\nAktivacijski kod: " + kod.ToString() + "\nKliknite ovdje kako bi aktivirali račun: http://localhost:49993/Authenticate.aspx?korIme=" + tbKorisnickoIme.Text + "&aktKod=" + kod.ToString(), null);

                    Response.Redirect("Login.aspx");
                    Response.Write("Registracija uspjesna");

                    conn.Close();
                }
                catch (Exception ex)
                {
                    Response.Write("Error:" + ex.ToString());
                }
            }
            else
            {
                Response.Redirect("Registration.aspx");
            }
        }      

        protected bool provjeraKorImena()
        {
            Baza baza = new Baza();
            int vrijednost = int.Parse(baza.DohvatiVrijednost("SELECT count(*) FROM korisnici WHERE korisnicko_ime='" + tbKorisnickoIme.Text +"'"));
            if (vrijednost > 0) 
            {
                tbKorisnickoIme.Text = "Korisnicko ime vec postoji";
                return false;
            }
            return true;
        }
    }

}
