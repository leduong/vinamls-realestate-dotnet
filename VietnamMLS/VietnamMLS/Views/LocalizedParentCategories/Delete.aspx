<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedParentCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Are you sure to delete this ?</h2>
    <div>
        <p>
            <ul>
                <li>
                    Localized Parent Category Information:<br /><br />
                    <ul>
                        <li>ParentCategoryID : <%=Html.Encode(Model.ParentCategoryID) %> </li> <br />
                        <li>LanguageID : <%=Html.Encode(Model.LanguageID)%> </li><br />
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

