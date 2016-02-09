using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace E_nabava
{
    public class Mail
    {
        public void saljiMail(string od, string za, string naslov, string sadrzaj, string dodatak)
        {
            MailMessage mail = new MailMessage(od, za, naslov, sadrzaj);
            if (dodatak != null)
            {
                mail.Attachments.Add(new Attachment(dodatak));
            }
            SmtpClient client = new SmtpClient("smtp.gmail.com");
            client.Port = 587;
            client.Credentials = new System.Net.NetworkCredential("fejk.tiskara@gmail.com", "NOVAlozinka");
            client.EnableSsl = true;
            client.Send(mail);
        }

    }
}