<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.CitiesInHome>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.City.Description) %>
            </div>
            <div class="editor-field">
                <%= Model.CityReference.CreateSourceQuery().First().Description %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.IsDefault) %>
            </div>
            <div class="editor-field">
                <%= Html.CheckBoxFor(model => model.IsDefault) %>
                <%= Html.ValidationMessageFor(model => model.IsDefault) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SortOrder) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SortOrder) %>
                <%= Html.ValidationMessageFor(model => model.SortOrder) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>

</asp:Content>

