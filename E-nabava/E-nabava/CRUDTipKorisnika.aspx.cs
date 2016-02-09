using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class CRUDTipKorisnika : System.Web.UI.Page
    {
        string strConnString = System.Configuration.ConfigurationManager.ConnectionStrings
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
            string strQuery = "select id_tip , naziv_tipa from tip_korisnika ; ";

            SqlCommand cmd = new SqlCommand(strQuery);
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();

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
        protected void dodajNoviTip(object sender, EventArgs e)
        {

            string naziv = ((TextBox)GridView1.FooterRow.FindControl("txtNaziv1")).Text;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tip_korisnika (naziv_tipa) " + "values(@a);" +
            "select id_tip , naziv_tipa from tip_korisnika ;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = naziv;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }
        protected void EditTip(object sender, GridViewEditEventArgs e)
        {

            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }
        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }
        protected void UpdateTip(object sender, GridViewUpdateEventArgs e)
        {

            string idTip = ((Label)GridView1.Rows[e.RowIndex]
                   .FindControl("lblIdTip")).Text;
            string ime = ((TextBox)GridView1.Rows[e.RowIndex]
                    .FindControl("txtNaziv")).Text;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tip_korisnika set naziv_tipa=@b " +
             "where id_tip=@a;" +
               "select id_tip , naziv_tipa from tip_korisnika ;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = idTip;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = ime;
            GridView1.EditIndex = -1;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }
        protected void DeleteTip(object sender, EventArgs e)
        {
            LinkButton lnkRemove = (LinkButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from  tip_korisnika where " +
            "id_tip=@a;" +
              "select id_tip , naziv_tipa from tip_korisnika ;";
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
    }
}