<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%= ViewData["RefuseMessage"] %>
    <h3>Sorry, it looks like you don't have administrator right to view or do something in this section</h3>
    <br />
    <h3>If you have an administrator account, please <%= Html.ActionLink("Login", "LogOn", null, new { style="font-weight:bold" })%></h3>

</asp:Content>
