
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Investicijski_projekti.aspx.cs" Inherits="E_nabava.Investicijski_projekti" %>

<!DOCTYPE html>

<html id="scrol1" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png">
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
</head>
<body id="scroll">
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
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>           
                <div class="row">
    <div class="container investicijaOkvir">     
                    <label class="investicijaLabela">OPĆI PODACI O PROJEKTU</label>
                    <br />
                    <label class="investicijaLabela"> Naziv projekta</label>
                    <asp:TextBox placeholder="Unesite naziv projekta" class="investicijaInput" ID="txtNazivProjekta" runat="server"></asp:TextBox>
                    <br />

                    <label class="investicijaLabela">Opis projekta</label>
                    <asp:TextBox placeholder="Unesite opis projekta" class="investicijaInput" ID="txtOpisProjekta" runat="server"></asp:TextBox>
                    <br />

                    <label class="investicijaLabela">Projekt izdaje</label>
                    <asp:TextBox placeholder="Unesite naziv izdavača projekta" class="investicijaInput" ID="txtProjektIzdaje" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    <label class="investicijaLabela">Rok izrade projekta</label><br />
                    <asp:Calendar ForeColor="#93948A" TodayDayStyle-BackColor="#00A88D" DayStyle-BackColor="#EAF6F2" TitleStyle-BorderWidth="1px" TitleStyle-BackColor="white" NextPrevStyle-BackColor="white" NextPrevStyle-Height="40px" NextPrevStyle-ForeColor="black" DayHeaderStyle-BackColor="white" DayNameFormat  ="Short" WeekendDayStyle-Font-Bold="true" DayHeaderStyle-Height="40px" Width="50%" Height="200px" ID="cRok" runat="server" OnSelectionChanged="cRok_SelectionChanged"></asp:Calendar>
                    <asp:TextBox class="investicijaLabela" ID="txtRok" runat="server"></asp:TextBox>
                    <br /><br />
                    <asp:Label ID="lblGreska" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                                       
                    <label class="investicijaLabela">DODAVANJA STAVKI PROJEKTA</label>
                    <br />
                   
                    <label class="investicijaLabela">Opis stavke:</label>
                    <asp:TextBox placeholder="Unesite opis stavke" class="investicijaInput" ID="txtOpisStavke" runat="server" Height="150px" TextMode="MultiLine"></asp:TextBox>
                    <br />

                    <label class="investicijaLabela">Jedinična mjera stavke</label>
                    <asp:TextBox placeholder="Unesite jediničnu mjeru stavke" class="investicijaInput" ID="txtJedMjera" runat="server"></asp:TextBox>
                    <br />

                    <label class="investicijaLabela">Jedinična cijena</label>
                    <asp:TextBox placeholder="Unesite jedinučnu cijenu stavke" class="investicijaInput" ID="txtJedCijena" runat="server"></asp:TextBox>
                    <br />

                    <label class="investicijaLabela">Količina</label>
                    <asp:TextBox placeholder="Unesite količinu" class="investicijaInput" ID="txtKolicina" runat="server"></asp:TextBox>
                    <br />
        <div class="poljeGumb">
                    <asp:Button class="gumb1Investicija" ID="btnDodajProjekt" runat="server" OnClick="btnDodajProjekt_Click" Text="Dodaj stavku" />
                    <asp:Button class="gumb2Investicija" ID="btnKreirajProjekt" runat="server" OnClick="btnKreirajProjekt_Click" Text="Kreiraj projekt" />
                </div></div></div>
        <div class ="row grid">


                <asp:GridView HeaderStyle-HorizontalAlign="Center" class="investicijaGrid" ID="gwProjekt" runat="server" CellPadding="10" GridLines="Both"  AutoGenerateDeleteButton="True" OnRowDeleting="gwProjekti_RowDeleting">
                        
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True"/>
                        <HeaderStyle Height="40px" BackColor="#EAF6F2" Font-Bold="True"  Font-Names="'Calibri', sans-serif" Font-Size="14px"/>
                        <PagerStyle BackColor="yellow" HorizontalAlign="Center" />
                        
                        <RowStyle BackColor="white" Height="40px" ForeColor="#93948A" Font-Names="'Calibri', sans-serif"/>
                        <AlternatingRowStyle BackColor="#EAF6F2" ForeColor="#93948A" Font-Names="'Calibri', sans-serif"/>

                        <EditRowStyle BackColor="#EAF6F2" />
                        
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>

       
    </form>
    
    <div class="investicijaFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter" >@ 2015 MIV - Metalska industrija Varaždin</div>
       
    </div>
     <script type="text/javascript">

         $("#addClass").click(function () {

             alert("Bok");

         });

        </script>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>