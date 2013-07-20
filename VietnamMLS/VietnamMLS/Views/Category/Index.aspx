<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/EndUser.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.News>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>

    <table>
        <tr>
            <th></th>
            <th>
                NewsId
            </th>
            <th>
                PostedDate
            </th>
            <th>
                IsApproved
            </th>
            <th>
                MainImage
            </th>
            <th>
                CreatedDate
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.NewsId }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.NewsId })%> |
                <%= Html.ActionLink("Delete", "Delete", new { id=item.NewsId })%>
            </td>
            <td>
                <%= Html.Encode(item.NewsId) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:g}", item.PostedDate)) %>
            </td>
            <td>
                <%= Html.Encode(item.IsApproved) %>
            </td>
            <td>
                <%= Html.Encode(item.MainImage) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:g}", item.CreatedDate)) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

