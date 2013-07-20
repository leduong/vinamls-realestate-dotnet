<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.ParentCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h3>Are you sure to delete this ParentCategory?</h3>
    <div>
        <p>
            <ul>
                <li>
                    ParentCategory Information:<br /><br />
                    <ul>
                        <%--<li>ParentCategoryID : <%=Html.Encode(Model.ParentCategoryID) %> </li>--%>
                        <li>Description : <%=Html.Encode(Model.Description) %> </li>
                        <li>IsUsed : <%=Html.Encode(Model.IsUsed) %> </li>
                        <li>SortOrder : <%=Html.Encode(Model.SortOrder) %> </li>
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

