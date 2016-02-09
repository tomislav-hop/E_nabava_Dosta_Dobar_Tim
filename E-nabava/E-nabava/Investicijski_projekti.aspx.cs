using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Investicijski_projekti : System.Web.UI.Page
    {
        Baza baza = new Baza();
        string greske = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["sesija"].ToString().Equals("2"))
            {
                Response.Redirect("Login.aspx");
            }
            else if (Session["sesija"].ToString().Equals("1"))
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[4] { new DataColumn("Opis stavke"), new DataColumn("Jedinična mjera"), new DataColumn("Količina"), new DataColumn("Jedinična cijena") });
                ViewState["Projekti"] = dt;
                this.BindGrid();
            }
        }

        protected void BindGrid()
        {
            gwProjekt.DataSource = (DataTable)ViewState["Projekti"];
            gwProjekt.DataBind();
        }

        protected void gwProjekti_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);
            DataTable dt = ViewState["Projekti"] as DataTable;
            dt.Rows[index].Delete();
            ViewState["Projekti"] = dt;
            BindGrid();
        }

        protected void btnDodajProjekt_Click(object sender, EventArgs e)
        {
            greske = "";
            if (provjeraPodataka())
            {
                lblGreska.Text = "";
                DataTable dt = (DataTable)ViewState["Projekti"];
                dt.Rows.Add(txtOpisStavke.Text, txtJedMjera.Text, txtKolicina.Text, txtJedCijena.Text);
                txtOpisStavke.Text = "";
                txtJedMjera.Text = "";
                txtKolicina.Text = "";
                txtJedCijena.Text = "";
                ViewState["Projekti"] = dt;
                this.BindGrid();
            }
            else 
            {
                lblGreska.Text = greske;
            }
        }

        protected void btnKreirajProjekt_Click(object sender, EventArgs e)
        {
            greske = "";
            if (provjeraPodatakaKreiraj())
            {
                lblGreska.Text = "";
                int idProjekta = baza.izvrsiSQLinsert("INSERT INTO investicijski_projekt (izdao, projekt, naziv, rok, aktiviran, potvrda) OUTPUT INSERTED.id_inv_projekt VALUES('" + txtProjektIzdaje.Text + "','" + txtOpisProjekta.Text + "','" + txtNazivProjekta.Text + "','" + txtRok.Text + "',0,0)");
                for (int i = 0; i < gwProjekt.Rows.Count; i++)
                {
                    baza.izvrsiSQLinsert("INSERT INTO stavke_projekta (opis, kolicina, cijena, jed_mjera, id_projekta) OUTPUT INSERTED.id_stavke VALUES ('" + gwProjekt.Rows[i].Cells[1].Text + "', '" + gwProjekt.Rows[i].Cells[3].Text + "', '" + gwProjekt.Rows[i].Cells[4].Text + "', '" + gwProjekt.Rows[i].Cells[2].Text + "', " + idProjekta + ")");
                }
                Response.Redirect("Pregled_Investicijskih_Projekata.aspx");
            }
            else 
            {
                lblGreska.Text = greske;
            }
    

    
        }

        protected bool provjeraPodataka()
        {
            bool sveOK = true;
            double num;
            if (txtOpisStavke.Text == "" || txtJedMjera.Text == "")
            {
                greske += "<br/>Niste ispunili sve potrebno!";
                sveOK = false;
            }
            if (!double.TryParse(txtJedCijena.Text, out num)) 
            {
                txtJedCijena.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u cijenu stavke";
                sveOK = false;
            }
            if (!double.TryParse(txtKolicina.Text, out num))
            {
                txtKolicina.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u kolicinu";
                sveOK = false;
            }
            return sveOK;
        }

        protected bool provjeraPodatakaKreiraj() 
        {
            bool sveOK = true;
            if (txtNazivProjekta.Text == "" || txtOpisProjekta.Text == "" || txtProjektIzdaje.Text == "" || txtRok.Text == "") 
            {
                greske += "<br/>Niste ispunili sve potrebno!";
                sveOK = false;
            }
            if (gwProjekt.Rows.Count < 1)
            {
                greske += "<br/>Projekt ne sadrži stavke!";
                sveOK = false;
            }
            return sveOK;
        }

        protected void cRok_SelectionChanged(object sender, EventArgs e)
        {
            txtRok.Text = cRok.SelectedDate.ToString();
        }
    }
}