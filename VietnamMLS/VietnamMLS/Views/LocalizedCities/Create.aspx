<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCity>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
<%--    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.Label("Language") %>
            </div>
            <div class="editor-field">
                <%= Html.DropDownListFor(model=>model.LanguageID,ViewData["lg"] as SelectList) %>
                <%= Html.ValidationMessageFor(model => model.LanguageID) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.City.Description) %>
            </div>
            <div class="editor-field">
                <%= Html.DropDownListFor(model=>model.CityID,ViewData["ct"] as SelectList) %>
                <%= Html.ValidationMessageFor(model => model.CityID) %>
            </div>
            
            
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Name) %>
                <%= Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <<%--div class="editor-label">
                <%= Html.LabelFor(model => model.SEOUrl) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOUrl) %>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
            </div>--%>
            
 <%--              <div class="editor-label">
                <%= Html.LabelFor(model => model.SEOKeyword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEODescription) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
            </div>
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>--%>


    <% using (Html.BeginForm())
       {%>
        <%= Html.ValidationSummary(true)%>
        
<table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        Language :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("LanguageID", (IEnumerable<SelectListItem>)ViewData["lg"], new { style = "width:152px;height:25px" })%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        Description :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownList("CityID", (IEnumerable<SelectListItem>)ViewData["ct"], new { style = "width:152px;height:25px" })%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        Name :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Name)%>
                        <%= Html.ValidationMessageFor(model => model.Name)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEOUrl :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEOUrl)%>
                        <%= Html.ValidationMessageFor(model => model.SEOUrl)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEOKeyword :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEOKeyword)%>
                        <%= Html.ValidationMessageFor(model => model.SEOKeyword)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEODescription :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEODescription)%>
                        <%= Html.ValidationMessageFor(model => model.SEODescription)%>
                    </td>
                </tr>
            </table>
            <p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>
    <% } %>












</asp:Content>

