<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="dfs" runat="server">

<%= Html.Telerik().Grid<VietnamMLS.Models.LocalizedNewsModel>()
        .Name("Grid")
        .DataKeys(key=>key.Add(ln=>ln.NewsID))
        .DataKeys(key => key.Add(ln => ln.LanguageID))
        .DataBinding(dataBingding =>
            {
                dataBingding.Ajax().Select("Index","LocalizedNews").Enabled(true);
            })            
         .Columns(column=>
             {
                 column.Bound(c => c.NewsID).Width(20);
                 column.Bound(c =>c.Title).Width(330);
                 column.Bound(c => c.LanguageName).Width(80).Title("Language");
                 column.Bound(c => c.SEOUrl).Width(150).Title("Url");
                 column.Bound(c=>c.NewsID)
                     .ClientTemplate("<a href='/Admin/LocalizedNews/Details?newsid=<#= NewsID #>&langid=<#= LanguageID #>' title='Detail'><img src='../../Content/img/ico_page.png' alt='detailCommand'/></a>"
                        + " | <a href='/Admin/LocalizedNews/Edit?newsid=<#= NewsID #>&langid=<#= LanguageID #>' title='Edit'><img src='../../Content/img/edit.png' alt='editCommand'/></a>"
                        + " | <a href='/Admin/LocalizedNews/Delete/?newsid=<#= NewsID #>&langid=<#= LanguageID #>' title='Delete'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>")
                     .Title("Commands").Width(90);
              })
              .Sortable().Scrollable(scrolling => scrolling.Height(500)).Pageable().Groupable().Filterable()
    %>
    <p>
    <%=Html.ActionLink("Create New","Create","LocalizedNews") %>
    </p>
    </form>
</asp:Content>

