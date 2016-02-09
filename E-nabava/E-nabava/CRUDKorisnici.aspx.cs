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
    public partial class CRUDKorisnici : System.Web.UI.Page
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
            string strQuery = "select korisnici.id_korisnici,korisnici.naziv , korisnici.adresa ,  korisnici.email , korisnici.broj_telefona ,  korisnici.korisnicko_ime,korisnici.lozinka,korisnici.tip_korisnika,korisnici.aktiviran,korisnici.aktivacijski_kod,tip_korisnika.naziv_tipa as naziv1 from korisnici , tip_korisnika  where  korisnici.tip_korisnika=tip_korisnika.id_tip;";

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

        protected void dodajNovogKorisnika(object sender, EventArgs e)
        {
            
            string naziv = ((TextBox)GridView1.FooterRow.FindControl("txtNaziv1")).Text;
            string adresa = ((TextBox)GridView1.FooterRow.FindControl("txtAdresa1")).Text;
            string email  = ((TextBox)GridView1.FooterRow.FindControl("txtEmail1")).Text;
            string brojTelefona = ((TextBox)GridView1.FooterRow.FindControl("txtBrojTelefona1")).Text;
            string korisnickoIme = ((TextBox)GridView1.FooterRow.FindControl("txtKorisnickoIme1")).Text;
            string lozinka = ((TextBox)GridView1.FooterRow.FindControl("txtLozinka1")).Text;
            string aktiviran = ((TextBox)GridView1.FooterRow.FindControl("txtAktiviran1")).Text;
            string aktivacijskiKod = ((TextBox)GridView1.FooterRow.FindControl("txtAktivacijskiKod1")).Text;
            string tipKorisnika = ((DropDownList)GridView1.FooterRow.FindControl("ddlTip")).SelectedItem.Value;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            Random random = new Random();
            int kod = random.Next(1000, 100000000);
            Guid guid = Guid.NewGuid();
            cmd.CommandText = "insert into korisnici (id_korisnici,naziv,adresa,email,broj_telefona,korisnicko_ime,lozinka,tip_korisnika,aktiviran,aktivacijski_kod) " + "values(@aa,@a,@b,@c,@d,@e,@f,@g,@h,@i);" +

            "select korisnici.id_korisnici,korisnici.naziv , korisnici.adresa ,  korisnici.email , korisnici.broj_telefona ,  korisnici.korisnicko_ime,korisnici.lozinka,korisnici.tip_korisnika,korisnici.aktiviran,korisnici.aktivacijski_kod,tip_korisnika.naziv_tipa as naziv1 from korisnici , tip_korisnika  where  korisnici.tip_korisnika=tip_korisnika.id_tip;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = naziv;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = adresa;
            cmd.Parameters.Add("@c", SqlDbType.VarChar).Value = email;
            cmd.Parameters.Add("@d", SqlDbType.VarChar).Value = brojTelefona;
            cmd.Parameters.Add("@e", SqlDbType.VarChar).Value = korisnickoIme;
            cmd.Parameters.Add("@f", SqlDbType.VarChar).Value = lozinka;
            cmd.Parameters.Add("@g", SqlDbType.VarChar).Value = tipKorisnika;
            cmd.Parameters.Add("@h", SqlDbType.VarChar).Value = aktiviran;
            cmd.Parameters.Add("@i", SqlDbType.VarChar).Value = aktivacijskiKod;
            cmd.Parameters.Add("@aa", SqlDbType.VarChar).Value = guid.ToString();


            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void EditKorisnici(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }

        protected void UpdateKorisnici(object sender, GridViewUpdateEventArgs e)
        {
            string id = ((Label)GridView1.Rows[e.RowIndex]
                        .FindControl("lblIdKorisnika")).Text;
            string naziv = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtNaziv")).Text;
            string adresa = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtAdresa")).Text;
            string email = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtEmail")).Text;
            string brojTelefona = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtBrojTelefona")).Text;
            string korisnickoIme = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtKorisnickoIme")).Text;
            string lozinka = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtLozinka")).Text;
            string aktiviran = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtAktiviran")).Text;
            string aktivacijskiKod = ((TextBox)GridView1.Rows[e.RowIndex]
                        .FindControl("txtAktivacijskiKod")).Text;

            string tipKorisnika = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlTip1")).SelectedItem.Value;
            Random random = new Random();
            int kod = random.Next(1000, 100000000);
            Guid guid = Guid.NewGuid();
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update korisnici set naziv=@a," +
             "adresa=@b,email=@c,broj_telefona=@d,korisnicko_ime=@e,lozinka=@f,aktiviran=@g,tip_korisnika=@g,aktivacijski_kod=@i where id_korisnici=@aa;" +
             "select korisnici.id_korisnici,korisnici.naziv , korisnici.adresa ,  korisnici.email , korisnici.broj_telefona ,  korisnici.korisnicko_ime,korisnici.lozinka,korisnici.tip_korisnika,korisnici.aktiviran,korisnici.aktivacijski_kod,tip_korisnika.naziv_tipa as naziv1 from korisnici , tip_korisnika  where  korisnici.tip_korisnika=tip_korisnika.id_tip;";
            cmd.Parameters.Add("@a", SqlDbType.VarChar).Value = naziv;
            cmd.Parameters.Add("@b", SqlDbType.VarChar).Value = adresa;
            cmd.Parameters.Add("@c", SqlDbType.VarChar).Value = email;
            cmd.Parameters.Add("@d", SqlDbType.VarChar).Value = brojTelefona;
            cmd.Parameters.Add("@e", SqlDbType.VarChar).Value = korisnickoIme;
            cmd.Parameters.Add("@f", SqlDbType.VarChar).Value = lozinka;
            cmd.Parameters.Add("@g", SqlDbType.VarChar).Value = tipKorisnika;
            cmd.Parameters.Add("@h", SqlDbType.VarChar).Value = aktiviran;
            cmd.Parameters.Add("@i", SqlDbType.VarChar).Value = aktivacijskiKod;
            cmd.Parameters.Add("@aa", SqlDbType.VarChar).Value = id;

            GridView1.EditIndex = -1;
            GridView1.DataSource = GetData(cmd);
            GridView1.DataBind();
        }

        protected void DeleteKorisnik(object sender, EventArgs e)
        {
            LinkButton lnkRemove = (LinkButton)sender;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from  korisnici where " +
            "id_korisnici=@a;" +
           "select korisnici.id_korisnici,korisnici.naziv , korisnici.adresa ,  korisnici.email , korisnici.broj_telefona ,  korisnici.korisnicko_ime,korisnici.lozinka,korisnici.tip_korisnika,korisnici.aktiviran,korisnici.aktivacijski_kod,tip_korisnika.naziv_tipa as naziv1 from korisnici , tip_korisnika  where  korisnici.tip_korisnika=tip_korisnika.id_tip;";
            
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
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlTip1");
                string query = "select  id_tip,naziv_tipa  from tip_korisnika";
                SqlCommand cmd = new SqlCommand(query);
                ddl.DataSource = GetData(cmd);
                ddl.DataTextField = "naziv_tipa";
                ddl.DataValueField = "id_tip";
                ddl.DataBind();

                ddl.Items.FindByText((e.Row.FindControl("lblNaziv") as Label).Text).Selected = true;
            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
             DropDownList ddl = GridView1.FooterRow.FindControl("ddlTip") as DropDownList;

            ddl.Items.Insert(0, new ListItem("Odaberite podkategoriju", "0"));
        }
    }
}