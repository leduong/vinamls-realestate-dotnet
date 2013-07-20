<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.ParentCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
            <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        City:</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("CityID", (IEnumerable<SelectListItem>)ViewData["CitiesToEdit"], new { style = "width:152px;height:25px" })%> 
                        <%= Html.ValidationMessageFor(model => model.CityReference.EntityKey.EntityKeyValues.First().Value) %>
                        
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        ParentCategoryID:</td>
                    <td style="height: 30px">
                        <%=Model.ParentCategoryID%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Description:</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Description) %>
                         <%= Html.ValidationMessageFor(model => model.Description) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        IsUsed:</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Sort Order:</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SortOrder) %>
                          <%= Html.ValidationMessageFor(model => model.SortOrder) %>
                    </td>
                </tr>
                 
                
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %>
</asp:Content>

