<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pregled_Investicijskih_Projekata.aspx.cs" Inherits="E_nabava.Pregled_Investicijskih_Projekata" %>

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
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" >
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
    <div>
            <asp:GridView class="investicijaGrid" ID="gwInvProjekti" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id_inv_projekt" DataSourceID="SqlDataSource1" OnRowCommand="GridView1_RowCommand1">
                <Columns>
                    <asp:BoundField ItemStyle-Width="10%" DataField="id_inv_projekt" HeaderText="Šifra projekta" InsertVisible="False" ReadOnly="True" SortExpression="id_inv_projekt" />
                    <asp:BoundField ItemStyle-Width="20%" DataField="izdao" HeaderText="Izdao" SortExpression="izdao" />
                    <asp:BoundField ItemStyle-Width="20%" DataField="naziv" HeaderText="Naziv projekta" SortExpression="naziv" />
                    <asp:BoundField ItemStyle-Width="20%" DataField="projekt" HeaderText="Opis projekta" SortExpression="projekt" />
                    <asp:BoundField ItemStyle-Width="10%" DataField="rok" HeaderText="Rok isporuke" SortExpression="rok" />
                    <asp:ButtonField ItemStyle-Width="20%" HeaderText="Prikaži stavke projekta" Text="Prikaži stavke projekta" CommandName="DodavanjeArtikla" />
                </Columns>
                 <FooterStyle BackColor="#5D7B9D" Font-Bold="True"/>
                       <FooterStyle BackColor="#5D7B9D" Font-Bold="True" Height="30px" />
                        <HeaderStyle ForeColor="#93948A" Height="40px" BackColor="#EAF6F2" Font-Bold="True"
                            Font-Names="'Calibri', sans-serif" Font-Size="14px" />
                        <PagerStyle BackColor="#EAF6F2" HorizontalAlign="Center" Height="40px" />

                        <RowStyle BackColor="white" Height="40px" Font-Names="'Calibri', sans-serif" />
                        <AlternatingRowStyle BackColor="#EAF6F2" Font-Names="'Calibri', sans-serif" />

                        <EditRowStyle BackColor="#EAF6F2" />

                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView> 
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT [id_inv_projekt], [izdao], [projekt], [naziv], [rok] FROM [investicijski_projekt]"></asp:SqlDataSource>
        </div>
        <asp:TextBox ID="txtOdabraniProjekt" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtIdProjekta" runat="server"></asp:TextBox>
        <br /><br /><br />
        
        <br />
        <p>
            <asp:GridView class="investicijaGrid" ID="gvStavkeProjekta" runat="server" AutoGenerateColumns="False" DataKeyNames="id_stavke" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="id_stavke" HeaderText="id_stavke" InsertVisible="False" ReadOnly="True" SortExpression="id_stavke" />
                    <asp:BoundField DataField="opis" HeaderText="opis" SortExpression="opis" />
                    <asp:BoundField DataField="kolicina" HeaderText="kolicina" SortExpression="kolicina" />
                    <asp:BoundField DataField="jed_mjera" HeaderText="jed_mjera" SortExpression="jed_mjera" />
                    <asp:BoundField DataField="cijena" HeaderText="cijena" SortExpression="cijena" />
                </Columns>
                 <FooterStyle BackColor="#5D7B9D" Font-Bold="True"/>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" Height="30px" />
                        <HeaderStyle ForeColor="#93948A" Height="40px" BackColor="#EAF6F2" Font-Bold="True"
                            Font-Names="'Calibri', sans-serif" Font-Size="14px" />
                        <PagerStyle BackColor="#EAF6F2" HorizontalAlign="Center" Height="40px" />

                        <RowStyle BackColor="white" Height="40px" Font-Names="'Calibri', sans-serif" />
                        <AlternatingRowStyle BackColor="#EAF6F2" Font-Names="'Calibri', sans-serif" />

                        <EditRowStyle BackColor="#EAF6F2" />

                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT [id_stavke], [opis], [kolicina], [jed_mjera], [cijena] FROM [stavke_projekta] WHERE ([id_projekta] = @id_projekta)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtIdProjekta" DefaultValue="" Name="id_projekta" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <div class="poljeGumb">
            <asp:Button  class="gumb1Investicija" ID="btnPotvrdiProjekt" runat="server" Text="Potvrdi projekt" OnClick="btnPotvrdiProjekt_Click" />
      
            <asp:Button class="gumb1Investicija" ID="btnAlternativa" runat="server" Text="Posalji alternativu" OnClick="btnAlternativa_Click" />
        </div>
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
