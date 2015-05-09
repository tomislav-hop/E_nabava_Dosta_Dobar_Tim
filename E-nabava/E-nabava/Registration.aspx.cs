using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
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
            if (IsPostBack) {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["KorisniciConnectionString"].ConnectionString);
                conn.Open();
                string provjeriKorisnika="select count(*) from Korisnici where korisnicko_ime='"+tbKorisnickoIme.Text+"'";
                SqlCommand comm = new SqlCommand(provjeriKorisnika,conn);
                int temp  =   Convert.ToInt32(comm.ExecuteScalar().ToString());
                if(temp==1){
                Response.Write("Korisnicko ime je zauzeto!");
                }
                conn.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
             SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["KorisniciConnectionString"].ConnectionString);
               try{
                   Guid guid = Guid.NewGuid();  
                conn.Open();
                string insertQuerry="insert into  Korisnici (id_korisnici,naziv_dobavljaca,adresa_dobavljaca,email,broj_telefona,korisnicko_ime,lozinka) values (@Id,@Naziv,@Adresa,@Email,@Broj,@Korime,@Lozinka)";
                SqlCommand comm = new SqlCommand(insertQuerry,conn);
                comm.Parameters.AddWithValue("@Id", guid);
               comm.Parameters.AddWithValue("@Naziv",tbNaziv.Text);
               comm.Parameters.AddWithValue("@Adresa",tbAdresa.Text);
               comm.Parameters.AddWithValue("@Email",tbEmail.Text);
               comm.Parameters.AddWithValue("@Broj",tbBrojTelefona.Text);
               comm.Parameters.AddWithValue("@Korime",tbKorisnickoIme.Text);
               comm.Parameters.AddWithValue("@Lozinka",tbLozinka.Text);
               comm.ExecuteNonQuery();
               Response.Redirect("Manager.aspx");
               Response.Write("Registracija uspjesna");

                conn.Close();
               }
            catch(Exception ex){
            Response.Write("Error:"+ ex.ToString());
            }
          
        }
    }
}