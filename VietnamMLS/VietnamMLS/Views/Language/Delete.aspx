<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Language>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   
    
    
    <h2>Are you sure to delete this language?</h2>
    <div>
        <p>
            <ul>
                <li>
                    Category Information:<br /><br />
                    <ul>
                        <li>LanguageID : <%=Html.Encode(Model.LanguageID) %> </li> <br />
                        <li>LanguageCode : <%=Html.Encode(Model.LanguageCode) %> </li><br />
                        <li>Name : <%=Html.Encode(Model.Name) %> </li><br />
                        <li>Flag : <%=Html.Encode(Model.Flag) %> </li><br />
                        <li>IsUsed : <%=Html.Encode(Model.IsUsed) %> </li><br />                     
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

