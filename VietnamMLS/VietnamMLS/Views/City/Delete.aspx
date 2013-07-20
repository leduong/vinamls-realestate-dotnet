<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.City>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Are you sure to delete this city?</h2>
    <div>
        <p>
            <ul>
                <li>
                    City Information:<br /><br />
                    <ul><table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        CityID :</td>
                    <td style="height: 30px">
                        <%=Html.Encode(Model.CityID) %>
                    </td>
                </tr>     
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Description :</td>
                    <td style="height: 30px">
                        <%=Html.Encode(Model.Description) %>
                    </td>
                </tr>            
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Country :</td>
                    <td style="height: 30px;padding-left:3px">
                        <%=Html.Encode(Model.CountryReference.CreateSourceQuery().First().Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed)%>                        
                    </td>
                </tr>
            </table>                        
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

