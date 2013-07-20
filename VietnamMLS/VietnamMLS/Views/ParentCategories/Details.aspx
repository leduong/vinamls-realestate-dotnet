<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.ParentCategoryModel>" %>

<%@ Register src="Categories.ascx" tagname="Categories" tagprefix="uc1" %>

<%@ Register src="LocalizedParentCategories.ascx" tagname="LocalizedParentCategories" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<h2><%= ViewData["ParentName"] %></h2>            --%>
    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                ID :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.ParentCategoryID)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Description :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.Description)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                IsUsed :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.IsUsed)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                SortOrder :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.SortOrder)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                City :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.City)%>
            </td>
        </tr>
    </table>
    <%--<div id="CategoriesList">
    <% Html.RenderPartial("Categories"); %>
    </div>    --%>
    <h3>Included Categories</h3>
    <%= Html.Telerik().Grid<VietnamMLS.Models.CategoryModel>()
        .Name("Grid")
           .DataBinding(data=>
               {
                   data.Ajax().Select("GetCategoryByID", "ParentCategories");
               })
                         .Columns(column =>
                         {
                             column.Bound(c => c.CategoryID).Width(20).ReadOnly();
                             column.Bound(c => c.Description).Width(80);
                             column.Bound(c => c.IsUsed).Width(30);

                             column.Bound(c => c.DefaultImage).Width(60)
                                 .ClientTemplate("<img alt='<#= Description#> image' src='" + Url.Content("~/Content/Images/") + "<#= DefaultImage #>' />");
                             column.Bound(c => c.ParentCategory).Width(50).Title("Parent");
                             column.Bound(c => c.ParentCategory)
                                 .ClientTemplate("<a href='" + Url.Content("/Admin/Categories/Edit/") + "<#= CategoryID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                                     + "<a href='" + Url.Content("/Admin/Categories/Delete/") + "<#= CategoryID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>"
                                     + "<a href='" + Url.Content("/Admin/Categories/Details/") + "<#= CategoryID #>'><img src='/Content/img/ico_page.png' alt='detailCommand' /></a>")
                                     .Title("Command").Width(55);
                         })
                        .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    
    <br />
    <h3>Included Localized Parent Categories</h3>
     <%= Html.Telerik().Grid<VietnamMLS.Models.LocalizedParentCategoryModel>()
        .Name("Grid2")
           .DataBinding(data=>
               {
                   data.Ajax().Select("GetLocalByID", "ParentCategories");
               })
                  .Columns(column=>
                {
                    column.Bound(c => c.ParentCategory).Width(60).ReadOnly().Title("Parent");                    
                    column.Bound(c => c.Language).Width(60).ReadOnly();                    
                    column.Bound(c => c.Name).Width(80);
                    column.Bound(c => c.SEOUrl).Width(20);
                    column.Bound(c => c.SEOKeyword).Width(20);
                    column.Bound(c => c.SEODescription).Width(20);
                    column.Bound(c => c.Name)
                        .ClientTemplate("<a href='" + Url.Content("/Admin/LocalizedParentCategories/Edit/")+ "<#= ParentCategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                            + "<a href='" + Url.Content("/Admin/LocalizedParentCategories/Delete/") + "<#= ParentCategoryID#>?id2=<#=LanguageID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>"
                           )
                            .Title("Command").Width(55);
                })
                .Sortable().Scrollable().Pageable().Groupable().Filterable()
               
    %>
    <%--<% Html.RenderPartial("LocalizedParentCategories"); %>--%>
    <%--<uc2:LocalizedParentCategories ID="LocalizedParentCategory1" runat="server" />--%>

</asp:Content>
