<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.LocalizedCategoryModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<%--<table>--%>
        <%--<tr>
            <th></th>
            <th>
                CategoryID
            </th>
            <th>
                CategoryName
            </th>
            <th>
                LanguageID
            </th>
            <th>
                LanguageName
            </th>
            <th>
                Name
            </th>
            <th>
                SEOUrl
            </th>
            <th>
                SEOKeyword
            </th>
            <th>
                SEODescription
            </th>
        </tr>--%>

    <%--<% foreach (var item in Model) { %>
    
        <tr>--%>
           <%-- <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.CategoryID,id2=item.LanguageID }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.CategoryID })%> |
                <%= Html.ActionLink("Delete", "Delete", new { id=item.CategoryID,id2=item.LanguageID })%>
            </td>
            <td>
                <%= Html.Encode(item.CategoryID) %>
            </td>
            <td>
                <%= Html.Encode(item.CategoryReference.CreateSourceQuery().First().Description) %>
            </td>
            <td>
                <%= Html.Encode(item.LanguageID) %>
            </td>
            <td>
                <%= Html.Encode(item.LanguageReference.CreateSourceQuery().First().Name) %>
            </td>
            <td>
                <%= Html.Encode(item.Name) %>
            </td>
            <td>
                <%= Html.Encode(item.SEOUrl) %>
            </td>
            <td>
                <%= Html.Encode(item.SEOKeyword) %>
            </td>
            <td>
                <%= Html.Encode(item.SEODescription) %>
            </td>--%>
        <%--</tr>
    
    <% } %>

    </table>--%>


    
    <%=Html.Telerik().Grid<VietnamMLS.Models.LocalizedCategory>()
    .Name("Grid")
    .DataBinding(databind=>
        {
            databind.Server().Select("Index", "LocalizedCategories", new { ajax = true });
            databind.Ajax().Select("_Index","LocalizedCategories").Enabled(true);
        })
       
            .Columns(column=>
                {
                    column.Bound(c => c.Category).Width(100).ReadOnly();                    
                    column.Bound(c => c.Language).Width(80).ReadOnly();                    
                    column.Bound(c => c.Name).Width(100);
                    column.Bound(c => c.SEOUrl).Width(20);
                    column.Bound(c => c.SEOKeyword).Width(20);
                    column.Bound(c => c.SEODescription).Width(100);
                    column.Bound(c => c.Name)
                        .ClientTemplate("<a href='" + Url.Content("/Admin/LocalizedCategories/Edit/") + "<#= CategoryID#>?id2=<#=LanguageID#>'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                            + "<a href='" + Url.Content("/Admin/LocalizedCategories/Delete/") + "<#= CategoryID#>?id2=<#=LanguageID#>'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>")
                            .Title("Command").Width(55);
                })
                .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
<p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>
</asp:Content>

