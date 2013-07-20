<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Country>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
 
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        CountryID :</td>
                    <td style="height: 30px">
                        <%=Model.CountryID %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Description :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Name) %>
                         <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>

            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>

    <% } %>

</asp:Content>

