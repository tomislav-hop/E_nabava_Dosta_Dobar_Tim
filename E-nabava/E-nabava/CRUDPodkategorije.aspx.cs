using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace E_nabava
{
    public partial class CRUDPodkategorije : System.Web.UI.Page
    {

        string dobavljac = Convert.ToString(2);
        string strConnString = ConfigurationManager.ConnectionStrings
                                         ["E-nabavaConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            //ODKOMENTIRAJ ZA OVLASTENJA
            /*if (Session["sesija"] == null)
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
            }  */ 
            if (!IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            string strQuery = "select podkategorije.id_podkategorije,podkategorije.naziv,kategorije.naziv as naziv1 from kategorije,podkategorije where kategorije.id_kategorije = podkategorije.id_kategorije ;";

            SqlCommand cmd = new SqlCommand(strQuery);
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();

        }
        protected void btnPotvrdi_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private DataTable GetData(SqlCommand cmd)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            con.Open();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            return dt;
        }

        protected void dodajNovuPK(object sender, EventArgs e)
        {
          
            string naziv = ((TextBox)GridView1.FooterRow.FindControl("txtNaziv1")).Text;
            string pk = ((DropDownList)GridView1.FooterRow.FindControl("ddlKategorije")).SelectedItem.Value;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into podkategorije (naziv,id_kategorije) " + "values(@a,@b);" +

            "select podkategorije.id_podkategorije,podkategorije.naziv,kategorije.naziv as naziv1 from kategorije,podkategorije where kategorije.id_kategorije = podkategorije.id_kategorije ;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = naziv;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = pk;
            


            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void EditPK(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }

        protected void UpdatePK(object sender, GridViewUpdateEventArgs e)
        {
            string idPK = ((Label)GridView1.Rows[e.RowIndex]
                   .FindControl("lblIdPodkategorije")).Text;
            string ime = ((TextBox)GridView1.Rows[e.RowIndex]
                    .FindControl("txtNaziv")).Text;

            string pk = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlKategorije1")).SelectedItem.Value;

            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update podkategorije set naziv=@b," +
             "id_kategorije=@c where id_podkategorije=@a;" +
             "select podkategorije.id_podkategorije,podkategorije.naziv,kategorije.naziv as naziv1 from kategorije,podkategorije where kategorije.id_kategorije = podkategorije.id_kategorije ;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = idPK;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = ime;
            cmd.Parameters.Add("@c", SqlDbType.VarChar).Value = pk;
            


            GridView1.EditIndex = -1;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void DeletePK(object sender, EventArgs e)
        {
            LinkButton lnkRemove = (LinkButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from  podkategorije where " +
            "id_podkategorije=@a;" +
            "select podkategorije.id_podkategorije,podkategorije.naziv,kategorije.naziv as naziv1 from kategorije,podkategorije where kategorije.id_kategorije = podkategorije.id_kategorije ;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value
                = lnkRemove.CommandArgument;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }
        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            BindData();
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }
        protected void popualteDdList(string query, DropDownList ddl, string tf, string value, string title)
        {
            DataTable subjects = new DataTable();



            using (SqlConnection con = new SqlConnection(strConnString))
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

            ddl.Items.Insert(0, new System.Web.UI.WebControls.ListItem(title, "0"));


        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlKategorije1");
                string query = "select  id_kategorije,naziv  from kategorije";
                SqlCommand cmd = new SqlCommand(query);
                ddl.DataSource = GetData(cmd);
                ddl.DataTextField = "naziv";
                ddl.DataValueField = "id_kategorije";
                ddl.DataBind();

                ddl.Items.FindByText((e.Row.FindControl("lblNaziv") as Label).Text).Selected = true;
            }
          
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            DropDownList ddl = GridView1.FooterRow.FindControl("ddlKategorije") as DropDownList;

            ddl.Items.Insert(0, new ListItem("Odaberite Kategoriju", "0"));
          
        }
    }
}
