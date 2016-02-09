<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="E_nabava.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            font-weight: normal;
            width: 215px;
            text-align: right;
        }
        .auto-style3 {
            width: 215px;
            text-align: right;
        }
        .auto-style4 {
            width: 134px;
        }
        .auto-style5 {
            width: 215px;
            text-align: right;
            height: 26px;
        }
        .auto-style6 {
            width: 134px;
            height: 26px;
        }
        .auto-style7 {
            height: 26px;
            text-align: left;
        }
        .auto-style8 {
            text-align: left;
        }
        .auto-style9 {
            width: 134px;
            height: 26px;
            text-align: left;
        }
        .auto-style10 {
            width: 215px;
            text-align: right;
            height: 26px;
        }
        #form1 {
            text-align: center;
        }
        .auto-style11 {
            font-weight: normal;
            font-size: xx-large;
        }
    </style>
</head>
<body style="font-weight: 700; text-align: center;">
    <span class="auto-style11"><strong>Registracija
    </strong></span>
    <form id="form1" runat="server">
        <table class="auto-style1">
            <tr>
                <td class="auto-style2"><strong>Naziv dobavljača</strong></td>
                <td class="auto-style4">
                    <asp:TextBox ID="tbNaziv" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style8" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbNaziv" ErrorMessage="Morate upisati naziv"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style10">Adresa</td>
                <td class="auto-style9">
                    <asp:TextBox ID="tbAdresa" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style7" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbAdresa" ErrorMessage="Morate upisati adresu"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Broj telefona</td>
                <td class="auto-style4">
                    <asp:TextBox ID="tbBrojTelefona" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                </td>
                <td class="auto-style8" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbBrojTelefona" ErrorMessage="Morate upisati broj telefona"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">E-mail</td>
                <td class="auto-style4">
                    <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style8" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbKorisnickoIme" ErrorMessage="Morate upisati E-mail"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbEmail" ErrorMessage="Neispravan Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Korisničko ime</td>
                <td class="auto-style4">
                    <asp:TextBox ID="tbKorisnickoIme" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style8" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbKorisnickoIme" ErrorMessage="Morate upisati korisnicko ime"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">Lozinka</td>
                <td class="auto-style6">
                    <asp:TextBox ID="tbLozinka" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style7" style="color: #FF0000" aria-required="False">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbLozinka" ErrorMessage="Morate upisati lozinku"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">Potvrda lozinke</td>
                <td class="auto-style4">
                    <asp:TextBox ID="tbPotvrdaLozinke" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style8" style="color: #FF0000">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbPotvrdaLozinke" ErrorMessage="Morate upisati potvrdu lozinke"></asp:RequiredFieldValidator>
                    <br />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbLozinka" ControlToValidate="tbPotvrdaLozinke" ErrorMessage="Lozinka i potvrda lozinke nisu iste"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Prijava" />
                </td>
                <td class="auto-style8" style="color: #FF0000">&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
