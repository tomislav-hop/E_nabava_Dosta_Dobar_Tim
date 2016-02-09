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
    public partial class CRUDProjekti : System.Web.UI.Page
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
            string strQuery = "select id_inv_projekt,izdao,projekt,naziv,rok,aktiviran,potvrda from investicijski_projekt";

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

        protected void dodajP(object sender, EventArgs e)
        {

            string izdao = ((TextBox)GridView1.FooterRow.FindControl("txtIzdao1")).Text;
            string projekt = ((TextBox)GridView1.FooterRow.FindControl("txtProjekt1")).Text;
            string naziv = ((TextBox)GridView1.FooterRow.FindControl("txtNaziv1")).Text;
            string rok = ((TextBox)GridView1.FooterRow.FindControl("txtRok1")).Text;
            string aktiviran = ((TextBox)GridView1.FooterRow.FindControl("txtAktiviran1")).Text;
            string potvrda = ((TextBox)GridView1.FooterRow.FindControl("txtPotvrda1")).Text;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into investicijski_projekt (izdao,projekt,naziv,rok,aktiviran,potvrda) " + "values(@a,@b,@c,@d,@e,@f);" +

            "select id_inv_projekt,izdao,projekt,naziv,rok,aktiviran,potvrda from investicijski_projekt";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = izdao;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = projekt;
            cmd.Parameters.Add("@c", SqlDbType.VarChar).Value = naziv;
            cmd.Parameters.Add("@d", SqlDbType.VarChar).Value = rok;
            cmd.Parameters.Add("@e", SqlDbType.VarChar).Value = aktiviran;
            cmd.Parameters.Add("@f", SqlDbType.VarChar).Value = potvrda;


            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void EditP(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }

        protected void UpdateP(object sender, GridViewUpdateEventArgs e)
        {
            string id = ((Label)GridView1.Rows[e.RowIndex]
                   .FindControl("lblIdProjekt")).Text;
            string izdao = ((TextBox)GridView1.Rows[e.RowIndex]
                    .FindControl("txtIzado")).Text;
            string projekt = ((TextBox)GridView1.Rows[e.RowIndex]
                                .FindControl("txtProjekt")).Text;
            string naziv = ((TextBox)GridView1.Rows[e.RowIndex]
                  .FindControl("txtNaziv")).Text;
            string rok = ((TextBox)GridView1.Rows[e.RowIndex]
            .FindControl("txtRok")).Text;
            string aktiviran = ((TextBox)GridView1.Rows[e.RowIndex]
           .FindControl("txtAktiviran")).Text;
            string potvrda = ((TextBox)GridView1.Rows[e.RowIndex]
           .FindControl("txtPotvrda")).Text;
            
            
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update investicijski_projekt set izdao=@b," +
             "projekt=@c,naziv=@d,rok=@e,aktiviran=@f,potvrda=@g where id_inv_projekt=@a;" +
             "select id_inv_projekt,izdao,projekt,naziv,rok,aktiviran,potvrda from investicijski_projekt";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = id;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = izdao;
            cmd.Parameters.Add("@c", SqlDbType.VarChar).Value = projekt;
            cmd.Parameters.Add("@d", SqlDbType.VarChar).Value = naziv;
            cmd.Parameters.Add("@e", SqlDbType.VarChar).Value = rok;
            cmd.Parameters.Add("@f", SqlDbType.VarChar).Value = aktiviran;
            cmd.Parameters.Add("@g", SqlDbType.VarChar).Value = potvrda;


            GridView1.EditIndex = -1;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void DeleteP(object sender, EventArgs e)
        {
            LinkButton lnkRemove = (LinkButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from  investicijski_projekt where " +
            "id_inv_projekt=@a;" +
             "select id_inv_projekt,izdao,projekt,naziv,rok,aktiviran,potvrda from investicijski_projekt";
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
            
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
           
        }
    }
}
