<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dobavljac.aspx.cs" Inherits="E_nabava.Dobavljac" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        <link href="bootstrap.css" rel="stylesheet" />
        <link href="bootstrap_min.css" rel="stylesheet" />
        <link href="css.css" rel="stylesheet" />
    .hiddencol
    {
    display: none;
    }
</style>
    <style type="text/css">
        #form1 {
            height: 331px;
            text-align: center;
        }

        </style>
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


    <form id="form1" runat="server">
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
        Kreiranje ponude<br />
              <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate> 

   
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="id_artikla" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="917px" OnRowCommand="GridView1_RowCommand">
                        
                        <Columns>
                            <asp:TemplateField>
            <ItemTemplate>
                <img alt = "" style="cursor: pointer" src="images/plus.png" />
                <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass = "ChildGrid">
                        <Columns>
                            <asp:BoundField ItemStyle-Width="150px" DataField="opis" HeaderText="Opis artikla" />
                             <asp:BoundField ItemStyle-Width="150px" DataField="godisnja_kolicina" HeaderText="Godišnja količina" />
                             <asp:BoundField ItemStyle-Width="150px" DataField="jedinica_mjere" HeaderText="Jedinična mjera" />
                           
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </ItemTemplate>
        </asp:TemplateField>
                            <asp:BoundField DataField="id_artikla" HeaderText="id_artikla" SortExpression="id_artikla"  ReadOnly="True" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"/>
                       <asp:BoundField DataField="Kategorija" HeaderText="Kategorija" SortExpression="Kategorija" />
                            <asp:BoundField DataField="Podkategorija" HeaderText="Podkategorija" SortExpression="Podkategorija" />
                            <asp:BoundField DataField="Artikl" HeaderText="Artikl" SortExpression="Artikl" />
                            <asp:ButtonField Text="Dodaj artikl" CommandName="Select" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

                    </asp:GridView>
                    
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>"
                         SelectCommand="SELECT  n2.id_artikla , n.naziv as Kategorija,n.id_kategorije as IDKAT,  n1.naziv AS Podkategorija, n2.naziv AS Artikl
                            FROM  kategorije AS n INNER JOIN
                         podkategorije AS n1 ON n.id_kategorije = n1.id_kategorije INNER JOIN
                         artikli AS n2 ON n1.id_podkategorije = n2.id_podkategorije order by n.naziv;" FilterExpression="IDKAT = '{0}'">
                     <FilterParameters>
        <asp:ControlParameter Name="naziv" ControlID="ddlKategorije" PropertyName="SelectedValue" />
    </FilterParameters>
                    </asp:SqlDataSource>
                <br />
                 <div style="float:left; width: 907px;">
                Odaberi Kategoriju:
    <asp:DropDownList ID="ddlKategorije" runat="server" AutoPostBack="true" DataSourceID="DropDownDataSource"
    DataTextField="naziv" DataValueField="id_kategorije" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlKategorije_SelectedIndexChanged">
    <asp:ListItem Text="Sve kategorije" Value="" />
</asp:DropDownList>
               <asp:SqlDataSource ID="DropDownDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="SELECT * FROM kategorije"></asp:SqlDataSource>   
               <asp:Label ID="lblPretrazi" runat="server" Text="Pretraži tablicu:"> </asp:Label>
              <asp:TextBox ID="txtSearch" runat="server" onkeyup="Search_Gridview(this, 'GridView1')"  OnTextChanged="txtSearch_TextChanged" Width="128px"></asp:TextBox><br />
                  
             <br />
                   
            
                     <br /> 
                  <asp:Label ID="lblArtikl" runat="server" Text="Odabrani artikl:"> </asp:Label>
                  <asp:TextBox ID="tbArtikl" runat="server" OnTextChanged="tbArtikl_TextChanged"></asp:TextBox>
                    <br />
                     <asp:Label ID="lblKolicina" runat="server" Text="Količina:"> </asp:Label>
                  <asp:TextBox ID="tbKolicina" runat="server" ></asp:TextBox>
                     </br>
                 <asp:Label ID="lblCijena" runat="server" Text="Cijena:"> </asp:Label>
                  <asp:TextBox ID="tbCijena" runat="server" Width="169px"></asp:TextBox>
                    <br />
                      <asp:Label ID="lblRokPlacanja" runat="server" Text="Rok plaćanja:"> </asp:Label>
                  <asp:TextBox ID="tbRokPlacanja" runat="server"></asp:TextBox>
                     <br />
                      <asp:Label ID="lblRokIsporuke" runat="server" Text="Rok isporuke:"> </asp:Label>
                  <asp:TextBox ID="tbRokIsporuke" runat="server"></asp:TextBox>
                    <br />
                     <asp:Label ID="lblPlacanje" runat="server" Text="Način plaćanja:"> </asp:Label>


                     <asp:DropDownList ID="DropDownList1" runat="server">
                         <asp:ListItem Selected="True" Value="null">Način plaćanja</asp:ListItem>
                         <asp:ListItem>Gotovina</asp:ListItem>
                         <asp:ListItem>Karticom</asp:ListItem>
                         <asp:ListItem>Ostalo</asp:ListItem>
                     </asp:DropDownList>
             <br />
     <asp:Label ID="lblKvaliteta" runat="server" Text="Kvaliteta zadovoljava opis:"> </asp:Label>

                     <asp:DropDownList ID="DropDownList2" runat="server">
                         <asp:ListItem Selected="True" Value=" null">Odaberite</asp:ListItem>
                         <asp:ListItem>Da</asp:ListItem>
                         <asp:ListItem>Ne</asp:ListItem>
                         <asp:ListItem>Djelomicno</asp:ListItem>
                     </asp:DropDownList>
                      <br />
                      <asp:Label ID="lblNapomena" runat="server" Text="Napomena:"> </asp:Label>
                  <asp:TextBox ID="tbNapomena" runat="server"></asp:TextBox>
                     <asp:Label ID="lblAlternativa" runat="server" Text="Alternativa:"> </asp:Label>
                  <asp:TextBox ID="tbAlternativa" runat="server"></asp:TextBox>
                     <br />
                    
 
                      <br />
                </div>
                </ContentTemplate> </asp:UpdatePanel>
            
          <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Dodaj u ponudu" Width="284px" />
        <br />
        <br />
                  
               
                    <asp:GridView ID="gwPonuda" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="187px" Style="margin-top: 0px; margin-left: 0px;" Width="878px" AutoGenerateDeleteButton="True" OnRowDeleting="gwPonuda_RowDeleting1">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
               <br />
        <br />
                    <asp:Button ID="btnLogout" runat="server" OnClick="Button1_Click" Text="Logout" />
      </form>

</body>



</html>
