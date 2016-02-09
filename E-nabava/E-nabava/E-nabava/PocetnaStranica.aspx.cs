using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Net.Mail;
namespace E_nabava
{
    public partial class PocetnaStranica : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString;

        DataSet ds = null;
        DataTable dt = null;
        string dobavljac = Convert.ToString(2);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] != null)
            {
                if (Session["sesija"].ToString().Equals(dobavljac))
                {
                    if (!IsPostBack)
                    {

                        DataTable dt = new DataTable();
                        dt.Columns.AddRange(new DataColumn[9] { new DataColumn("Artikl"), new DataColumn("Količina"), new DataColumn("Cijena"), new DataColumn("Rok Plaćanja"), new DataColumn("Rok isporuke"), new DataColumn("Način plaćanja"), new DataColumn("Tražena kvaliteta"), new DataColumn("Napomena"), new DataColumn("Alternativa") });
                       

                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["sesija"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void popualteDdList(string query, DropDownList ddl, string tf, string value, string title)
        {
            DataTable subjects = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    SqlDataAdapter adapter = new SqlDataAdapter(query, con);
                    adapter.Fill(subjects);
                    ddl.DataSource = subjects;
                    ddl.DataTextField = tf;
                    ddl.DataValueField = value;
                    ddl.DataBind();
                    con.Close();
                }
                catch (Exception ex)
                {
                    // Handle the error
                }
            }
            ddl.Items.Insert(0, new System.Web.UI.WebControls.ListItem(title, "0"));
        }









        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string customerId = GridView1.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView gvOrders = e.Row.FindControl("gvOrders") as GridView;
                gvOrders.DataSource = GetData("select artikli.opis from artikli where artikli.id_artikla='" + customerId + "';");
                gvOrders.DataBind();
                GridView gvOrders1 = e.Row.FindControl("GridView2") as GridView;
                gvOrders1.DataSource = GetData("select artikli.godisnja_kolicina from artikli where artikli.id_artikla='" + customerId + "';");
                gvOrders1.DataBind();
                GridView gvOrders2 = e.Row.FindControl("GridView3") as GridView;
                gvOrders2.DataSource = GetData("select artikli.jedinica_mjere from artikli where artikli.id_artikla='" + customerId + "';");
                gvOrders2.DataBind();
                GridView gvOrders3 = e.Row.FindControl("GridView4") as GridView;
                gvOrders3.DataSource = GetData("select podkategorije.naziv from artikli,podkategorije where artikli.id_artikla='" + customerId + "' and artikli.id_podkategorije=podkategorije.id_podkategorije");
                gvOrders3.DataBind();
                

            }
        }
        private static DataTable GetData(string query)
        {
            string strConnString = ConfigurationManager.ConnectionStrings
                                         ["E-nabavaConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            
                            return dt;
                        }
                    }
                }
            }

        }


        protected void ddlKategorije_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlKategorije.AutoPostBack = true;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            String ii = Convert.ToString(index);
            GridViewRow gvRow = GridView1.Rows[index];

        }
       

    }
}

