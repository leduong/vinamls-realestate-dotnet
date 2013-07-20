<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EndUser.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

   <%= ViewData["loadSearch"]%>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <h2><%=ViewData["searchresult"]%></h2>
</asp:Content>

