<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_nabava.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png"/>
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
    <div class="container prijavaOkvir">
       
    <form id="form1" runat="server">
             <label class="prijavaLabela">Korisničko ime</label>
             <asp:TextBox placeholder="Upišite korisničko ime" class="prijavaInput" ID="tbUname" runat="server"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbUname" ErrorMessage="Korisnicko ime je obavezno"></asp:RequiredFieldValidator>
             <br />
             <label class="prijavaLabela">Lozinka</label>
             <asp:TextBox placeholder="Upišite lozinku" class="prijavaInput" ID="tbPass" runat="server" TextMode="Password"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbPass" ErrorMessage="Lozinka je obavezna"></asp:RequiredFieldValidator>
               <br />
        <div class="poljeGumb">
             <asp:Button class="gumbPrijava" ID="Button1" runat="server" OnClick="Button1_Click" Text="Prijavi se"/><br /><br />
             <asp:HyperLink class="gumbPrijava" ID="HyperLink1" runat="server" NavigateUrl="~/ZaboravljenaLozinka.aspx" Style="text-align: center">Zaboravljena lozinka?</asp:HyperLink>
        </div>
    </form>
    </div>
    </div>
    
    <div class="prijavaFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter" >@ 2015 MIV - Metalska industrija Varaždin</div>
       
    </div>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
