<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCity>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
<%--
    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">CityID: <%= Html.Encode(Model.CityID) %></div>
        
        <div class="display-label">LanguageID: <%= Html.Encode(Model.LanguageID) %></div>
        
        <div class="display-label">Name: <%= Html.Encode(Model.Name) %></div>
        
        <div class="display-label">SEOUrl: <%= Html.Encode(Model.SEOUrl) %></div>
        
        <div class="display-label">SEOKeyword: <%= Html.Encode(Model.SEOKeyword) %></div>
        
        <div class="display-label">SEODescription: <%= Html.Encode(Model.SEODescription) %></div>
        
    </fieldset>
    <% using (Html.BeginForm()) { %>
        <p>
		    <input type="submit" value="Delete" /> |
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>

--%>
<h2>Are you sure to delete this ?</h2>
    <div>
        <p>
            <ul>
                <li>
                    Localized City Information:<br /><br />
                    <ul>
                        <li>City : <%=Html.Encode(Model.CityReference.CreateSourceQuery().First().Description) %> </li> <br />
                        <li>Language : <%=Html.Encode(Model.LanguageReference.CreateSourceQuery().First().Name)%> </li><br />
                        <li>Name : <%=Html.Encode(Model.Name)%> </li><br />
                        <li>SEOUrl : <%=Html.Encode(Model.SEOUrl)%> </li><br />
                        <li>SEOKeyword : <%=Html.Encode(Model.SEOKeyword)%> </li><br />
                        <li>SEODescription : <%=Html.Encode(Model.SEODescription)%> </li><br />
                    </ul>
                </li>
            </ul>
        </p>
    </div>
    <% using (Html.BeginForm()) { %>
        <p>
		    <input type="submit" value="Delete" /> |
		    <%= Html.ActionLink("Back to List", "Index") %>
        </p>
    <% } %>

</asp:Content>

