using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class Alternativa_projekt : System.Web.UI.Page
    {
        Baza baza = new Baza();
        string greske;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sesija"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["sesija"].ToString().Equals("2"))
            {

            }
            else if (Session["sesija"].ToString().Equals("1"))
            {

            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            if (Request.QueryString["idProjekta"] != null)
            {
                txtIDProjekta.Text = Request.QueryString["idProjekta"];
            }
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[4] { new DataColumn("Opis stavke"), new DataColumn("Jedinična mjera"), new DataColumn("Količina"), new DataColumn("Jedinična cijena") });
                ViewState["Projekti"] = dt;
                DohvatiPodatke();
                this.BindGrid();
            }
        }

        protected void DohvatiPodatke()
        {
            txtNazivProjekta.Text = baza.DohvatiVrijednost("SELECT naziv FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text) + " alternativa";
            txtOpisProjekta.Text = baza.DohvatiVrijednost("SELECT projekt FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
            txtProjektIzdao.Text = baza.DohvatiVrijednost("SELECT izdao FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
            txtRokProjekta.Text = baza.DohvatiVrijednost("SELECT rok FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
        }

        protected void gvStavke_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = int.Parse(e.CommandArgument.ToString());
            txtOpisStavke.Text = gvStavke.Rows[index].Cells[0].Text;
            txtJedMjeraStavke.Text = gvStavke.Rows[index].Cells[3].Text;
            txtJedCijenaStavke.Text = gvStavke.Rows[index].Cells[2].Text;
            txtKolicinaStavke.Text = gvStavke.Rows[index].Cells[1].Text;
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

        protected void btnDodajStavku_Click(object sender, EventArgs e)
        {
            greske = "";
            if (provjeraPodataka())
            {
                lblGreske.Text = "";
                DataTable dt = (DataTable)ViewState["Projekti"];
                dt.Rows.Add(txtOpisStavke.Text, txtJedMjeraStavke.Text, txtKolicinaStavke.Text, txtJedCijenaStavke.Text);
                txtOpisStavke.Text = "";
                txtJedMjeraStavke.Text = "";
                txtKolicinaStavke.Text = "";
                txtJedCijenaStavke.Text = "";
                ViewState["Projekti"] = dt;
                this.BindGrid();
            }
            else 
            {
                lblGreske.Text = greske;
            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            txtRokProjekta.Text = Calendar1.SelectedDate.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            greske = "";
            if (provjeraPodatakaKreiraj())
            {
                lblGreske.Text = "";
                int idProjekta = baza.izvrsiSQLinsert("INSERT INTO investicijski_projekt (izdao, projekt, naziv, rok, aktiviran, potvrda) OUTPUT INSERTED.id_inv_projekt VALUES('" + txtProjektIzdao.Text + "','" + txtOpisProjekta.Text + "','" + txtNazivProjekta.Text + "','" + txtRokProjekta.Text + "',0,0)");
                for (int i = 0; i < gwProjekt.Rows.Count; i++)
                {
                    baza.izvrsiSQLinsert("INSERT INTO stavke_projekta (opis, kolicina, cijena, jed_mjera, id_projekta) OUTPUT INSERTED.id_stavke VALUES ('" + gwProjekt.Rows[i].Cells[1].Text + "', '" + gwProjekt.Rows[i].Cells[3].Text + "', '" + gwProjekt.Rows[i].Cells[4].Text + "', '" + gwProjekt.Rows[i].Cells[2].Text + "', " + idProjekta + ")");
                }
                string putanja = kreirajPDF(idProjekta);

                string emailZa = baza.DohvatiVrijednost("SELECT email FROM korisnici WHERE korisnicko_ime='" + Session["korIme"] + "'");
                Mail mail = new Mail();
                mail.saljiMail("fejk.tiskara@gmail.com", "tomislav.hop@gmail.com", "Alternativa za projekt", "Poštovani u dodatku se nalazi alternativa projekta", putanja);

                Response.Redirect("Pregled_Investicijskih_Projekata.aspx");
            }
            else 
            {
                lblGreske.Text = greske;
            }
        }

        protected bool provjeraPodataka()
        {
            bool sveOK = true;
            double num;
            if (txtOpisStavke.Text == "" || txtJedMjeraStavke.Text == "")
            {
                greske += "<br/>Niste ispunili sve potrebno!";
                sveOK = false;
            }
            if (!double.TryParse(txtJedCijenaStavke.Text, out num))
            {
                txtJedCijenaStavke.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u cijenu stavke";
                sveOK = false;
            }
            if (!double.TryParse(txtKolicinaStavke.Text, out num))
            {
                txtKolicinaStavke.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u kolicinu";
                sveOK = false;
            }
            return sveOK;
        }

        protected bool provjeraPodatakaKreiraj()
        {
            bool sveOK = true;
            if (txtNazivProjekta.Text == "" || txtOpisProjekta.Text == "" || txtProjektIzdao.Text == "" || txtRokProjekta.Text == "")
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

        protected string kreirajPDF(int idProjekta)
        {
            Document doc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
            //putanja je hardkodirana
            PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream(@"C:\Pdf\Investicijski_projekt_ALT" + idProjekta + ".pdf", FileMode.Create));
            doc.Open();

            FontFactory.RegisterDirectories();
            Font fontBoldArial = new Font(FontFactory.GetFont("Arial", 16, Font.BOLD));

            FontFactory.RegisterDirectories();
            Font fontBoldArial12 = new Font(FontFactory.GetFont("Arial", 12, Font.BOLD));

            //putanja je hardkodirana
            string imagepath = @"C:\Users\Luka\Desktop\HopSamonikBlazek\E-nabava\E-nabava\img\logo.png";
            iTextSharp.text.Image slika = iTextSharp.text.Image.GetInstance(imagepath);
            slika.Alignment = Element.ALIGN_CENTER;
            doc.Add(slika);

            Paragraph naslov = new Paragraph("Alternativa investicijskog projekta za Metalsku industriju Varazdin d.d.\n\n", fontBoldArial);
            naslov.Alignment = Element.ALIGN_CENTER;
            doc.Add(naslov);

            DateTime izdavanje = DateTime.Now;

            Paragraph gore = new Paragraph("Podaci o izmjenjenom investicijskom projektu: \n\n", fontBoldArial12);

            Paragraph paragraph = new Paragraph(
                "Naziv projekta: " + txtNazivProjekta.Text + "\n" +
                "Opis projekta: " + txtOpisProjekta.Text + "\n" +
                "Izdao: " + Session["korIme"] + "\n" +
                "Datum izdavanja: " + izdavanje + "\n" + 
                "Rok: " + txtRokProjekta.Text + "\n\n");

            string stariNaziv = baza.DohvatiVrijednost("SELECT naziv FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
            string stariOpis = baza.DohvatiVrijednost("SELECT projekt FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
            string stariIzdao = baza.DohvatiVrijednost("SELECT izdao FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);
            string stariRok = baza.DohvatiVrijednost("SELECT rok FROM investicijski_projekt WHERE id_inv_projekt=" + txtIDProjekta.Text);

            Paragraph gore2 = new Paragraph("Podaci o starom investicijskom projektu: \n\n", fontBoldArial12);

            Paragraph paragraph2 = new Paragraph(
                "Investicijski_projekt" + txtIDProjekta.Text + "\n" +
                "Naziv projekta: " + stariNaziv + "\n" +
                "Opis projekta: " + stariOpis + "\n" +
                "Izdao: " + stariIzdao + "\n" +
                "Rok: " + stariRok + "\n\n");

            PdfPCell cell = new PdfPCell();
            cell.AddElement(gore);
            cell.AddElement(paragraph);
            cell.Padding = 0;
            cell.Border = PdfPCell.NO_BORDER;

            PdfPCell cellPRazna = new PdfPCell(new Phrase(""));
            cellPRazna.Padding = 0;
            cellPRazna.Border = PdfPCell.NO_BORDER;


            PdfPCell cell2 = new PdfPCell();
            cell2.AddElement(gore2);
            cell2.AddElement(paragraph2);
            cell2.Padding = 0;
            cell2.Border = PdfPCell.NO_BORDER;

            float[] sirine = new float[] {3f, 1f, 3f};
            PdfPTable opisi = new PdfPTable(3);
            opisi.SetWidths(sirine);
            opisi.WidthPercentage = 100;
            opisi.AddCell(cell);
            opisi.AddCell(cellPRazna);
            opisi.AddCell(cell2);
            doc.Add(opisi);


            Paragraph naslovStavke = new Paragraph("Stavke projekta: \n\n", fontBoldArial);
            naslovStavke.Alignment = Element.ALIGN_CENTER;
            doc.Add(naslovStavke);

            PdfPTable table = new PdfPTable(6);
            float[] widths = new float[] { 1f, 6f, 2f, 2f, 2f, 2f };
            table.SetWidths(widths);
            table.AddCell(new Phrase("Red. br."));
            table.AddCell(new Phrase("Opis stavke"));
            table.AddCell(new Phrase("Jed. mj."));
            table.AddCell(new Phrase("Kolicina"));
            table.AddCell(new Phrase("Jed. cijena(kn)"));
            table.AddCell(new Phrase("Iznos (kn)"));
            table.HeaderRows = 1;
            table.WidthPercentage = 100;
            double ukupno = 0;
            for (int i = 0; i < gwProjekt.Rows.Count; i++)
            {
                table.AddCell(new Phrase((i + 1).ToString()));
                table.AddCell(new Phrase(gwProjekt.Rows[i].Cells[1].Text));
                table.AddCell(new Phrase(gwProjekt.Rows[i].Cells[2].Text));
                table.AddCell(new Phrase(gwProjekt.Rows[i].Cells[3].Text));
                table.AddCell(new Phrase(gwProjekt.Rows[i].Cells[4].Text));
                float iznos = float.Parse(gwProjekt.Rows[i].Cells[3].Text) * float.Parse(gwProjekt.Rows[i].Cells[4].Text);
                table.AddCell(new Phrase(iznos.ToString()));
                ukupno += iznos;
            }

            doc.Add(table);

            double pdv = ukupno * 0.25;
            double sveukupno = ukupno + pdv;
            Paragraph paragraph1 = new Paragraph(
                "\nUkupno: " + ukupno + " kn\n" +
                "PDV 25%: " + pdv + " kn\n" +
                "Sveukupno: " + sveukupno + " kn\n");
            doc.Add(paragraph1);
            doc.Close();

            return @"C:\Pdf\Investicijski_projekt_ALT" + idProjekta + ".pdf";
        }
    }
}