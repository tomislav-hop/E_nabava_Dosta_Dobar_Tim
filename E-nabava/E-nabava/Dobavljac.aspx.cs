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
using System.Globalization;


namespace E_nabava
{
    public partial class Dobavljac : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["E-nabavaConnectionString"].ConnectionString;

        string greske = "";
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


            if (!IsPostBack)
            {
                izbornik.Visible = false;
                izbornik1.Visible = false;
               
                tbArtikl.Enabled = false;
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[9] { new DataColumn("Artikl"), new DataColumn("Količina"), new DataColumn("Cijena"), new DataColumn("Rok Plaćanja"), new DataColumn("Rok isporuke"), new DataColumn("Način plaćanja"), new DataColumn("Tražena kvaliteta"), new DataColumn("Napomena"), new DataColumn("Alternativa") });
                ViewState["Ponuda"] = dt;
                this.BindGrid();
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



        protected void Button1_Click1(object sender, EventArgs e)
        {
            if (provjeraUnosa())
            {
                lblGreske.Text = "";
                DataTable dt = (DataTable)ViewState["Ponuda"];
                dt.Rows.Add(tbArtikl.Text, tbKolicina.Text, tbCijena.Text, tbRokPlacanja.Text, tbRokIsporuke.Text, DropDownList1.SelectedValue, DropDownList2.SelectedValue, tbNapomena.Text, tbAlternativa.Text);
                ViewState["Ponuda"] = dt;
                this.BindGrid();
                tbArtikl.Text = "";
                tbKolicina.Text = "";
                tbCijena.Text = "";
                tbRokPlacanja.Text = "";
                tbRokIsporuke.Text = "";
                tbNapomena.Text = "";
                tbAlternativa.Text = "";
                DropDownList1.SelectedIndex = 0;
                DropDownList2.SelectedIndex = 0;

            }
            else 
            {
                lblGreske.Text = greske;
            }
        }

        protected bool provjeraUnosa()
        {
            bool sveOk = true;
            double num;
            if (tbArtikl.Text == "" || tbKolicina.Text == "" || tbRokPlacanja.Text == "" || tbRokIsporuke.Text == "")
            {
                sveOk = false;
                greske += "<br/>Niste ispunili sve potrebno!";
            }

            if (!double.TryParse(tbKolicina.Text, out num))
            {
                tbKolicina.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u količinu";
                sveOk = false;
            }
            if (!double.TryParse(tbCijena.Text, out num))
            {
                tbCijena.Text = "Niste upisali broj";
                greske += "<br/>Niste unjeli broj u cijenu";
                sveOk = false;
            }

            string format = "dd.MM.yyyy";
            DateTime dateTime;
            if (DateTime.TryParseExact(tbRokIsporuke.Text, format, CultureInfo.InvariantCulture,
                DateTimeStyles.None, out dateTime))
            {
            }
            else
            {
                sveOk = false;
                tbRokIsporuke.Text = "Datum nije ispravan. Potreban format je: dd.MM.yyyy";
                greske += "<br/>Rok isporuke nije ispravan. Potreban format je: dd.MM.yyyy";
            }

            if (DateTime.TryParseExact(tbRokPlacanja.Text, format, CultureInfo.InvariantCulture,
                DateTimeStyles.None, out dateTime))
            {
            }
            else
            {
                sveOk = false;
                tbRokPlacanja.Text = "Datum nije ispravan. Potreban format je: dd.MM.yyyy";
                greske += "<br/>Rok plaćanja nije ispravan. Potreban format je: dd.MM.yyyy";
            }


            if (DropDownList1.SelectedIndex == 0)
            {
                sveOk = false;
                greske += "<br/>Niste odabrali ispravnu vrijednost kao način plaćanja";
            }
            if (DropDownList2.SelectedIndex == 0)
            {
                sveOk = false;
                greske += "<br/>Niste odabrali ispravnu vrijednost kao kvalitetu";
            }
            return sveOk;
        }

        protected void BindGrid()
        {
            gwPonuda.DataSource = (DataTable)ViewState["Ponuda"];
            gwPonuda.DataBind();
        }

        protected void gwPonuda_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);
            DataTable dt = ViewState["Ponuda"] as DataTable;
            dt.Rows[index].Delete();
            ViewState["Ponuda"] = dt;
            BindGrid();
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
                gvOrders.DataSource = GetData("select artikli.opis,artikli.godisnja_kolicina,artikli.jedinica_mjere,podkategorije.naziv from artikli,podkategorije where artikli.id_artikla='" + customerId + "' and artikli.id_podkategorije=podkategorije.id_podkategorije");
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


        protected void ddlKategorije_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlKategorije.AutoPostBack = true;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Select"))
            {
                int index = Convert.ToInt32(e.CommandArgument);
                String ii = Convert.ToString(index);
                GridViewRow gvRow = GridView1.Rows[index];
                tbArtikl.Text = gvRow.Cells[3].Text;

            }
        }

        protected string kreirajPDF()
        {
            Document doc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
            //putanja je hardkodirana
            string fullPath = @"C:\Pdf\Ponuda" + Session["korIme"].ToString() + ".pdf";
            int count = 1;
            string fileNameOnly = Path.GetFileNameWithoutExtension(fullPath);
            string extension = Path.GetExtension(fullPath);
            string path = Path.GetDirectoryName(fullPath);
            string newFullPath = fullPath;

            while (File.Exists(newFullPath))
            {
                string tempFileName = string.Format("{0}({1})", fileNameOnly, count++);
                newFullPath = Path.Combine(path, tempFileName + extension);
                fullPath = newFullPath;
            }

            FontFactory.RegisterDirectories();
            Font fontBoldArial = new Font(FontFactory.GetFont("Arial", 16, Font.BOLD));

            FontFactory.RegisterDirectories();
            Font fontBoldArial12 = new Font(FontFactory.GetFont("Arial", 12, Font.BOLD));

            PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream(fullPath, FileMode.Create));
            doc.Open();

            //putanja je hardkodirana
            string imagepath = @"C:\Users\Luka\Desktop\HopSamonikBlazek\E-nabava\E-nabava\img\logo.png";
            iTextSharp.text.Image slika = iTextSharp.text.Image.GetInstance(imagepath);
            slika.Alignment = Element.ALIGN_CENTER;
            doc.Add(slika);

            Paragraph naslov = new Paragraph("Kreirana ponuda za Metalsku industriju Varazdin d.d.\n", fontBoldArial);
            naslov.Alignment = Element.ALIGN_CENTER;
            doc.Add(naslov);

            DateTime izdavanje = DateTime.Now;

            Baza baza = new Baza();
            string naziv = baza.DohvatiVrijednost("SELECT naziv FROM korisnici WHERE korisnicko_ime ='" + Session["korIme"]+"'");
            string brojTel = baza.DohvatiVrijednost("SELECT broj_telefona FROM korisnici WHERE korisnicko_ime ='" + Session["korIme"] + "'");
            string email = baza.DohvatiVrijednost("SELECT email FROM korisnici WHERE korisnicko_ime ='" + Session["korIme"] + "'");


            Paragraph gore = new Paragraph("Podaci o izdavacu: \n", fontBoldArial12);
            doc.Add(gore);

            Paragraph paragraph = new Paragraph(
                "Ponuda od " + Session["korIme"] + "\n" +
                "Izdao: " + naziv + "\n" +
                "Korisnicko ime izdavaca: " +  Session["korIme"] + "\n" + 
                "Email: " + email + "\n" + 
                "Broj telefona: " + brojTel + "\n" +
                "Datum izdavanja: " + izdavanje + "\n\n");
            doc.Add(paragraph);


            Paragraph naslovStavke = new Paragraph("Stavke ponude: \n\n", fontBoldArial);
            naslovStavke.Alignment = Element.ALIGN_CENTER;
            doc.Add(naslovStavke);

            PdfPTable table = new PdfPTable(10);

            table.AddCell(new Phrase("Red. br."));
            table.AddCell(new Phrase("Artikl"));
            table.AddCell(new Phrase("Kol"));
            table.AddCell(new Phrase("Cijena"));
            table.AddCell(new Phrase("Rok placanja"));
            table.AddCell(new Phrase("Rok isporuke"));
            table.AddCell(new Phrase("Nacin placanja"));
            table.AddCell(new Phrase("Kvaliteta"));
            table.AddCell(new Phrase("Napomena"));
            table.AddCell(new Phrase("Alt"));
            table.HeaderRows = 1;

            float[] widths = new float[] { 1f, 3f, 1f, 2f, 2f, 2f, 2f, 2f, 2f, 1f };
            table.SetWidths(widths);

            for (int i = 0; i < gwPonuda.Rows.Count; i++)
            {
                table.AddCell(new Phrase((i + 1).ToString()));

                for (int j = 1; j < 10; j++) {
                    table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[j].Text));
                }
                
                /*table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[1].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[2].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[3].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[4].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[5].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[6].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[7].Text));
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[8].Text)); 
                table.AddCell(new Phrase(gwPonuda.Rows[i].Cells[9].Text));*/

                table.WidthPercentage = 100;
            }
            doc.Add(table);
            doc.Close();
            return fullPath;
        }

        protected void btnGenerirajPDF_Click(object sender, EventArgs e)
        {
            DateTime izdavanje = DateTime.Now;
            Baza baza = new Baza();
            int idPonude = baza.izvrsiSQLinsert("INSERT INTO ponuda (kreirao, datum_kreiranja) OUTPUT INSERTED.id_ponuda VALUES('" + Session["korime"].ToString() + "', '" + izdavanje.ToString() + "')");

            for (int i = 0; i < gwPonuda.Rows.Count; i++)
            {
                string artikl = gwPonuda.Rows[i].Cells[1].Text;
                string kolicina = gwPonuda.Rows[i].Cells[2].Text;
                string cijena = gwPonuda.Rows[i].Cells[3].Text;
                string rok_placanja = gwPonuda.Rows[i].Cells[4].Text;
                string rok_isporuke = gwPonuda.Rows[i].Cells[5].Text;
                string nacin_placanja = gwPonuda.Rows[i].Cells[6].Text;
                string trazena_kvaliteta = gwPonuda.Rows[i].Cells[7].Text;
                string napomena = gwPonuda.Rows[i].Cells[8].Text;
                string alt = gwPonuda.Rows[i].Cells[9].Text;



                baza.izvrsiSQLinsert("INSERT INTO stavke_ponude (artikl, kolicina, cijena, rok_placanja, rok_isporuke, nacin_placanja, trazena_kvaliteta, napomena, alternativa, id_ponuda)OUTPUT INSERTED.id_stavke VALUES('" + artikl + "','" + kolicina + "','" + cijena + "','" + rok_placanja + "','" + rok_isporuke + "','" + nacin_placanja + "','" + trazena_kvaliteta + "','" + napomena + "','" + alt + "'," + idPonude + ")");
            }

            Mail mail = new Mail();
            mail.saljiMail("fejk.tiskara@gmail.com", "tomislav.hop@gmail.com", "Ponuda", "U privitku mozete vidjeti ponudu.", kreirajPDF());

            Response.Redirect("Pregled_ponuda.aspx");
        }

        protected void gwPonuda_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
            e.Row.Cells[8].Visible = false;
            e.Row.Cells[9].Visible = false;
        }


    }

}
    
