<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Alternativa_projekt.aspx.cs" Inherits="E_nabava.Alternativa_projekt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png" />
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css' />
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
                    <div class="container dobavljacOkvir1">
    <div>
    
        <label class="prijavaLabela">Šifra projekta</label> </div>
        <asp:TextBox class="prijavaInput" ID="txtIDProjekta" runat="server" ReadOnly="True"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Naziv projekta</label><br />
        <asp:TextBox class="prijavaInput" ID="txtNazivProjekta" runat="server"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Opis projekta</label><br />
        <asp:TextBox class="prijavaInput" ID="txtOpisProjekta" runat="server"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Projekt izdao</label><br />
        <asp:TextBox class="prijavaInput" ID="txtProjektIzdao" runat="server"></asp:TextBox>
        <br />
       <label class="prijavaLabela">Rok projekta:</label>
        
        <br />
        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar><br />
        <asp:TextBox class="prijavaInput" ID="txtRokProjekta" runat="server"></asp:TextBox>
        <br /><br />
         <label class="prijavaLabela">Stare stavke</label><br />
        <asp:GridView ID="gvStavke" runat="server" AutoGenerateColumns="False" DataKeyNames="id_stavke" DataSourceID="SqlDataSource1" OnRowCommand="gvStavke_RowCommand">
            <Columns>
                <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis" />
                <asp:BoundField DataField="kolicina" HeaderText="kolicina" SortExpression="kolicina" />
                <asp:BoundField DataField="cijena" HeaderText="cijena" SortExpression="cijena" />
                <asp:BoundField DataField="jed_mjera" HeaderText="jed_mjera" SortExpression="jed_mjera" />
                <asp:ButtonField Text="Uredi stavku" CommandName="UredjivanjeStavke" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM [stavke_projekta] WHERE ([id_projekta] = @id_projekta)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtIDProjekta" Name="id_projekta" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <label class="prijavaLabela">DODAVANJE STAVKI</label><br />
        <br />
        <label class="prijavaLabela">Opis stavke</label><br />
        <asp:TextBox class="prijavaInput" ID="txtOpisStavke" runat="server" Height="89px" TextMode="MultiLine" Width="304px"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Jedinična mjera stavke</label><br />
        <asp:TextBox class="prijavaInput" ID="txtJedMjeraStavke" runat="server"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Jedinična cijena stavke</label><br />
        <asp:TextBox class="prijavaInput" ID="txtJedCijenaStavke" runat="server"></asp:TextBox>
        <br />
        <label class="prijavaLabela">Količina</label><br />
        <asp:TextBox class="prijavaInput" ID="txtKolicinaStavke" runat="server"></asp:TextBox>
       <br /><br />
                        <div class="poljeGumb">
            <asp:Button class="gumbPrijava" ID="btnDodajStavku" runat="server" Text="Dodaj/Uredi stavku" OnClick="btnDodajStavku_Click" />
     </div>
        <p>
            <asp:Label ID="lblGreske" runat="server" ForeColor="Red"></asp:Label><br />
        </p>
        <p>
            <asp:GridView class="prijavaInput" ID="gwProjekt" runat="server" AutoGenerateDeleteButton="True" OnRowDeleting="gwProjekti_RowDeleting">
            </asp:GridView>
        </p>
        <div class="poljeGumb">
            <asp:Button class="gumbPrijava" ID="btnKreirajAlternativu" runat="server" Text="Posalji alternativu" OnClick="Button1_Click" />
       </div>
                        </div>
             </div>
    </form>
    <div class="dobavljacFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter">@ 2015 MIV - Metalska industrija Varaždin</div>

    </div>
</body>
</html>
