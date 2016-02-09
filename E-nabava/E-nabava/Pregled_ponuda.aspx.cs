using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Pregled_ponuda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["sesija"].ToString().Equals("2"))
            {
                Response.Redirect("PocetnaStranica.aspx");
            }
            else if (Session["sesija"].ToString().Equals("1"))
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToString().Equals("DodavanjeArtikla")) 
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow gvRow = GridView1.Rows[index];
                txtIDPonude.Text = gvRow.Cells[0].Text;
            }
        }
    }
}