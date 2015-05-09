using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Dobavljac : System.Web.UI.Page
    {
        string dobavljac = Convert.ToString(2);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] != null)
            {
                if (Session["sesija"].ToString().Equals(dobavljac))
                {
                    lblWlc.Text = Session["sesija"].ToString();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            else {
                Response.Redirect("Login.aspx");
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           Session["sesija"] = null;
           Response.Redirect("Login.aspx"); 
        }
    }
}