<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manager.aspx.cs" Inherits="E_nabava.Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 165px;
            width: 498px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="id_korisnici" DataSourceID="SqlDataSourceKorisnici" GridLines="Horizontal">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="id_korisnici" HeaderText="id_korisnici" ReadOnly="True" SortExpression="id_korisnici" />
                <asp:BoundField DataField="naziv" HeaderText="naziv" SortExpression="naziv" />
                <asp:BoundField DataField="adresa" HeaderText="adresa" SortExpression="adresa" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
                <asp:BoundField DataField="broj_telefona" HeaderText="broj_telefona" SortExpression="broj_telefona" />
                <asp:BoundField DataField="korisnicko_ime" HeaderText="korisnicko_ime" SortExpression="korisnicko_ime" />
                <asp:BoundField DataField="lozinka" HeaderText="lozinka" SortExpression="lozinka" />
                <asp:BoundField DataField="tip_korisnika" HeaderText="tip_korisnika" SortExpression="tip_korisnika" />
                <asp:BoundField DataField="aktiviran" HeaderText="aktiviran" SortExpression="aktiviran" />
                <asp:BoundField DataField="aktivacijski_kod" HeaderText="aktivacijski_kod" SortExpression="aktivacijski_kod" />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceKorisnici" runat="server" ConnectionString="<%$ ConnectionStrings:E-NabavaConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT * FROM [korisnici]"></asp:SqlDataSource>
    </form>
</body>
</html>
