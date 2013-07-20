<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Language>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <form id="form1" runat="server" enctype="multipart/form-data">

    <% using (Html.BeginForm())
       {%>
        <%= Html.ValidationSummary(true)%>
        
<table cellpadding="0" cellspacing="0" style="width: 637px">
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        LanguageCode :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.LanguageCode) %>
                        <%= Html.ValidationMessageFor(model => model.LanguageCode) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Name :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Name) %>
                        <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Flag :</td>
                    <td style="height: 30px">
                        <input type="file" id="file3" name="file1" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed)%>
                        <%= Html.ValidationMessageFor(model => model.IsUsed)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Sort Order :</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SortOrder)%>
                        <%= Html.ValidationMessageFor(model => model.SortOrder)%>
                    </td>
                </tr>
                
            </table>
            <p>
                <input type="submit" value="Create" />  |  <%= Html.ActionLink("Back to List", "Index") %>
            </p>
    <% } %>
    </form>

</asp:Content>

