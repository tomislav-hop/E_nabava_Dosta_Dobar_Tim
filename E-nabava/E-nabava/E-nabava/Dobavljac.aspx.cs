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


namespace E_nabava
{
    public partial class Dobavljac : System.Web.UI.Page
    {
        private static int idReda = 0;
        string connectionString = ConfigurationManager.ConnectionStrings
                                         ["E-nabavaConnectionString"].ConnectionString;

        string dobavljac = Convert.ToString(2);
        protected void Page_Load(object sender, EventArgs e)
        {


            if (Session["sesija"] != null)
            {
                if (Session["sesija"].ToString().Equals(dobavljac))
                {
                    if (!IsPostBack)
                    {


                        tbArtikl.Enabled = false;
                        DataTable dt = new DataTable();
                        dt.Columns.AddRange(new DataColumn[9] { new DataColumn("Artikl"), new DataColumn("Količina"), new DataColumn("Cijena"), new DataColumn("Rok Plaćanja"), new DataColumn("Rok isporuke"), new DataColumn("Način plaćanja"), new DataColumn("Tražena kvaliteta"), new DataColumn("Napomena"), new DataColumn("Alternativa") });
                        ViewState["Ponuda"] = dt;
                        
                        this.BindGrid();

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

            // Add the initial item - you can add this even if the options from the
            // db were not successfully loaded

            ddl.Items.Insert(0, new ListItem(title, "0"));


        }

      

        protected void Button1_Click1(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["Ponuda"];
            dt.Rows.Add(tbArtikl.Text, tbKolicina.Text, tbCijena.Text, tbRokPlacanja.Text, tbRokIsporuke.Text, DropDownList1.SelectedValue,DropDownList2.SelectedValue, tbNapomena.Text, tbAlternativa.Text);
            ViewState["Ponuda"] = dt;
            this.BindGrid();

           

        }

        protected void BindGrid()
        {
            gwPonuda.DataSource = (DataTable)ViewState["Ponuda"];
            gwPonuda.DataBind();
        }


        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void gwPonuda_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gwPonuda_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {


            int index = Convert.ToInt32(e.RowIndex);

            DataTable dt = ViewState["Ponuda"] as DataTable;
            dt.Rows[index].Delete();
            ViewState["Ponuda"] = dt;
            BindGrid();
        }

       

        protected void Button2_Click(object sender, EventArgs e)
        {
            //Response.Write("");
            Response.Write("TEST");
            string strErrorDesc = "SAMONIK TEST";
            Response.Write(@"<script language='javascript'>alert('The following errors have occurred: \n" + strErrorDesc + " .');</script>");
            
        }

        protected void gwPonuda_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void gwPonuda_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);

            DataTable dt = ViewState["Ponuda"] as DataTable;
            dt.Rows[index].Delete();
            ViewState["Ponuda"] = dt;
            BindGrid();
        }

      

        

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string customerId = GridView1.DataKeys[e.Row.RowIndex].Value.ToString();
                GridView gvOrders = e.Row.FindControl("gvOrders") as GridView;
                gvOrders.DataSource = GetData("select opis,godisnja_kolicina,jedinica_mjere from artikli where id_artikla='"+customerId+"'");
                gvOrders.DataBind();
              
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

        protected void twKolicna_TextChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void TextBox1_TextChanged1(object sender, EventArgs e)
        {
           

        }

        protected void ddlKategorije_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlKategorije.AutoPostBack = true;
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void tbArtikl_TextChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           int index = Convert.ToInt32(e.CommandArgument);
            String ii = Convert.ToString(index);
            GridViewRow gvRow = GridView1.Rows[index];
            tbArtikl.Text = gvRow.Cells[4].Text;
        }
       
        
    }

}
    
