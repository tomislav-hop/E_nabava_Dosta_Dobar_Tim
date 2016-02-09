<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUDProjekti.aspx.cs" Inherits="E_nabava.CRUDProjekti" %>

<!DOCTYPE html>

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
                            OnPageIndexChanging="OnPaging" OnRowEditing="EditP"
                            OnRowUpdating="UpdateP" OnRowCancelingEdit="CancelEdit"
                            PageSize="10" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound">
                            <Columns>
                                <asp:TemplateField ItemStyle-Width="6%" HeaderText="Šifra">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblIdProjekt" runat="server"
                                            Text='<%# Eval("id_inv_projekt")%>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Izdao" ControlStyle-CssClass="a">
                                    <ItemTemplate>
                                        <asp:Label width="100%" class="a" ID="lblIzdao" runat="server"
                                            Text='<%# Eval("izdao")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtIzado" runat="server"
                                            Text='<%# Eval("izdao")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtIzdao1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Opis">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblProjekt" runat="server"
                                            Text='<%# Eval("projekt")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtProjekt" runat="server"
                                            Text='<%# Eval("projekt")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtProjekt1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Naziv">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblNaziv" runat="server"
                                            Text='<%# Eval("naziv")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtNaziv" runat="server"
                                            Text='<%# Eval("naziv")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtNaziv1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Rok">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblRok" runat="server"
                                            Text='<%# Eval("rok")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtRok" runat="server"
                                            Text='<%# Eval("rok")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtRok1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Aktiviran">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblAktiviran" runat="server"
                                            Text='<%# Eval("aktiviran")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtAktiviran" runat="server"
                                            Text='<%# Eval("aktiviran")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtAktiviran1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="14%" HeaderText="Potvrda">
                                    <ItemTemplate>
                                        <asp:Label  width="100%" ID="lblPotvrda" runat="server"
                                            Text='<%# Eval("potvrda")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox  width="100%" ID="txtPotvrda" runat="server"
                                            Text='<%# Eval("potvrda")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox  width="100%" ID="txtPotvrda1" runat="server"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>



                                <asp:TemplateField ItemStyle-Width="5%">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkRemove" runat="server"
                                            CommandArgument='<%# Eval("id_inv_projekt")%>'
                                            OnClientClick="return confirm('Do you want to delete?')"
                                            Text="Obriši" OnClick="DeleteP"></asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button ID="btnAdd" runat="server" Text="Dodaj"
                                            OnClick="dodajP" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ItemStyle-Width="5%" ShowEditButton="True"  EditText="Uredi"/>
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
