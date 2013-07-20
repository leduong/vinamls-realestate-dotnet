<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.UserRoleRepository+AccountInfoModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Delete
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Are you sure to delete this user?</h2>
    <div>
        <p>
            <ul>
                <li>
                    User Information:<br /><br />
                    <ul>
                        <li>Username : <%= Html.Encode(Model.UserName) %> </li><br />
                    </ul>
                </li>
            </ul>
        </p>
    </div>
    <% using (Html.BeginForm()) { %>
        <p>
		    <input type="submit" value="Delete" /> |
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>--%>

    <%--<h2>Delete</h2>

    <h3>Are you sure you want to delete this?</h3>
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
    <% using (Html.BeginForm()) { %>
        <p>
		    <input type="submit" value="Delete" /> |
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>--%>

</asp:Content>

