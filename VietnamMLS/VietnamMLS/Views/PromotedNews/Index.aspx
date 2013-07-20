<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%=Html.ActionLink("Create New","Create","PromotedNews") %>
    <%= Html.Telerik().Grid<VietnamMLS.Models.PromotedNewsModel>()
        .Name("Grid")
        .DataKeys(key=>key.Add(pn=>pn.NewsID))
        .DataBinding(dataBingding =>
            {
                dataBingding.Ajax().Select("Index","PromotedNews").Enabled(true);
            })            
         .Columns(column=>
             {
                 column.Bound(c => c.Title).Width(380);
                 column.Bound(c => c.StartedDate).Width(85);
                 column.Bound(c => c.EndedDate).Width(85);
                 column.Bound(c => c.IsUsed).Width(30);
                 column.Bound(c => c.NewsID)
                     .ClientTemplate("<a href='/Admin/PromotedNews/Details/<#= NewsID #>' title='Detail'><img src='../../Content/img/ico_page.png' alt='detailCommand'/></a>"
                        + " | <a href='/Admin/PromotedNews/Edit/<#= NewsID #>' title='Edit'><img src='../../Content/img/edit.png' alt='editCommand'/></a>"
                        + " | <a href='/Admin/PromotedNews/Delete/<#= NewsID #>' title='Delete'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>")
                     .Title("Commands").Width(90);})    
    .Sortable().Scrollable(scrolling => scrolling.Height(500))
                 %>
                 
</asp:Content>

