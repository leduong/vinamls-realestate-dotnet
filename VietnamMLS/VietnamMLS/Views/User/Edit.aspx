<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <% using (Html.BeginForm()) {%>
    <%= Html.ValidationSummary(true) %>
        <div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        User ID :</td>
                    <td style="height: 30px">
                        <%=Model.UserID %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Username :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Username) %>
                         <%= Html.ValidationMessageFor(model => model.Username) %>
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
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>

    <% } %>

</asp:Content>

