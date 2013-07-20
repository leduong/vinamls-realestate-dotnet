<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    

    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label" style="color:Blue" >CategoryID: </div>
        <div class="display-field"><%= Html.Encode(Model.CategoryID) %></div>
        
        <div class="display-label" style="color:Blue">LanguageID: </div>
        <div class="display-field"><%= Html.Encode(Model.LanguageID) %></div>
        
        <div class="display-label" style="color:Blue">Name: </div>
        <div class="display-field"><%= Html.Encode(Model.Name) %></div>
        
        <div class="display-label" style="color:Blue">SEOUrl: </div>
        <div class="display-field"><%= Html.Encode(Model.SEOUrl) %></div>
        
        <div class="display-label" style="color:Blue">SEOKeyword: </div>
        <div class="display-field"><%= Html.Encode(Model.SEOKeyword) %></div>
        
        <div class="display-label" style="color:Blue">SEODescription: </div>
        <div class="display-field"><%= Html.Encode(Model.SEODescription) %></div>
        
    </fieldset>
    <% using (Html.BeginForm()) { %>
        <p>
		    <input type="submit" value="Delete" /> |
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>

</asp:Content>

