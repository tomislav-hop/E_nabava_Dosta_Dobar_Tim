<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUDPodkategorije.aspx.cs" Inherits="E_nabava.CRUDPodkategorije" %>

<!DOCTYPE html>

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
OnPageIndexChanging = "OnPaging" onrowediting="EditPK"
onrowupdating="UpdatePK"  onrowcancelingedit="CancelEdit"
PageSize = "10" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound" >
<Columns>
<asp:TemplateField ItemStyle-Width = "30px"  HeaderText = "ID podkategorije">
    <ItemTemplate>
        <asp:Label ID="lblIdPodkategorije" runat="server"
        Text='<%# Eval("id_podkategorije")%>'></asp:Label>
    </ItemTemplate>
   
</asp:TemplateField>
<asp:TemplateField ItemStyle-Width = "100px"  HeaderText = "Naziv podkategorije">
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

   
    

     <asp:TemplateField HeaderText="Kategorija" HeaderStyle-HorizontalAlign="Left">
          <ItemTemplate>
        <asp:Label ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>'></asp:Label>
    </ItemTemplate>
            <EditItemTemplate>
                <asp:Label ID="lblNaziv" runat="server" Text='<%# Eval("naziv1")%>' Visible = "false"></asp:Label>
                 <asp:DropDownList ID="ddlKategorije1" runat="server">
                </asp:DropDownList>

               
            </EditItemTemplate>
            <ItemTemplate>
                <%# Eval("naziv1")%>
            </ItemTemplate>
            <FooterTemplate>
                <asp:DropDownList ID="ddlKategorije" runat="server" DataTextField="naziv" DataValueField="id_kategorije" DataSourceID="SqlDataSource1">
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:foiCoreConnectionString %>' SelectCommand="SELECT [id_kategorije], [naziv] FROM [kategorije]"></asp:SqlDataSource>
            </FooterTemplate>
        </asp:TemplateField>
      
<asp:TemplateField>
    <ItemTemplate>
        <asp:LinkButton ID="lnkRemove" runat="server"
            CommandArgument = '<%# Eval("id_podkategorije")%>'
         OnClientClick = "return confirm('Do you want to delete?')"
        Text = "Delete" OnClick = "DeletePK"></asp:LinkButton>
    </ItemTemplate>
    <FooterTemplate>
        <asp:Button ID="btnAdd" runat="server" Text="Add"
            OnClick = "dodajNovuPK" />
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
