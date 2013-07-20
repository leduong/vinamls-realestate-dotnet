<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.City>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form2" runat="server" enctype="multipart/form-data">

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>        
        <table cellpadding="0" cellspacing="0" style="width: 637px">
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Country :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("CountryID", (IEnumerable<SelectListItem>)ViewData["CountryToCreate"], new { style = "width:152px;height:25px" })%>
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
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed)%>
                        <%= Html.ValidationMessageFor(model => model.IsUsed)%>
                    </td>
                </tr>
            </table>
            <p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>  
    <% } %>

</form>
</asp:Content>

