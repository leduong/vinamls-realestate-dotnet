<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.ChangePasswordModel>" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
 
</asp:Content>

<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        Use the form below to change your password. 
    </p>
    <%--<p>
        New passwords are required to be a minimum of <%= Html.Encode(ViewData["PasswordLength"]) %> characters in length.
    </p>--%>

    <% using (Html.BeginForm()) { %>
        <%--<%= Html.ValidationSummary(true, "Password change was unsuccessful. Please correct the errors and try again.") %>--%>
        <div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(m => m.OldPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.PasswordFor(m => m.OldPassword) %>
                        <%= Html.ValidationMessageFor(m => m.OldPassword) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(m => m.NewPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.PasswordFor(m => m.NewPassword) %>
                        <%= Html.ValidationMessageFor(m => m.NewPassword) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(m => m.ConfirmPassword) %></td>
                    <td style="height: 30px">
                        <%= Html.PasswordFor(m => m.ConfirmPassword) %>
                        <%= Html.ValidationMessageFor(m => m.ConfirmPassword) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <input type="submit" value="Change Password" /></td>
                </tr>
            </table>
            
        
        
            <%--<fieldset>
                <legend>Account Information</legend>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.OldPassword) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.OldPassword) %>
                    <%= Html.ValidationMessageFor(m => m.OldPassword) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.NewPassword) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.NewPassword) %>
                    <%= Html.ValidationMessageFor(m => m.NewPassword) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.ConfirmPassword) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.ConfirmPassword) %>
                    <%= Html.ValidationMessageFor(m => m.ConfirmPassword) %>
                </div>
                
                <p>
                    <input type="submit" value="Change Password" />
                </p>
            </fieldset>--%>
        </div>
    <% } %>
</asp:Content>
