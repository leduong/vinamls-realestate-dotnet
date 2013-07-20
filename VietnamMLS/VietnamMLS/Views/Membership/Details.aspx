<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.UserRoleRepository+AccountInfoModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Details</h2>

    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">UserId</div>
        <div class="display-field"><%= Html.Encode(Model.UserId) %></div>
        
        <div class="display-label">UserName</div>
        <div class="display-field"><%= Html.Encode(Model.UserName) %></div>
        
        <div class="display-label">Email</div>
        <div class="display-field"><%= Html.Encode(Model.Email) %></div>
        
        <div class="display-label">RoleName</div>
        <div class="display-field"><%= Html.Encode(Model.RoleName) %></div>
        
    </fieldset>
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { /* id=Model.PrimaryKey */ }) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>

</asp:Content>

