<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.UserRoleRepository+AccountInfoModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Username :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.UserName) %>
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
                <%= Html.Encode(Model.RoleName) %>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                &nbsp;</td>
            <td style="height: 30px;padding-left:3px">
            <%if (HttpContext.Current.User.Identity.Name == Model.UserName || HttpContext.Current.User.IsInRole("admin"))
              {%>
                <%= Html.ActionLink("Edit", "Edit", new { /* id=Model.PrimaryKey */ })%> |
                <%= Html.ActionLink("Back to List", "Index")%>
            <%}%></tr>
    </table>
    
    <%--<fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">UserId</div>
        <div class="display-field"><%= Html.Encode(Model.UserId) %></div>
        
        <div class="display-label">UserName</div>
        <div class="display-field"><%= Html.Encode(Model.UserName) %></div>
        
        <div class="display-label">Email</div>
        <div class="display-field"><%= Html.Encode(Model.Email) %></div>
        
        <div class="display-label">RoleName</div>
        <div class="display-field"><%= Html.Encode(Model.RoleName) %></div>
        
    </fieldset>--%>
    <%--<p>
        <%= Html.ActionLink("Edit", "Edit", new { /* id=Model.PrimaryKey */ }) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>--%>

</asp:Content>

