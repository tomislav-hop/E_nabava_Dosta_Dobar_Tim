<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="E_nabava.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png">
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    
</head>
<body>
    <nav class="navbar navbar-inverse navbar-fixed-top navigacija" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
                    <img class="navigacijaLogo" src="img/logo.png" alt="" />
                </a>
            </div>
            <div class=" row navigacijaPodaci">
                <div class="navigacijaTekst">
                    Fabijanska 33, 42 000 Varaždin, Croatia<br />
                    tel. : + 385 42 404 100; Gospodarska bb<br />
                    tel. : + 385 42 290 100; Fabijanska 33<br />
                    e- mail: miv@miv.hr; sales@miv.hr; prodaja@miv.hr<br />
                </div>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navigacijaLista">
                    <li class="navigacijaElement">
                        <a href="PocetnaStranica.aspx">POČETNA</a>
                    </li>
                    <li class="navigacijaElement">
                        <a href="Login.aspx">PRIJAVA</a>
                    </li>
                    <li class="navigacijaElement">
                        <a href="Registration.aspx">PREGISTRACIJA</a>
                    </li>
                   
                  
                   
                    
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <div class="row">
    <div class="container registracijaOkvir">
    <form id="form1" runat="server">
        
                <label class="registracijaLabela">Naziv dobavljača</label><br />
                <asp:TextBox placeholder="Unesite naziv dobavljača" class="registracijaInput" ID="tbNaziv" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbNaziv" ErrorMessage="Morate upisati naziv"></asp:RequiredFieldValidator>
                <br />

                <label class="registracijaLabela">Adresa</label><br />
                <asp:TextBox placeholder="Unesite adresu" class="registracijaInput" ID="tbAdresa" runat="server"></asp:TextBox>             
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbAdresa" ErrorMessage="Morate upisati adresu"></asp:RequiredFieldValidator>
                <br />
                 
                <label class="registracijaLabela">Broj telefona</label><br />
                <asp:TextBox placeholder="Unesite broj telefona" class="registracijaInput" ID="tbBrojTelefona" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbBrojTelefona" ErrorMessage="Morate upisati broj telefona"></asp:RequiredFieldValidator>
                <br />

                <label class="registracijaLabela">E-mail</label><br />
                <asp:TextBox placeholder="Unesite e-mail" class="registracijaInput" ID="tbEmail" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbEmail" ErrorMessage="Neispravan Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                <br />

                <label class="registracijaLabela">Korisničko ime</label><br />
                <asp:TextBox placeholder="Unesite korisničko ime" class="registracijaInput" ID="tbKorisnickoIme" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbKorisnickoIme" ErrorMessage="Morate upisati korisnicko ime"></asp:RequiredFieldValidator>
                <br />

                <label class="registracijaLabela">Lozinka</label><br />
                <asp:TextBox placeholder="Unesite lozinku" class="registracijaInput" ID="tbLozinka" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbLozinka" ErrorMessage="Morate upisati lozinku"></asp:RequiredFieldValidator>
                <br />

                <label class="registracijaLabela">Potvrda lozinke</label><br />
                <asp:TextBox placeholder="Unesite potvrdu lozinke" class="registracijaInput" ID="tbPotvrdaLozinke" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbPotvrdaLozinke" ErrorMessage="Morate upisati potvrdu lozinke"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbLozinka" ControlToValidate="tbPotvrdaLozinke" ErrorMessage="Lozinka i potvrda lozinke nisu iste"></asp:CompareValidator>
                <br />
        <div class="poljeGumb">
                <asp:Button class="gumbRegistracija" ID="Button1" runat="server" OnClick="Button1_Click" Text="Registriraj se" />
                </div>
    </form>
    </div></div>
    <div class="registracijaFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter" >@ 2015 MIV - Metalska industrija Varaždin</div>
       
    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
