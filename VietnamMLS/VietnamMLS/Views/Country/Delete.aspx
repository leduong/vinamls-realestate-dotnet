<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Country>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Are you sure to delete this country?</h2>
    <div>
        <p>
            <ul>
                <li>
                    Country Information:<br /><br />
                    <ul>
                        <li>CountryID : <%=Html.Encode(Model.CountryID) %> </li> <br />
                        <li>Name : <%=Html.Encode(Model.Name) %> </li><br />
                        <li>IsUsed : <%=Html.Encode(Model.IsUsed) %> </li><br />
                        
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

