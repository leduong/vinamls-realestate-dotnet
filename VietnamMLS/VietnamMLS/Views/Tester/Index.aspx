﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>

    <br/>
    Year:
    <%= ViewData["Year"] %>
    <br/>
    Month:
    <%= ViewData["Month"]%>
    <br/>
    Day:
    <%= ViewData["Day"]%>
    <br/>

</asp:Content>
