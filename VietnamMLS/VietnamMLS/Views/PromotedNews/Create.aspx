<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.PromotedNew>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>

        <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        News</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.DropDownListFor(model => model.NewsID,ViewData["NewsID"] as SelectList) %>
                       <%= Html.ValidationMessageFor(model => model.NewsID) %>
                       <%= Html.Encode(ViewData["DuplicateMessage"])%>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        StartedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("StartedDate")
                        .Value(DateTime.Today.Date) %>
                        <%= Html.ValidationMessageFor(model => model.StartedDate) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        EndedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("EndedDate")
                        .Value(DateTime.Today.Date)%>
                        <%= Html.ValidationMessageFor(model => model.EndedDate) %>                        
                        <%= Html.Encode(ViewData["InvalidDate"])%>
                    </td>
                </tr>
                                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Description</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Description) %>
                        <%= Html.ValidationMessageFor(model => model.Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsUsed</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        LevelID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.LevelID) %>
                        <%= Html.ValidationMessageFor(model => model.LevelID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                    <strong>
                        <input type="submit" value="Create" /> | <%= Html.ActionLink("Back to List", "Index") %>     
                        </strong>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        &nbsp;</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <h3><%= Html.Encode(ViewData["CreatingMessage"])%></h3>
                    </td>
                </tr>
            </table>
    <% } %>
</asp:Content>

