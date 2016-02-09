<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUDKorisnici.aspx.cs" Inherits="E_nabava.CRUDKorisnici" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type = "text/javascript" src = "scripts/jquery-1.3.2.min.js"></script>
<script type = "text/javascript" src = "scripts/jquery.blockUI.js"></script>
<script type = "text/javascript">
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
    <form id="form1" runat="server">
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
    <div id = "dvGrid" style ="padding:10px;width:550px">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:GridView ID="GridView1" runat="server"  Width = "550px"
AutoGenerateColumns = "false" Font-Names = "Arial"
Font-Size = "11pt" AlternatingRowStyle-BackColor = "#C2D69B" 
HeaderStyle-BackColor = "green" AllowPaging ="true"  ShowFooter = "true" 
OnPageIndexChanging = "OnPaging" onrowediting="EditKorisnici"
onrowupdating="UpdateKorisnici"  onrowcancelingedit="CancelEdit"
PageSize = "10" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound" >
<Columns>
<asp:TemplateField ItemStyle-Width = "30px"  HeaderText = "ID korisnika">
    <ItemTemplate>
        <asp:Label ID="lblIdKorisnika" runat="server"
        Text='<%# Eval("id_korisnici")%>'></asp:Label>
    </ItemTemplate>
   
</asp:TemplateField>
<asp:TemplateField ItemStyle-Width = "100px"  HeaderText = "Ime">
    <ItemTemplate>
        <asp:Label ID="lblNaziv" runat="server"
                Text='<%# Eval("naziv")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtNaziv" runat="server"
            Text='<%# Eval("naziv")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtNaziv1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
<asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Adresa">
    <ItemTemplate>
        <asp:Label ID="lblAdresa" runat="server"
            Text='<%# Eval("[adresa]")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtAdresa" runat="server"
            Text='<%# Eval("[adresa]")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtAdresa1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Email">
    <ItemTemplate>
        <asp:Label ID="lblEmail" runat="server"
            Text='<%# Eval("email")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtEmail" runat="server"
            Text='<%# Eval("email")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtEmail1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Broj telefona">
    <ItemTemplate>
        <asp:Label ID="lblBrojTelefona" runat="server"
            Text='<%# Eval("broj_telefona")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtBrojTelefona" runat="server"
            Text='<%# Eval("broj_telefona")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtBrojTelefona1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Korisničko ime">
    <ItemTemplate>
        <asp:Label ID="lblKorisnickoIme" runat="server"
            Text='<%# Eval("korisnicko_ime")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtKorisnickoIme" runat="server"
            Text='<%# Eval("korisnicko_ime")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtKorisnickoIme1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
     <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Lozinka">
    <ItemTemplate>
        <asp:Label ID="lblLozinka" runat="server"
            Text='<%# Eval("lozinka")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtLozinka" runat="server"
            Text='<%# Eval("lozinka")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtLozinka1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
   <asp:TemplateField HeaderText="Tip korisnika" HeaderStyle-HorizontalAlign="Left">
          <ItemTemplate>
        <asp:Label ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>'></asp:Label>
    </ItemTemplate>
            <EditItemTemplate>
                <asp:Label ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>' Visible = "false"></asp:Label>
                 <asp:DropDownList ID="ddlTip1" runat="server">
                </asp:DropDownList>

              
            </EditItemTemplate>
            <ItemTemplate>
                <%# Eval("naziv1")%>
            </ItemTemplate>
            <FooterTemplate>
                <asp:DropDownList ID="ddlTip" runat="server" DataTextField="naziv_tipa" DataValueField="id_tip" DataSourceID="SqlDataSource1">
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:foiCoreConnectionString %>' SelectCommand="SELECT [id_tip], [naziv_tipa] FROM [tip_korisnika]"></asp:SqlDataSource>
            </FooterTemplate>
        </asp:TemplateField>
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Aktiviran">
    <ItemTemplate>
        <asp:Label ID="lblAktiviran" runat="server"
            Text='<%# Eval("aktiviran")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtAktiviran" runat="server"
            Text='<%# Eval("aktiviran")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtAktiviran1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
      <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Aktivacijski kod">
    <ItemTemplate>
        <asp:Label ID="lblAktivacijskiKod" runat="server"
            Text='<%# Eval("aktivacijski_kod")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtAktivacijskiKod" runat="server"
            Text='<%# Eval("aktivacijski_kod")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtAktivacijskiKod1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>

     
      
<asp:TemplateField>
    <ItemTemplate>
        <asp:LinkButton ID="lnkRemove" runat="server"
            CommandArgument = '<%# Eval("id_korisnici")%>'
         OnClientClick = "return confirm('Do you want to delete?')"
        Text = "Delete" OnClick = "DeleteKorisnik"></asp:LinkButton>
    </ItemTemplate>
    <FooterTemplate>
        <asp:Button ID="btnAdd" runat="server" Text="Add"
            OnClick = "dodajNovogKorisnika" />
    </FooterTemplate>
</asp:TemplateField>
<asp:CommandField  ShowEditButton="True" />
</Columns>
<AlternatingRowStyle BackColor="#C2D69B"  />
</asp:GridView>
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID = "GridView1" />
</Triggers>
</asp:UpdatePanel>
</div>
    </form>
</body>
</html>

