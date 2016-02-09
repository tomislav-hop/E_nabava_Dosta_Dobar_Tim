<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PocetnaStranica.aspx.cs" Inherits="E_nabava.PocetnaStranica" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Metalska industrija Varaždin</title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png"/>
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css'/>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'/>
    
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

    <form id="form1" runat="server">
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>
                   <div class="row">
    <div class="container dobavljacOkvir1"> 
                <label class="dobavljacLabela">Odaberi Kategoriju</label><br />
                <asp:DropDownList placeholder="Odaberite kategoriju proizvoda" class="dobavljacInput" ID="ddlKategorije" runat="server" AutoPostBack="true" DataSourceID="DropDownDataSource"
                        DataTextField="naziv" DataValueField="id_kategorije" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlKategorije_SelectedIndexChanged">
                <asp:ListItem Text="Sve kategorije" Value="" />

                </asp:DropDownList>
                    <asp:SqlDataSource ID="DropDownDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM kategorije"></asp:SqlDataSource>
                    <br /><br />

                    <asp:Label class="dobavljacLabela" ID="lblPretrazi" runat="server" Text="Pretraži tablicu:"> </asp:Label><br />
                    <asp:TextBox class="dobavljacInput" ID="txtSearch" runat="server" onkeyup="Search_Gridview(this, 'GridView1')" ></asp:TextBox><br />
        </div></div>

                 <div class ="row grid" id="dobavljacGrid1">

                <asp:GridView HeaderStyle-HorizontalAlign="Center"  class="dobavljacGrid2" ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                    DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound"
                     DataKeyNames="id_artikla"  
                    OnRowCommand="GridView1_RowCommand" GridLines="Both" >

                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <img alt="" style="cursor: pointer" src="images/plus.png" />
                                <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                    <asp:GridView Width="100%" ID="GridView4" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                        <Columns>
                                            <asp:BoundField ItemStyle-Width="20%" DataField="naziv" HeaderText="Podkategorija" SortExpression="Podkategorija" />
                                           
                                        </Columns>
                                    </asp:GridView>
                                     <asp:GridView Width="100%" ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                        <Columns>
                                            
                                            <asp:BoundField ItemStyle-Width="20%" DataField="godisnja_kolicina" HeaderText="Godišnja količina" />
                                            
                                        </Columns>
                                    </asp:GridView>
                                     <asp:GridView Width="100%" ID="GridView3" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                        <Columns>
                                           
                                            <asp:BoundField ItemStyle-Width="20%" DataField="jedinica_mjere" HeaderText="Jedinična mjera" />
                                          </Columns>
                                    </asp:GridView>
                                     <asp:GridView Width="100%" ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                        <Columns>
                                           
                                            <asp:BoundField ItemStyle-Width="40%" DataField="opis" HeaderText="Opis artikla" />
                                        </Columns>
                                    </asp:GridView>
                                </asp:Panel>
                            </ItemTemplate>
                            
                        </asp:TemplateField>

                        <asp:BoundField DataField="id_artikla" HeaderText="Šifra artikla" SortExpression="id_artikla" ReadOnly="True" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" >
                        <HeaderStyle CssClass="hiddencol" />
                        <ItemStyle CssClass="hiddencol" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Kategorija" HeaderText="Kategorija" SortExpression="Kategorija" />
                       
                        <asp:BoundField DataField="Artikl" HeaderText="Artikl" SortExpression="Artikl" />
                        <asp:ButtonField Text="Dodaj artikl" CommandName="Select" />
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
           
                  
             
                    </div></div>
            </ContentTemplate>
            
        
        </asp:UpdatePanel>
        <div class="poljeGumb1">
       
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