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
    public partial class Pregled_Investicijskih_Projekata : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["sesija"].ToString().Equals("2"))
            {
                izbornik.Visible = false;
                izbornik1.Visible = false;
            }
            else if (Session["sesija"].ToString().Equals("1"))
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToString().Equals("DodavanjeArtikla"))
            {
                int index = Convert.ToInt32(e.CommandArgument);
                String ii = Convert.ToString(index);
                GridViewRow gvRow = gwInvProjekti.Rows[index];
                txtOdabraniProjekt.Text = gvRow.Cells[1].Text;
                txtIdProjekta.Text = gvRow.Cells[0].Text;
            }
        }

        protected void btnPotvrdiProjekt_Click(object sender, EventArgs e)
        {
            String sql = "UPDATE investicijski_projekt SET potvrda=1 WHERE id_inv_projekt=" + txtIdProjekta.Text;
            izvrsiSQLinsert(sql);
            Mail mail = new Mail();
            mail.saljiMail("fejk.tiskara@gmail.com", "tomislav.hop@gmail.com", "Potvrda projekta", "Projekt sa id-jem " + txtIdProjekta.Text + "je potvrđen od " + Session["korime"], null);
        }

        protected void btnAlternativa_Click(object sender, EventArgs e)
        {
            Response.Redirect("Alternativa_projekt.aspx?idProjekta=" + txtIdProjekta.Text);
        }

        protected void izvrsiSQLinsert(String sql)
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString);
                Guid guid = Guid.NewGuid();
                conn.Open();
                string insertQuerry = sql;
                SqlCommand comm = new SqlCommand(insertQuerry, conn);
                comm.ExecuteScalar();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write("Error:" + ex.ToString());
            }
        }
    }
}