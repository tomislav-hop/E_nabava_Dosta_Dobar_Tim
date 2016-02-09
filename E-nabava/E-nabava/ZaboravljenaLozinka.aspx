<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZaboravljenaLozinka.aspx.cs" Inherits="E_nabava.ZaboravljenaLozinka" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Zaboravljena lozinka</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png" />
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
                    <li class="navigacijaElement" id="izbornik1" runat="server">
                        <a href="Pregled_ponuda.aspx">PREGLED PONUDA</a>
                    </li>
                    <li role="presentation" class="dropdown navigacijaElement">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">PROJEKTI <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu lista" role="menu">
                            <li>
                                <a href="Investicijski_projekti.aspx">PONUDA</a>
                                <a href="Pregled_Investicijskih_Projekata.aspx">PREGLED</a>
                            </li>
                        </ul>
                    </li>
                    <li role="presentation" class="dropdown navigacijaElement" id="izbornik" runat="server">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">CRUD <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu lista" role="menu">
                            <li runat="server" >
                                <a  href="CRUDArtikli.aspx">Artikli</a>
                                <a href="CRUDKategorije.aspx">Kategorije</a>
                                <a href="CRUDKorisnici.aspx">Korisnici</a>
                                <a href="CRUDPodkategorije.aspx">Podkategorije</a>
                                <a href="CRUDProjekti.aspx">Projekti</a>
                                <a href="CRUDTipKorisnika.aspx">Tip Korisnika</a>

                            </li>
                        </ul>
                    </li>
                    <li class="navigacijaElement">
                        <a href="Dobavljac.aspx">PREGLED ARTIKALA</a>
                    </li>
                    <li class="navigacijaElement">
                        <a href="Odjava.aspx">ODJAVA</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
    <form id="form1" runat="server">
        <div class="row">
            <div class="container prijavaOkvir1">
                <label class="prijavaLabela">Korisničko ime</label><br />
                <asp:TextBox placeholder="Unesite korisničko ime" class="prijavaInput" ID="txtKorIme" runat="server"></asp:TextBox><br /><br />
                <label class="prijavaLabela">E-mail</label><br />
                <asp:TextBox placeholder="Unesite e mail" class="prijavaInput" ID="txtEmail" runat="server"></asp:TextBox>
                    <div class="poljeGumb">
                <asp:Button class="gumbPrijava" ID="btnLozinka" runat="server" OnClick="btnLozinka_Click" Text="Pošalji lozinku" />
            </div></div>
        </div>
    </form>
    <div class="dobavljacFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter" >@ 2015 MIV - Metalska industrija Varaždin</div>
       
    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
