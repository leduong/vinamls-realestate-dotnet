<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Category>" %>
<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form2" runat="server" enctype="multipart/form-data">

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        CategoryID :</td>
                    <td style="height: 30px">
                        <%=Model.CategoryID %>
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
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        Default Image :</td>
                    <td style="height: 30px">
                        <%= Html.Image("/Content/Images/Categories/" + Model.DefaultImage, "No Image", new { width = 50, height = 50 })%>
                        <input id="file2" name="file1" type="file" />
                    </td>
                </tr>
                 <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Sort Order :</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SortOrder) %>
                          <%= Html.ValidationMessageFor(model => model.SortOrder) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Parent Category :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("ParentCategoryID", (IEnumerable<SelectListItem>)ViewData["ParentCategoriesToEdit"], new { style = "width:152px;height:25px" })%>
                        
                </tr>
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %>
</form>
</asp:Content>

