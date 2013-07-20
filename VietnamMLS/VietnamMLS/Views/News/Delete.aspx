<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.News>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Delete
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Delete News</h2>

    <h4>Are you sure you want to delete this News?</h4>
    <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.NewsId) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        User</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.UserReference.CreateSourceQuery().First().Username) %> 
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        ParentCategory</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.ParentCategoryReference.CreateSourceQuery().First().Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Category</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.CategoryReference.CreateSourceQuery().First().Description) %> 
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        City</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.CityReference.CreateSourceQuery().First().Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        CreatedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.CreatedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        PostedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.PostedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        MainImage</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.MainImage) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsApproved </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.Encode(Model.IsApproved) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <input type="submit" value="Delete" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        &nbsp;</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <h5><%= Html.Encode(ViewData["DeletingMessage"])%></h5>
                    </td>
                </tr>
            </table>
    <%--<fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">NewsId</div>
        <div class="display-field"><%= Html.Encode(Model.NewsId) %></div>
        
        <div class="display-label">PostedDate</div>
        <div class="display-field"><%= Html.Encode(String.Format("{0:g}", Model.PostedDate)) %></div>
        
        <div class="display-label">IsApproved</div>
        <div class="display-field"><%= Html.Encode(Model.IsApproved) %></div>
        
        <div class="display-label">MainImage</div>
        <div class="display-field"><%= Html.Encode(Model.MainImage) %></div>
        
        <div class="display-label">CreatedDate</div>
        <div class="display-field"><%= Html.Encode(String.Format("{0:g}", Model.CreatedDate)) %></div>
        
    </fieldset>--%>
    <% using (Html.BeginForm()) { %>
        <p>
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>

</asp:Content>

