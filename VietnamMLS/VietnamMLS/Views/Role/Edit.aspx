<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Role>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% using (Html.BeginForm()) {%>
    <%= Html.ValidationSummary(true) %>
        <div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        RoleID :</td>
                    <td style="height: 30px">
                        <%=Model.RoleID %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        RoleName :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.RoleName) %>
                         <%= Html.ValidationMessageFor(model => model.RoleName) %>
                    </td>
                </tr>
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>

    <% } %>

</asp:Content>

