<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        Use the form below to create a new account. 
    </p>
   <%-- <p>
        Passwords are required to be a minimum of <%= Html.Encode(ViewData["PasswordLength"]) %> 
        characters in length.
    </p>--%>

    <% using (Html.BeginForm()) { %>
        <%--<%= Html.ValidationSummary(true, "Account creation was unsuccessful. Please correct the errors and try again.") %>--%>
        <div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(m => m.UserName) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(m => m.UserName) %>
                        <%= Html.ValidationMessageFor(m => m.UserName) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                         <%= Html.LabelFor(m => m.Email) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(m => m.Email) %>
                        <%= Html.ValidationMessageFor(m => m.Email) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.LabelFor(m => m.Password) %></td>
                    <td style="height: 30px">
                        <%= Html.PasswordFor(m => m.Password) %>
                        <%= Html.ValidationMessageFor(m => m.Password) %></td>
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
                        <label for="roleName">Select Role:</label></td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("roleName") %>
                        <%= Html.ValidationMessage("roleName") %></td>
                </tr>

                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <input type="submit" value="Register" /></td>
                </tr>

            </table>
        
        
        
            <%--<fieldset>
                <legend>Account Information</legend>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.UserName) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.UserName) %>
                    <%= Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Email) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.Email) %>
                    <%= Html.ValidationMessageFor(m => m.Email) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Password) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.Password) %>
                    <%= Html.ValidationMessageFor(m => m.Password) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.ConfirmPassword) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.ConfirmPassword) %>
                    <%= Html.ValidationMessageFor(m => m.ConfirmPassword) %>
                </div>
                <div>
                    <label for="roleName">Select Role:</label>
                    <%= Html.DropDownList("roleName") %>
                    <%= Html.ValidationMessage("roleName") %>
                </div>
                <p>
                    <input type="submit" value="Register" />
                </p>
            </fieldset>--%>
        </div>
    <% } %>
</asp:Content>
