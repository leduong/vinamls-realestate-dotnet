<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                User ID :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.UserID) %>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Username :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.Username) %>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Password :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.Password) %>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                Email :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.Email) %>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Role assigned :</td>
            <td style="height: 30px;padding-left:3px">
                <%= Html.Encode(Model.RoleReference.CreateSourceQuery().First().RoleName) %></td>
        </tr>
    </table>
    <p>
   <%-- <%if(Model.isCreatedBy(Context.User.Identity.Name)||Context.User.IsInRole("admin")){ %>  
    <% } %>--%>
        <%= Html.ActionLink("Edit", "Edit", new { id=Model.UserID }) %> |
        <%= Html.ActionLink("Delete", "Delete",new{id=Model.UserID}) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>

</asp:Content>

