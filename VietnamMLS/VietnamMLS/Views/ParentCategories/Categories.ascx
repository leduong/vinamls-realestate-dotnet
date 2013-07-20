<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<VietnamMLS.Models.Category>>" %>

    <table>
        <tr>
            <th></th>
            <th>
                CategoryID
            </th>
            <th>
                Description
            </th>
            <th>
                IsUsed
            </th>
            <th>
                DefaultImage
            </th>
            <th>
                SortOrder
            </th>
        </tr>

    <% foreach (var item in (ViewData["Categories"] as List<VietnamMLS.Models.Category>)) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", "Categories",new { id=item.CategoryID }, null) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.CategoryID })%> |
                <%= Html.ActionLink("Delete", "Delete", new { id=item.CategoryID })%>
            </td>
            <td>
                <%= Html.Encode(item.CategoryID) %>
            </td>
            <td>
                <%= Html.Encode(item.Description) %>
            </td>
            <td>
                <%= Html.Encode(item.IsUsed) %>
            </td>
            <td>
                <%= Html.Encode(item.DefaultImage) %>
            </td>
            <td>
                <%= Html.Encode(item.SortOrder) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>


