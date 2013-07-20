<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCity>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%--    

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.City.Description) %>
            </div>
            <div class="editor-field">
                <%= Model.CityID %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Language.Name) %>
            </div>
            <div class="editor-field">
                <%= Model.LanguageID %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Name) %>
                <%= Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEOUrl) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOUrl) %>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEOKeyword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEODescription) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%= Html.ActionLink("Back to List", "Index") %>
    </div>
--%>






   <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        City:</td>
                    <td style="height: 30px">
                        <%=Model.CityReference.CreateSourceQuery().First().Description%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 110px; height:30px;font-weight:bold">
                        Language Name:</td>
                    <td style="height: 30px">
                        <%=Model.LanguageReference.CreateSourceQuery().First().Name%>
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

