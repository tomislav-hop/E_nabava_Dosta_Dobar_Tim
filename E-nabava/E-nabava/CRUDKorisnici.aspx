<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUDKorisnici.aspx.cs" Inherits="E_nabava.CRUDKorisnici" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png">
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="scripts/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.blockUI.js"></script>
    <script type="text/javascript">
        function BlockUI(elementID) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () {
                $("#" + elementID).block({
                    message: '<table align = "center"><tr><td>' +
                     '<img src="images/loadingAnim.gif"/></td></tr></table>',
                    css: {},
                    overlayCSS: {
                        backgroundColor: '#000000', opacity: 0.6, border: '3px solid #63B2EB'
                    }
                });
            });
            prm.add_endRequest(function () {
                $("#" + elementID).unblock();
            });
        }
        $(document).ready(function () {

            BlockUI("dvGrid");
            $.blockUI.defaults.css = {};
        });
    </script>
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
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
        <div id="dvGrid" style="padding: 0px; width: 100%">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row gridCRUD">
                        <asp:GridView class="investicijaGrid" ID="GridView1" runat="server" Width="100%"
                            AutoGenerateColumns="false" Font-Names="'Calibri', sans-serif"
                            Font-Size="11pt" AllowPaging="true" ShowFooter="true"
                            OnPageIndexChanging="OnPaging" OnRowEditing="EditKorisnici"
                            OnRowUpdating="UpdateKorisnici" OnRowCancelingEdit="CancelEdit"
                            PageSize="10" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="8%"  HeaderText="Šifra">
                                    <ItemTemplate>
                                        <asp:Label Width="100%" ID="lblIdKorisnika" runat="server"
                                            Text='<%# Eval("id_korisnici")%>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Ime">
                                    <ItemTemplate>
                                        <asp:Label Width="100%" ID="lblNaziv" runat="server"
                                            Text='<%# Eval("naziv")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtNaziv" runat="server"
                                            Text='<%# Eval("naziv")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtNaziv1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Adresa">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblAdresa" runat="server"
                                            Text='<%# Eval("[adresa]")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtAdresa" runat="server"
                                            Text='<%# Eval("[adresa]")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox Width="100%" ID="txtAdresa1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblEmail" runat="server"
                                            Text='<%# Eval("email")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtEmail" runat="server"
                                            Text='<%# Eval("email")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtEmail1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Broj telefona">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblBrojTelefona" runat="server"
                                            Text='<%# Eval("broj_telefona")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox   Width="100%" ID="txtBrojTelefona" runat="server"
                                            Text='<%# Eval("broj_telefona")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtBrojTelefona1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Korisničko ime">
                                    <ItemTemplate>
                                        <asp:Label Width="100%" ID="lblKorisnickoIme" runat="server"
                                            Text='<%# Eval("korisnicko_ime")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtKorisnickoIme" runat="server"
                                            Text='<%# Eval("korisnicko_ime")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtKorisnickoIme1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Lozinka">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblLozinka" runat="server"
                                            Text='<%# Eval("lozinka")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtLozinka" runat="server"
                                            Text='<%# Eval("lozinka")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtLozinka1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Tip korisnika" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label Width="100%" ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label  Width="100%" ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>' Visible="false"></asp:Label>
                                        <asp:DropDownList ID="ddlTip1" runat="server">
                                        </asp:DropDownList>


                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("naziv1")%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlTip" runat="server" DataTextField="naziv_tipa" DataValueField="id_tip" DataSourceID="SqlDataSource1">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:E-NabavaConnectionString %>' SelectCommand="SELECT [id_tip], [naziv_tipa] FROM [tip_korisnika]"></asp:SqlDataSource>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Aktiviran">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblAktiviran" runat="server"
                                            Text='<%# Eval("aktiviran")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAktiviran" runat="server"
                                            Text='<%# Eval("aktiviran")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtAktiviran1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="8%" HeaderText="Aktivacijski kod">
                                    <ItemTemplate>
                                        <asp:Label  Width="100%" ID="lblAktivacijskiKod" runat="server"
                                            Text='<%# Eval("aktivacijski_kod")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  Width="100%" ID="txtAktivacijskiKod" runat="server"
                                            Text='<%# Eval("aktivacijski_kod")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  Width="100%" ID="txtAktivacijskiKod1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>



                                <asp:TemplateField ItemStyle-Width="8%">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkRemove" runat="server"
                                            CommandArgument='<%# Eval("id_korisnici")%>'
                                            OnClientClick="return confirm('Do you want to delete?')"
                                            Text="Obriši" OnClick="DeleteKorisnik"></asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button ID="btnAdd" runat="server" Text="Dodaj"
                                            OnClick="dodajNovogKorisnika" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ItemStyle-Width="8%" ShowEditButton="True"  EditText="Uredi"/>
                            </Columns>
                            <FooterStyle Height="40px" BackColor="#EAF6F2" Font-Bold="True" />
                            <HeaderStyle Height="40px" BackColor="#EAF6F2" Font-Bold="True" Font-Names="'Calibri', sans-serif" Font-Size="14px" />
                            <PagerStyle Height="40px" BackColor="#EAF6F2" HorizontalAlign="Center" />

                            <RowStyle BackColor="white" Height="40px" ForeColor="#93948A" Font-Names="'Calibri', sans-serif" />
                            <AlternatingRowStyle BackColor="#EAF6F2" ForeColor="#93948A" Font-Names="'Calibri', sans-serif" />

                            <EditRowStyle BackColor="#EAF6F2" />

                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
    <div class="dobavljacFooter">
        <hr class="crtaFooter" />
        <div class="tekstFooter">@ 2015 MIV - Metalska industrija Varaždin</div>

    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

