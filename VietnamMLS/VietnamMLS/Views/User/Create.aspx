<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        
    
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>

            <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Username :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Username) %>
                         <%= Html.ValidationMessageFor(model => model.Username) %>
                         <%= Html.Encode(ViewData["duplicateMessage"])%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Password :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Password) %>
                        <%= Html.ValidationMessageFor(model => model.Password) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        Email :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Email) %>
                        <%= Html.ValidationMessageFor(model => model.Email) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Role assigned :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("RoleID", (IEnumerable<SelectListItem>)ViewData["UserRoleList"], new { style = "width:152px;height:25px" })%>
                        <%= Html.ValidationMessageFor(model => model.RoleReference.EntityKey.EntityKeyValues.First().Value) %></td>
                </tr>
            </table>
            <p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>
        <%--<fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.UserID) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.UserID) %>
                <%= Html.ValidationMessageFor(model => model.UserID) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Username) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Username) %>
                <%= Html.ValidationMessageFor(model => model.Username) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Password) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Password) %>
                <%= Html.ValidationMessageFor(model => model.Password) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Email) %>
                <%= Html.ValidationMessageFor(model => model.Email) %>
            </div>
            
            
        </fieldset>--%>

    <% } %>

    <div>
        
    </div>

</asp:Content>

