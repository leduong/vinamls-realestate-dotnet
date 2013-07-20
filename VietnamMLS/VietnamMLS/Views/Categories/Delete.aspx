<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Category>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Are you sure to delete this category?</h2>
    <div>
        <p>
            <ul>
                <li>
                    Category Information:<br /><br />
                    <ul>
                        <li>CategoryID : <%=Html.Encode(Model.CategoryID) %> </li> <br />
                        <li>Description : <%=Html.Encode(Model.Description) %> </li><br />
                        <li>IsUsed : <%=Html.Encode(Model.IsUsed) %> </li><br />
                        <li>DefaultImage : <%=Html.Encode(Model.DefaultImage) %> </li><br />
                        <li>SortOrder : <%=Html.Encode(Model.SortOrder) %> </li><br />
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

