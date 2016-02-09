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
                        string sessionQuery = "select tip_korisnika from Korisnici where korisnicko_ime='" + tbUname.Text + "'";
                        SqlCommand sessComm = new SqlCommand(sessionQuery, conn);
                        string tip = sessComm.ExecuteScalar().ToString().Replace(" ", "");
                        
                        if (tip.Equals(referent))
                        {
                          
                            Session["sesija"] = referent;
                            Response.Write("Password is correct!");
                            Response.Redirect("Referent.aspx");

                        }
      
                        
                        else if (tip.Equals(dobavljac))
                        {
                           
                            Session["sesija"] = dobavljac;
                            Response.Write("Password is correct!");
                            Response.Redirect("Dobavljac.aspx");

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

        public void SaljiPoruku()
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.To.Add("tomislav.hop@gmail.com");
            mail.From = new MailAddress("tomislav.hop@gmail.com", "Aktivacija računa", System.Text.Encoding.UTF8);
            mail.Subject = "Aktivacija računa";
            mail.SubjectEncoding = System.Text.Encoding.UTF8;
            mail.Body = "Ovdje ide sadrzaj maila";
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
                //Page.RegisterStartupScript("UserMsg", "<script>alert('Successfully Send...');if(alert){ window.location='SendMail.aspx';}</script>");
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
                //Page.RegisterStartupScript("UserMsg", "<script>alert('Sending Failed...');if(alert){ window.location='SendMail.aspx';}</script>");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            SaljiPoruku();
        }
    }
}