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
        string connectionString = ConfigurationManager.ConnectionStrings
                                         ["E-nabavaConnectionString"].ConnectionString;
        DataTable dt = new DataTable();
        string dobavljac = Convert.ToString(2);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] != null)
            {
                if (Session["sesija"].ToString().Equals(dobavljac))
                {
                    if (!IsPostBack)
                    {
                        popualteDdList("SELECT id_kategorije, naziv FROM kategorije", ddlKategorije, "naziv", "id_kategorije", "Odaberite vrstu proizvoda");
                        ddlArtikli.Items.Insert(0, new ListItem("Proizvodi", "0"));
                        SetInitialRow(); 
                    }
                
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

        protected void popualteDdList(string query,DropDownList ddl,string tf,string value,string title)
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

        protected void ddlKategorije_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            popualteDdList("SELECT naziv,id_artikla FROM artikli where id_kategorije= " +ddlKategorije.SelectedValue, ddlArtikli, "naziv", "id_artikla", "Odaberite proizvod");
            ddlArtikli.AutoPostBack = true;
            
           
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {

            AddNewRowToGrid();
        }

        private void SetInitialRow()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add(new DataColumn("Redni broj", typeof(string)));
            dt.Columns.Add(new DataColumn("Artikl", typeof(string)));
            dt.Columns.Add(new DataColumn("Količina", typeof(string)));
            
            dr = dt.NewRow();
            dr["Redni broj"] = 1;
            dr["Artikl"] = string.Empty;
            dr["Količina"] = string.Empty;
           
            dt.Rows.Add(dr);
           
            ViewState["CurrentTable"] = dt;

            gwPonuda.DataSource = dt;
            gwPonuda.DataBind();
        }
        private void AddNewRowToGrid()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        //extract the TextBox values
                        
                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["Redni broj"] = i + 1;

                        dtCurrentTable.Rows[i - 1]["Artikl"] = ddlArtikli.SelectedItem.Text.ToString();
                        dtCurrentTable.Rows[i - 1]["Količina"] = twKolicna.Text.ToString();
                       

                        rowIndex++;
                    }
                    dtCurrentTable.Rows.Add(drCurrentRow);
                    ViewState["CurrentTable"] = dtCurrentTable;

                    gwPonuda.DataSource = dtCurrentTable;
                    gwPonuda.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }

           
            
        }
     

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        }
    
    }
