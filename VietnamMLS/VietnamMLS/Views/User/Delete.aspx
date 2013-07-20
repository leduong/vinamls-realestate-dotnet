<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.User>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Are you sure to delete this user?</h2>
    <div>
        <p>
            <ul>
                <li>
                    User Information:<br /><br />
                    <ul>
                        <li>ID : <%=Html.Encode(Model.UserID) %> </li> <br />
                        <li>Username : <%=Html.Encode(Model.Username) %> </li><br />
                    </ul>
                </li>
            </ul>
        </p>
    </div>
    <%using (Html.BeginForm())
      { %>
      <div>
        <input name="deleteButton" type="submit" value="Delete" />  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
      </div>
      
    <%} %>

</asp:Content>
