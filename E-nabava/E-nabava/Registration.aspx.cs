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
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
            try
            {
                //Generiranje aktivacijskog koda
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
                comm.Parameters.AddWithValue("@Tip",2);
                comm.Parameters.AddWithValue("@Aktiviran", 0);
                comm.Parameters.AddWithValue("@Aktivacijski_kod", kod.ToString());
                comm.ExecuteNonQuery();

                SaljiPoruku(tbEmail.Text, kod.ToString(), tbKorisnickoIme.Text);

                Response.Redirect("Login.aspx");
                Response.Write("Registracija uspjesna");

                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Error:" + ex.ToString());
            }

        }

        public void SaljiPoruku(String email, String kod, String korIme)
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.To.Add("tomislav.hop@gmail.com");
            mail.From = new MailAddress(email, "Aktivacija računa", System.Text.Encoding.UTF8);
            mail.Subject = "Aktivacija računa";
            mail.SubjectEncoding = System.Text.Encoding.UTF8;
            mail.Body = "Korisničko ime: " + korIme + "<br>Aktivacijski kod: " + kod + "<br>Kliknite ovdje kako bi aktivirali račun: http://localhost:49993/Authenticate.aspx?korIme=" + korIme + "&aktKod=" + kod;
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.IsBodyHtml = true;
            mail.Priority = MailPriority.High;
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("fejk.tiskara@gmail.com", "NOVAlozinka");
            client.Port = 587;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
            try
            {
                client.Send(mail);
            }
            catch (Exception ex)
            {
                Exception ex2 = ex;
                string errorMessage = string.Empty;
                while (ex2 != null)
                {
                    errorMessage += ex2.ToString();
                    ex2 = ex2.InnerException;
                }
            }
        }

    }

}
