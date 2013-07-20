<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Category>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form2" runat="server" enctype="multipart/form-data">
    <% using (Html.BeginForm())
       {%>
        <%= Html.ValidationSummary(true)%>
        
<table cellpadding="0" cellspacing="0" style="width: 637px">
                
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
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Default Image :</td>
                    <td style="height: 30px;padding-left:3px">
                        <input type="file" id="file2" name="file1" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Sort Order :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SortOrder)%>
                        <%= Html.ValidationMessageFor(model => model.SortOrder)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        ParentCategory :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("ParentCategoryID", (IEnumerable<SelectListItem>)ViewData["ParentCategoriesToCreate"], new { style = "width:152px;height:25px" })%>
                        </td>
                </tr>
            </table>
            <p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>
    <% } %>

    </form>
</asp:Content>

