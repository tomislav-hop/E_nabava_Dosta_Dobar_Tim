<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dobavljac.aspx.cs" Inherits="E_nabava.Dobavljac" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 331px;
            text-align: center;
        }
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 93px;
        }
        .auto-style3 {
            width: 89px;
        }
        .auto-style4 {
            width: 141px;
        }
        .auto-style5 {
            height: 306px;
        }
        .auto-style6 {
            height: 306px;
            width: 474px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        Kreiranje ponude<br />
        <table class="auto-style1">
            <tr>
                <td class="auto-style6">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="472px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="naziv" HeaderText="Vrsta artikla" SortExpression="naziv" />
                <asp:BoundField DataField="naziv1" HeaderText="Artikl" SortExpression="naziv1" />
                <asp:BoundField DataField="godisnja_kolicina" HeaderText="Godisnja kolicina" SortExpression="godisnja_kolicina" />
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
                </td>
                <td class="auto-style5">
                    <asp:GridView ID="gwPonuda" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="187px" style="margin-top: 0px" Width="453px">
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
                </td>
            </tr>
        </table>
        
        <table class="auto-style1">
            <tr>
                <td class="auto-style2" style="text-align: left">
        <asp:DropDownList ID="ddlKategorije" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlKategorije_SelectedIndexChanged">
        </asp:DropDownList>
                </td>
                <td class="auto-style3" style="text-align: left">
                    <asp:DropDownList ID="ddlArtikli" runat="server" AutoPostBack="True" style="text-align: left; margin-bottom: 0px">
                    </asp:DropDownList>
                </td>
                <td class="auto-style4" style="text-align: left">
                    <asp:TextBox ID="twKolicna" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                </td>
                <td style="text-align: left">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="Dodaj u ponudu" />
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left">&nbsp;</td>
                <td class="auto-style3" style="text-align: left">&nbsp;</td>
                <td class="auto-style4" style="text-align: left">&nbsp;</td>
                <td style="text-align: left">&nbsp;</td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" SelectCommand="Select kategorije.naziv,artikli.naziv,artikli.godisnja_kolicina from artikli,kategorije where artikli.id_kategorije=kategorije.id_kategorije"></asp:SqlDataSource>
        <br />
        <br />
        <br />
        <asp:Button ID="btnLogout" runat="server" OnClick="Button1_Click" Text="Logout" />
    </form>
</body>
</html>
