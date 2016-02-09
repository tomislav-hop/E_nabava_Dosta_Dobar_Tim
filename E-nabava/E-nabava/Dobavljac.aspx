<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dobavljac.aspx.cs" Inherits="E_nabava.Dobavljac" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png" />
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css' />

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>
    <script type="text/javascript">
        function Search_Gridview(strKey, strGV) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }
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
                   
                    <li class="navigacijaElement" id="izbornik1" runat="server">
                        <a href="Pregled_ponuda.aspx">PREGLED PONUDA</a>
                    </li>
                    <li role="presentation" class="dropdown navigacijaElement">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false">PROJEKTI <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu lista" role="menu">
                            <li>
                                <a href="Investicijski_projekti.aspx" id="izbornik2">PONUDA</a>
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
                    <div class="container dobavljacOkvir1">
                        <label class="dobavljacLabela">Odaberi Kategoriju</label><br />
                        <asp:DropDownList placeholder="Odaberite kategoriju proizvoda" class="dobavljacInput padajuciIzbornik" ID="ddlKategorije" runat="server" AutoPostBack="true" DataSourceID="DropDownDataSource"
                            DataTextField="naziv" DataValueField="id_kategorije" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlKategorije_SelectedIndexChanged">
                            <asp:ListItem Text="Sve kategorije" Value="" />

                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DropDownDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM kategorije"></asp:SqlDataSource>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblPretrazi" runat="server" Text="Pretraži tablicu:"> </asp:Label><br />
                        <asp:TextBox placeholder="Unesite naziv artikla" class="dobavljacInput" ID="txtSearch" runat="server" onkeyup="Search_Gridview(this, 'GridView1')"></asp:TextBox><br />
                    </div>
                </div>

                <div class="row grid" id="dobavljacGrid1">

                    <asp:GridView HeaderStyle-HorizontalAlign="Center" class="dobavljacGrid2" ID="GridView1" runat="server" AllowPaging="True"
                        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4"
                        DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound"
                        DataKeyNames="id_artikla"
                        OnRowCommand="GridView1_RowCommand" GridLines="Both">

                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <img alt="" style="cursor: pointer" src="images/plus.png" />
                                    <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                        <asp:GridView Width="98%" ID="gvOrders" runat="server" AutoGenerateColumns="false"
                                            CssClass="ChildGrid detaljiDobavljac">
                                            <Columns>
                                                <asp:BoundField
                                                    HeaderStyle-Font-Names="'Calibri', sans-serif" ItemStyle-Font-Names="'Calibri', sans-serif"
                                                    HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%"
                                                    DataField="naziv" HeaderText="Podkategorija" SortExpression="Podkategorija" />
                                            </Columns>
                                            <Columns>
                                                <asp:BoundField HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%"
                                                    DataField="godisnja_kolicina" HeaderText="Godišnja količina"
                                                    HeaderStyle-Font-Names="'Calibri', sans-serif" ItemStyle-Font-Names="'Calibri', sans-serif" />
                                            </Columns>
                                            <Columns>
                                                <asp:BoundField HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="19%"
                                                    DataField="jedinica_mjere" HeaderText="Jedinična mjera"
                                                    HeaderStyle-Font-Names="'Calibri', sans-serif" ItemStyle-Font-Names="'Calibri', sans-serif" />
                                            </Columns>
                                            <Columns>
                                                <asp:BoundField HeaderStyle-Height="40px" ItemStyle-Height="40px" ItemStyle-Width="41%"
                                                    DataField="opis" HeaderText="Opis artikla"
                                                    HeaderStyle-Font-Names="'Calibri', sans-serif" ItemStyle-Font-Names="'Calibri', sans-serif" />
                                            </Columns>
                                        </asp:GridView>
                                    </asp:Panel>
                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:BoundField DataField="id_artikla" HeaderText="Šifra artikla" SortExpression="id_artikla" ReadOnly="True" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                            <asp:BoundField DataField="Kategorija" HeaderText="Kategorija" SortExpression="Kategorija" />

                            <asp:BoundField DataField="Artikl" HeaderText="Artikl" SortExpression="Artikl" />
                            <asp:ButtonField ControlStyle-ForeColor="#93948A" HeaderText="Dodaj artikl u ponudu" Text="Dodaj artikl" CommandName="Select" />
                        </Columns>


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
                </div>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>"
                    SelectCommand="SELECT  n2.id_artikla , n.naziv as Kategorija,n.id_kategorije as IDKAT,  n1.naziv AS Podkategorija, n2.naziv AS Artikl
                            FROM  kategorije AS n INNER JOIN
                         podkategorije AS n1 ON n.id_kategorije = n1.id_kategorije INNER JOIN
                         artikli AS n2 ON n1.id_podkategorije = n2.id_podkategorije order by n.naziv;"
                    FilterExpression="IDKAT = '{0}'">
                    <FilterParameters>
                        <asp:ControlParameter Name="naziv" ControlID="ddlKategorije" PropertyName="SelectedValue" />
                    </FilterParameters>
                </asp:SqlDataSource>
                <br />

                <div class="row">
                    <div class="container dobavljacOkvir">




                        <br />


                        <asp:Label class="dobavljacLabela" ID="lblArtikl" runat="server" Text="Odabrani artikl:"> </asp:Label><br />
                        <asp:TextBox class="dobavljacInput" Height="30px" ID="tbArtikl" runat="server"></asp:TextBox>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblKolicina" runat="server" Text="Količina:"> </asp:Label><br />
                        <asp:TextBox placeholder="Unesite količinu" class="dobavljacInput" ID="tbKolicina" runat="server"></asp:TextBox>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblCijena" runat="server" Text="Cijena:"> </asp:Label><br />
                        <asp:TextBox placeholder="Unesite cijenu" class="dobavljacInput" ID="tbCijena" runat="server"></asp:TextBox>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblRokPlacanja" runat="server" Text="Rok plaćanja:"> </asp:Label><br />
                        <asp:TextBox placeholder="Unesite rok plačanja" class="dobavljacInput" ID="tbRokPlacanja" runat="server"></asp:TextBox>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblRokIsporuke" runat="server" Text="Rok isporuke:"> </asp:Label><br />
                        <asp:TextBox placeholder="Unesite rok isporuke" class="dobavljacInput" ID="tbRokIsporuke" runat="server"></asp:TextBox>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblPlacanje" runat="server" Text="Način plaćanja:"> </asp:Label><br />
                        <asp:DropDownList class="dobavljacInput padajuciIzbornik" ID="DropDownList1" runat="server">
                            <asp:ListItem Selected="True" Value="null">Odaberite način plačanja</asp:ListItem>
                            <asp:ListItem>Gotovina</asp:ListItem>
                            <asp:ListItem>Karticom</asp:ListItem>
                            <asp:ListItem>Ostalo</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblKvaliteta" runat="server" Text="Kvaliteta zadovoljava opis:"> </asp:Label>
                        <asp:DropDownList class="dobavljacInput padajuciIzbornik" ID="DropDownList2" runat="server">
                            <asp:ListItem Selected="True" Value=" null">Odaberite u kojoj mjeri kvaliteta zadovoljava opis</asp:ListItem>
                            <asp:ListItem>Da</asp:ListItem>
                            <asp:ListItem>Ne</asp:ListItem>
                            <asp:ListItem>Djelomicno</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />

                        <asp:Label class="dobavljacLabela" ID="lblNapomena" runat="server" Text="Napomena:"> </asp:Label>
                        <asp:TextBox Height="150px" TextMode="MultiLine" placeholder="Unesite napomenu" class="dobavljacInput" ID="tbNapomena" runat="server"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label class="dobavljacLabela" ID="lblAlternativa" runat="server" Text="Alternativa:"> </asp:Label>
                        <asp:TextBox placeholder="Unesite alternativu" class="dobavljacInput" ID="tbAlternativa" runat="server"></asp:TextBox>


                        <asp:Label ID="lblGreske" runat="server" ForeColor="Red"></asp:Label>


                    </div>
                </div>
            </ContentTemplate>


        </asp:UpdatePanel>
        <div class="poljeGumb1">
            <asp:Button class="gumb3Dobavljac" ID="Button1" runat="server" OnClick="Button1_Click1" Text="Dodaj u ponudu" />
            <asp:Button class="gumb2Dobavljac" ID="btnGenerirajPDF" runat="server" OnClick="btnGenerirajPDF_Click" Text="Pošalji ponudu" />
        </div>


        <div class="row grid">


            <asp:GridView class="investicijaGrid" ID="gwPonuda" runat="server" CellPadding="4" ForeColor="#333333" GridLines="Both" Style="margin-top: 0px; margin-left: 0px;" AutoGenerateDeleteButton="True" OnRowDeleting="gwPonuda_RowDeleting1" OnRowDataBound="gwPonuda_RowDataBound">
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" />
                <HeaderStyle CssClass="tablicaDobavljacTekst" Height="40px" BackColor="#EAF6F2" ForeColor="#93948A" Font-Bold="True" Font-Names="'Calibri', sans-serif" Font-Size="14px" />
                <PagerStyle BackColor="yellow" HorizontalAlign="Center" />

                <RowStyle BackColor="white" Height="40px" CssClass="tablicaDobavljacTekst" ForeColor="#93948A" Font-Names="'Calibri', sans-serif" />
                <AlternatingRowStyle BackColor="#EAF6F2" CssClass="tablicaDobavljacTekst" ForeColor="#93948A" Font-Names="'Calibri', sans-serif" />

                <EditRowStyle BackColor="#EAF6F2" />

                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>

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
