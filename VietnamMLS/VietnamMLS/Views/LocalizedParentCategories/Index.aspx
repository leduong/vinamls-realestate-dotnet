<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.LocalizedParentCategoryModel>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%=Html.Telerik().Grid<VietnamMLS.Models.LocalizedParentCategory>()
    .Name("Grid")
    .DataBinding(databind=>
        {
            databind.Server().Select("Index", "LocalizedParentCategories", new { ajax = true });
            databind.Ajax().Select("_Index","LocalizedParentCategories").Enabled(true);
        })
       
            .Columns(column=>
                {
                    column.Bound(c => c.ParentCategory).Width(60).ReadOnly().Title("Parent");                    
                    column.Bound(c => c.Language).Width(60).ReadOnly();                    
                    column.Bound(c => c.Name).Width(80);
                    column.Bound(c => c.SEOUrl).Width(30);
                    //column.Bound(c => c.SEOKeyword).Width(20);
                    //column.Bound(c => c.SEODescription).Width(20);
                    column.Bound(c => c.Name)
                        .ClientTemplate("<a href='/Admin/LocalizedParentCategories/Edit/<#= ParentCategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                            + "<a href='/Admin/LocalizedParentCategories/Delete/<#= ParentCategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>"
                            ).Title("Command").Width(55);
                })
                .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>
</asp:Content>

