<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedParentCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        ParentCategoryID:</td>
                    <td style="height: 30px">
                        <%=Model.ParentCategoryID%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        ParentCateName:</td>
                    <td style="height: 30px">
                         <%= Model.ParentCategoryReference.CreateSourceQuery().First().Description %>
                       
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        LanguageID:</td>
                    <td style="height: 30px">
                        <%=Model.LanguageID%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        LanguageName:</td>
                    <td style="height: 30px">
                        <%= Model.LanguageReference.CreateSourceQuery().First().Name %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        Name:</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.Name) %>
                          <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEOUrl:</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SEOUrl)%>
                          <%= Html.ValidationMessageFor(model => model.SEOUrl)%>
                    </td>
                </tr>
                 <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEOKeyword:</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SEOKeyword)%>
                          <%= Html.ValidationMessageFor(model => model.SEOKeyword)%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        SEODescription:</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SEODescription)%>
                          <%= Html.ValidationMessageFor(model => model.SEODescription)%>
                    </td>
                </tr>
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %>
</asp:Content>

