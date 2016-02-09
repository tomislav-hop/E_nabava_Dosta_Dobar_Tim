using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_nabava
{
    public partial class ZaboravljenaLozinka : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLozinka_Click(object sender, EventArgs e)
        {
            Baza baza = new Baza();
            string lozinka = "";
            string email = "";
            if (txtKorIme.Text != null) 
            {
                lozinka = baza.DohvatiVrijednost("select lozinka from korisnici where korisnicko_ime='"+txtKorIme.Text+"'" );
                email = baza.DohvatiVrijednost("select email from korisnici where korisnicko_ime='"+txtKorIme.Text+"'" );
            }
            else if (txtEmail.Text != null) 
            {
                lozinka = baza.DohvatiVrijednost("select lozinka from korisnici where email='" + txtEmail.Text + "'");
                email = txtEmail.Text;
            }
            Response.Write("Poslana vam je lozinka na email!");

             
            Mail mail = new Mail();
            mail.saljiMail("fejk.tiskara@gmail.com", email, "Zaboravljena lozinka", "Zatražili ste slanje vaše lozinke na mail! \nVaša lozinka je: " + lozinka, null);
        }
    }
}