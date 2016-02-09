<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUDProjekti.aspx.cs" Inherits="E_nabava.CRUDProjekti" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="shortcut icon" href="./img/logo_kartica.png" type="image/png"/>
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Cabin' rel='stylesheet' type='text/css'/>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'/>
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
    <div class="a">

        dasdas
    </div>
    <form id="form1" runat="server" >
        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
    <div id = "dvGrid" style ="padding:10px;width:550px">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:GridView ID="GridView1" runat="server"  Width = "550px"
AutoGenerateColumns = "false" Font-Names = "Arial"
Font-Size = "11pt" AlternatingRowStyle-BackColor = "#C2D69B" 
HeaderStyle-BackColor = "green" AllowPaging ="true"  ShowFooter = "true" 
OnPageIndexChanging = "OnPaging" onrowediting="EditP"
onrowupdating="UpdateP"  onrowcancelingedit="CancelEdit"
PageSize = "10" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" OnRowDataBound="GridView1_RowDataBound" OnDataBound="GridView1_DataBound" >
<Columns>
<asp:TemplateField ItemStyle-Width = "30px"  HeaderText = "ID artikla">
    <ItemTemplate>
        <asp:Label ID="lblIdProjekt" runat="server"
        Text='<%# Eval("id_inv_projekt")%>'></asp:Label>
    </ItemTemplate>
   
</asp:TemplateField>
<asp:TemplateField ItemStyle-Width = "100px"  HeaderText = "Izdao" ControlStyle-CssClass="a">
    <ItemTemplate >
        <asp:Label class="a" ID="lblIzdao" runat="server"
                Text='<%# Eval("izdao")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtIzado" runat="server"
            Text='<%# Eval("izdao")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtIzdao1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
<asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Opis projekta">
    <ItemTemplate>
        <asp:Label ID="lblProjekt" runat="server"
            Text='<%# Eval("projekt")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtProjekt" runat="server"
            Text='<%# Eval("projekt")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtProjekt1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Naziv">
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
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Rok">
    <ItemTemplate>
        <asp:Label ID="lblRok" runat="server"
            Text='<%# Eval("rok")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtRok" runat="server"
            Text='<%# Eval("rok")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtRok1" runat="server"></asp:TextBox>
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
    <asp:TemplateField ItemStyle-Width = "150px"  HeaderText = "Potvrda">
    <ItemTemplate>
        <asp:Label ID="lblPotvrda" runat="server"
            Text='<%# Eval("potvrda")%>'></asp:Label>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtPotvrda" runat="server"
            Text='<%# Eval("potvrda")%>'></asp:TextBox>
    </EditItemTemplate> 
    <FooterTemplate>
        <asp:TextBox ID="txtPotvrda1" runat="server"></asp:TextBox>
    </FooterTemplate>
</asp:TemplateField>

     
      
<asp:TemplateField>
    <ItemTemplate>
        <asp:LinkButton ID="lnkRemove" runat="server"
            CommandArgument = '<%# Eval("id_inv_projekt")%>'
         OnClientClick = "return confirm('Do you want to delete?')"
        Text = "Delete" OnClick = "DeleteP"></asp:LinkButton>
    </ItemTemplate>
    <FooterTemplate>
        <asp:Button ID="btnAdd" runat="server" Text="Add"
            OnClick = "dodajP" />
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
