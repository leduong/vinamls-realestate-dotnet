<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.City>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        CategoryID :</td>
                    <td style="height: 30px">
                        <%=Model.CityID %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Description :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Description) %>
                         <%= Html.ValidationMessageFor(model => model.Description) %>
                    </td>
                </tr>          
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Country :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("CountryID", (IEnumerable<SelectListItem>)ViewData["CountryToEdit"], new { style = "width:152px;height:25px" })%>
                        
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %>
</asp:Content>

