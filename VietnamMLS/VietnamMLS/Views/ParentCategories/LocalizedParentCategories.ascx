<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<VietnamMLS.Models.LocalizedParentCategory>>" %>

    <table>
        <tr>
            <th></th>
            <th>
                ParentCategoryID
            </th>
            <th>
                LanguageID
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
        </tr>

    <% foreach (var item in (ViewData["LocalizedParents"] as List<VietnamMLS.Models.LocalizedParentCategory>)) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.ParentCategoryID }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.ParentCategoryID })%> |
                <%= Html.ActionLink("Delete", "Delete", new { id=item.ParentCategoryID })%>
            </td>
            <td>
                <%= Html.Encode(item.ParentCategoryID) %>
            </td>
            <td>
                <%= Html.Encode(item.LanguageID) %>
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
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>


