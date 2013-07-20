<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.ChangePasswordModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit</h2>

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <div>
        
            <table cellpadding="0" cellspacing="0" style="width: 403px">
                <tr>
                    <td style="width: 168px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(model => model.OldPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.OldPassword) %>
                        <%= Html.ValidationMessageFor(model => model.OldPassword) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 168px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(model => model.NewPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.NewPassword) %>
                        <%= Html.ValidationMessageFor(model => model.NewPassword) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 168px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(model => model.ConfirmPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.ConfirmPassword) %>
                        <%= Html.ValidationMessageFor(model => model.ConfirmPassword) %>
                    </td>
                </tr>
                <%if (HttpContext.Current.User.IsInRole("admin"))
                  {%>
                <tr>
                    <td style="width: 168px; height:30px;font-weight:bold;font-weight:bold">
                        <label for="roleName">Select Role:</label></td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("roleName")%>
                        <%= Html.ValidationMessage("roleName")%>
                    </td>
                </tr>
                 <%}%>
                <tr>
                    <td style="width: 168px; height:30px;font-weight:bold">
                        </td>
                    <td style="height: 30px;padding-left:3px">
                        <input type="submit" value="Save" />|<%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%></td>
                </tr>
            </table>
            
        </div>
        
        <%--<fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.OldPassword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.OldPassword) %>
                <%= Html.ValidationMessageFor(model => model.OldPassword) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.NewPassword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.NewPassword) %>
                <%= Html.ValidationMessageFor(model => model.NewPassword) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.ConfirmPassword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.ConfirmPassword) %>
                <%= Html.ValidationMessageFor(model => model.ConfirmPassword) %>
            </div>
            <div class="editor-field">
                <label for="roleName">Select Role:</label></td>
            </div>
            <div class="editor-field">
                <%= Html.DropDownList("roleName") %>
                <%= Html.ValidationMessage("roleName") %>
            </div>
            
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>--%>

    <% } %>

    <%--<div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>--%>

</asp:Content>

