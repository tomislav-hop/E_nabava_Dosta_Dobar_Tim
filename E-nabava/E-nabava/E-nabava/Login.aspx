<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_nabava.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="bootstrap.css" rel="stylesheet" />
    <link href="bootstrap_min.css" rel="stylesheet" />
    <link href="css.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style2 {
            width: 100%;
        }
        .auto-style3 {
            width: 172px;
        }
        .auto-style4 {
            width: 172px;
            height: 16px;
        }
        .auto-style5 {
            height: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
            <strong>Prijava</strong>
        </div>
        <table class="auto-style2">
            <tr>
                <td class="auto-style3" style="text-align: right">Username</td>
                <td>
                    <asp:TextBox ID="tbUname" runat="server">dob1</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbUname" ErrorMessage="Korisnicko ime je obavezno"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3" style="text-align: right">Password</td>
                <td>
                    <asp:TextBox ID="tbPass" runat="server">dob1</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbPass" ErrorMessage="Lozinka je obavezna"></asp:RequiredFieldValidator>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4"></td>
                <td class="auto-style5">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login" Width="125px" Height="44px" />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Registration.aspx" style="text-align: center">Registriraj se</asp:HyperLink>
                </td>
                <td class="auto-style5"></td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
