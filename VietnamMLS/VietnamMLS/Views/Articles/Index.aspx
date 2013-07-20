<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EndUser.Master" Inherits="System.Web.Mvc.ViewPage" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        lblTitle.Text=ViewData["Title"].ToString();
        lblDate.Text = ViewData["Date"].ToString();
        lblFullContent.Text=ViewData["FullContent"].ToString();
        lblUser.Text = "-- "+ViewData["User"].ToString().ToUpper()+" --";
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" method="post">
    
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td>
                   <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="Medium" 
            Width="500px" style="color: #003399" ></asp:Label>
                    </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="lblDate" runat="server" style="font-weight: 700"></asp:Label>    
                    </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="lblFullContent" runat="server" Width="540px"></asp:Label>
                   </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="lblUser" runat="server" Width="540px" 
                        style="text-align: right; font-weight: 700;"></asp:Label>    
                    </td>
            </tr>
        </table>
    </form>
    
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="color: #C0C0C0">
                ----------------------------------------------------------------------------------------------------------------</td>
        </tr>
        <tr>
            <td>
                <h2 class='feature-title'><%= ViewData["othernews"]%></h2>
                    <%= ViewData["TheSameCategoryNews"] %>
            </td>
        </tr>
        <tr>
            <td style="color: #C0C0C0">
                ----------------------------------------------------------------------------------------------------------------</td>
        </tr>
        <%--<%
            try{
            bool HaveTagNews = bool.Parse(Session["HaveTagNews"].ToString());
          if (HaveTagNews==true)
          { %>--%>
        <tr>
            <td>
                <h2 class='feature-title'><%= ViewData["tag"]%></h2>
                <%= ViewData["tagNews"]%>
            </td>
        </tr>
        <%--<%}} catch{};%>--%>
    </table>
</asp:Content>

