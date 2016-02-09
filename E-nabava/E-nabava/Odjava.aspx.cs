using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Odjava : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["sesija"] = null;
            Session["korIme"] = null;
            Response.Redirect("Login.aspx");
        }
    }
}