<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
            <table cellpadding="0" cellspacing="0" style="width: 637px">
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.Label("CategoryName") %></td>
                    <td style="height: 30px">
                        <%= Html.DropDownListFor(model => model.CategoryID,ViewData["CategoriesToCreate"] as SelectList) %>
                        <%= Html.ValidationMessageFor(model => model.CategoryID) %>
                    </td>
                </tr>            
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.Label("LanguageName") %></td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.DropDownListFor(model => model.LanguageID,ViewData["LanguagesToCreate"] as SelectList) %>
                        <%= Html.ValidationMessageFor(model => model.LanguageID) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                         <%= Html.LabelFor(model => model.Name) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Name) %>
                        <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                         <%= Html.LabelFor(model => model.SEOUrl) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEOUrl) %>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                         <%= Html.LabelFor(model => model.SEOKeyword) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        <%= Html.LabelFor(model => model.SEODescription) %></td>
                    <td style="height: 30px">
                       <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
                    </td>
                </tr>
            </table>


        <%--<fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label" style="color:Blue">
                
                
            </div>
            <div class="editor-field">
                
                
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.Label("LanguageName") %>
            </div>
            <div class="editor-field">
                <%= Html.DropDownListFor(model => model.LanguageID,ViewData["LanguagesToCreate"] as SelectList) %>
                <%= Html.ValidationMessageFor(model => model.LanguageID) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Name) %>
                <%= Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEOUrl) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOUrl) %>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEOKeyword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEODescription) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
            </div>
            
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>--%>
        <%=ViewData["MessageEro"] %>
<p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>
    <% } %>

</asp:Content>

