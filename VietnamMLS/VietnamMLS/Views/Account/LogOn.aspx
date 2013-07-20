<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LogOnModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        Please enter your username and password. <%= Html.ActionLink("Register", "Register", null, new { style = "font-weight:bold" })%> 
        if you don't have an account.
    </p>

    <% using (Html.BeginForm()) { %>
        <%--<%= Html.ValidationSummary(true, "Login was unsuccessful. Please correct the errors and try again.") %>--%>
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
                          <%= Html.LabelFor(m => m.Password) %></td>
                    <td style="height: 30px">
                          <%= Html.PasswordFor(m => m.Password) %>
                          <%= Html.ValidationMessageFor(m => m.Password) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                          <%= Html.CheckBoxFor(m => m.RememberMe) %></td>
                    <td style="height: 30px">
                          <%= Html.LabelFor(m => m.RememberMe) %></td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                          &nbsp;</td>
                    <td style="height: 30px">
                           <input type="submit" value="Log On" /></td>
                </tr>
                </table>
        
        
           <%-- <fieldset>
                <legend>Account Information                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.UserName) %>
                </div>
                <div class="editor-field">
                    <%= Html.TextBoxFor(m => m.UserName) %>
                    <%= Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.LabelFor(m => m.Password) %>
                </div>
                <div class="editor-field">
                    <%= Html.PasswordFor(m => m.Password) %>
                    <%= Html.ValidationMessageFor(m => m.Password) %>
                </div>
                
                <div class="editor-label">
                    <%= Html.CheckBoxFor(m => m.RememberMe) %>
                    <%= Html.LabelFor(m => m.RememberMe) %>
                </div>
                
                
            </fieldset>
            <p>
                    <input type="submit" value="Log On" />
                </p>--%>
        </div>
    <% } %>
</asp:Content>
