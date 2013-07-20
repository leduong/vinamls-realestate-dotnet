<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.News>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edit
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form2" runat="server" enctype="multipart/form-data">
    <h2>Edit News</h2>

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.TextBox("txtNewsID",Model.NewsId,new{disabled=true}) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        ParentCategory</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("ParentID",ViewData["ParentIDs"] as SelectList) %>
                        <%= Html.ValidationMessageFor(model => model.ParentCategory.ParentCategoryID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Category</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("CateID",ViewData["CateIDs"] as SelectList )%>
                        <%= Html.ValidationMessageFor(model => model.Category.CategoryID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        City</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("CityID",ViewData["CityIDs"] as SelectList )%>
                        <%= Html.ValidationMessageFor(model => model.City.CityID) %>
                    </td>
                </tr>
                
                <%if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                  { %>
                <%--<tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        CreatedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("CreatedDate")
                        .Value(DateTime.Today.Date)%>
                        <%= Html.ValidationMessageFor(model => model.CreatedDate)%>
                    </td>
                </tr>--%>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        PostedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("PostedDate")
                        .Value(DateTime.Today.Date)%>
                        <%= Html.ValidationMessageFor(model => model.PostedDate)%>
                        <%= Html.Encode(ViewData["InvalidDate"])%>
                    </td>
                </tr>
                <%} %>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        MainImage</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <input type="file" id="file2" name="file1" />
                    </td>
                </tr>
                <%if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                  { %>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsApproved </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <%--<%= Html.CheckBox("chkIsApproved",Model.IsApproved) %>--%>
                        <%= Html.CheckBoxFor(model => model.IsApproved)%>
                        <%= Html.ValidationMessageFor(model => model.IsApproved)%>
                    </td>
                </tr>
                <%} %>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <input type="submit" value="Save" /> | <%= Html.ActionLink("Back to List", "Index") %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        &nbsp;</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <h5><%= Html.Encode(ViewData["EditingMessage"])%></h5>
                    </td>
                </tr>
            </table>
    <% } %>
</form>
</asp:Content>

