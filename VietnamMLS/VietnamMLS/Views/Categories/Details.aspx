<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%= ViewData["CategoryName"]%></h2>
    <%= Html.Telerik().Grid<VietnamMLS.Models.LocalizedCategoryModel>()
        .Name("Grid")
           .DataBinding(data=>
               {
                   data.Ajax().Select("GetLocalByID", "Categories");
               })
                  .Columns(column =>
                  {
                      column.Bound(c => c.Category).Width(15).ReadOnly();
                      column.Bound(c => c.Language).Width(15).ReadOnly();
                      column.Bound(c => c.Name).Width(20);
                      column.Bound(c => c.SEOUrl).Width(20);
                      column.Bound(c => c.SEOKeyword).Width(20);
                      column.Bound(c => c.SEODescription).Width(20);
                      column.Bound(c => c.Name)
                        .ClientTemplate("<a href='" + Url.Content("/Admin/LocalizedParentCategories/Edit/") + "<#= CategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                            + "<a href='" + Url.Content("/Admin/LocalizedParentCategories/Edit/") + "<#= CategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>")
                            .Title("Command").Width(55);
                  })
                        .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>

       <div>
       
        <%= Html.ActionLink("Back to CategoriesList", "Index") %>
    </div>
</asp:Content>
