<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EndUser.Master" Inherits="System.Web.Mvc.ViewPage" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        DataList1.DataSource = ViewData["Source"] as System.Data.DataTable;
        DataList1.DataBind();
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%= ViewData["PromotedNews"] %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
<asp:DataList ID="DataList1" runat="server" CellPadding="4"
        RepeatColumns="1" ShowFooter="False" ShowHeader="False" Width="540px" 
                    BackColor="White" BorderColor="Gainsboro" BorderStyle="None" BorderWidth="1px" 
                    GridLines="Horizontal">
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <ItemStyle BackColor="White" ForeColor="#333333" />
        <SelectedItemStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <ItemTemplate>
            <table cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td style="width: 25px">
                        &nbsp;</td>
                    <td rowspan="4" style="width: 99px" valign="top">
                        <a href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>'>
                        <img height="65px" width="100px" alt="NoImage" src='../../Content/Images/NewsImages/<%#Eval("MainImage")%>' /></a>
                        </td>
                    <td style="width: 36px">
                        &nbsp;</td>
                    <td>
                        <a href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>'>
                            <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Italic="False" 
                            Font-Size="Medium" Text='<%# Eval("Title") %>' Width="398px"></asp:Label>
                            </a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25px">
                        &nbsp;</td>
                    <td style="width: 36px">
                        &nbsp;</td>
                    <td>
                        <asp:Label ID="lblDate" runat="server" Font-Italic="True" 
                            Text='<%# Eval("PostedDate") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25px">
                        &nbsp;</td>
                    <td style="width: 36px">
                        &nbsp;</td>
                    <td>
                        <a href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>' style="color:Black">
                        <asp:Label ID="lblSumary" runat="server" Font-Bold="True" 
                            Font-Underline="False" Height="16px" Text='<%# Eval("Sumary") %>' Width="398px"></asp:Label>
                        </a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25px">
                        &nbsp;</td>
                    <td style="text-align: left; color: #009933; width: 36px;">
                        &nbsp;</td>
                    <td style="text-align: right; color: #009933">
                        <a href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>'>
                            <span style="color: #666666"><i>&lt;&lt;</i></span></a><span 
                            style="color: #666666"><a 
                            href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>'> </a>
                        </span><a href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>'>
                        <asp:Label ID="Label1" runat="server" Font-Italic="True" 
                            style="font-style: italic; color: #666666;" Text="Chi tiết..."></asp:Label>
                        <span style="color: #666666"><i>&gt;&gt;</i></span></a><span style="color: #000000"><a 
                            href='/Articles/<%#DataBinder.Eval(Container.DataItem,"SEOUrl")%>' 
                            style="color: #FF3300"> </a></span>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    </form>
</asp:Content>

