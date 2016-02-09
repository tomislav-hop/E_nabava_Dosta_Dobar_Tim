<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pregled_ponuda.aspx.cs" Inherits="E_nabava.Pregled_ponuda" %>

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
    <div class ="row pregledPonudaOkvir">
       
        <asp:GridView class="investicijaGrid" ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id_ponuda" DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:BoundField HeaderStyle-ForeColor="#93948A" DataField="id_ponuda" HeaderText="Šifra ponude" InsertVisible="False"
                     ReadOnly="True" SortExpression="id_ponuda" ItemStyle-BorderStyle="Double" HeaderStyle-BorderStyle="Double"
                     ItemStyle-BorderWidth="3px"
                     HeaderStyle-BorderWidth="3px" HeaderStyle-Height="40px" ItemStyle-Height="40px" 
                     ItemStyle-Width="19%" />
                <asp:BoundField HeaderStyle-ForeColor="#93948A" DataField="kreirao" HeaderText="Kreirao" SortExpression="kreirao" ItemStyle-BorderStyle="Double" HeaderStyle-BorderStyle="Double" ItemStyle-BorderWidth="3px"
                                                HeaderStyle-BorderWidth="3px" HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%" />
                <asp:BoundField HeaderStyle-ForeColor="#93948A" DataField="datum_kreiranja" HeaderText="Datum kreiranja" SortExpression="datum_kreiranja" ItemStyle-BorderStyle="Double" HeaderStyle-BorderStyle="Double" ItemStyle-BorderWidth="3px"
                                                HeaderStyle-BorderWidth="3px" HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%"  />
                <asp:ButtonField ItemStyle-ForeColor="#93948A" HeaderStyle-ForeColor="#93948A" Text="Prikaži stavke ponude" HeaderText="Pregledaj detalje ponude" CommandName="DodavanjeArtikla" ItemStyle-BorderStyle="Double" HeaderStyle-BorderStyle="Double" ItemStyle-BorderWidth="3px"
                                                HeaderStyle-BorderWidth="3px" HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%"  />
            </Columns>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True"/>
                        <HeaderStyle Height="40px" BackColor="#EAF6F2" Font-Bold="True"  Font-Names="'Oswald', sans-serif" Font-Size="12px"/>
                        <PagerStyle BackColor="yellow" HorizontalAlign="Center" />
                        
                        <RowStyle BackColor="white" Height="40px"/>
                        <AlternatingRowStyle BackColor="#EAF6F2" />

                        <EditRowStyle BackColor="#EAF6F2" />
                        
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM [ponuda]"></asp:SqlDataSource>
       
        <asp:TextBox class="detalji" ID="txtIDPonude" runat="server" ReadOnly="True"></asp:TextBox>
        <br /><br /><br /><br />
        <asp:GridView class="investicijaGrid" ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id_stavke" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="id_stavke" HeaderText="Šifra stavke" InsertVisible="False" ReadOnly="True" SortExpression="id_stavke" />
                <asp:BoundField DataField="artikl" HeaderText="Naziv artikla" SortExpression="artikl" />
                <asp:BoundField DataField="kolicina" HeaderText="Količina" SortExpression="kolicina" />
                <asp:BoundField DataField="cijena" HeaderText="Cijena" SortExpression="cijena" />
                <asp:BoundField DataField="rok_placanja" HeaderText="Rok plačanja" SortExpression="rok_placanja" />
                <asp:BoundField DataField="rok_isporuke" HeaderText="Rok isporke" SortExpression="rok_isporuke" />
                <asp:BoundField DataField="nacin_placanja" HeaderText="Način plačanja" SortExpression="nacin_placanja" />
                <asp:BoundField DataField="trazena_kvaliteta" HeaderText="Tražena kvaliteta" SortExpression="trazena_kvaliteta" />
                <asp:BoundField DataField="napomena" HeaderText="Napomena" SortExpression="napomena" />
                <asp:BoundField DataField="alternativa" HeaderText="Alternativa" SortExpression="alternativa" />
            </Columns>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True"/>
                        <HeaderStyle Height="40px" BackColor="#EAF6F2" Font-Bold="True"  Font-Names="'Oswald', sans-serif" Font-Size="12px"/>
                        <PagerStyle BackColor="yellow" HorizontalAlign="Center" />
                        
                        <RowStyle BackColor="white" Height="40px"/>
                        <AlternatingRowStyle BackColor="#EAF6F2" />

                        <EditRowStyle BackColor="#EAF6F2" />
                        
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM [stavke_ponude] WHERE ([id_ponuda] = @id_ponuda)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtIDPonude" Name="id_ponuda" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        </div>
    </form>
    <div class="pregledPonudaFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter" >@ 2015 MIV - Metalska industrija Varaždin</div>
       
    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
