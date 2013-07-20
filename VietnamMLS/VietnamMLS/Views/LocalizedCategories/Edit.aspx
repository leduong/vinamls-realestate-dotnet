<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedCategory>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    

    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        <table cellpadding="0" cellspacing="0" style="width: 637px">
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.Label("Category") %></td>
                    <td style="height: 30px">
                        <%= Model.CategoryReference.CreateSourceQuery().First().Description  %>
                    </td>
                </tr>            
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        <%= Html.Label("LanguageName") %></td>
                    <td style="height: 30px;padding-left:3px">
                         <%= Model.LanguageReference.CreateSourceQuery().First().Name  %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                         <%= Html.LabelFor(model => model.Name) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Name) %>
                        <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                         <%= Html.LabelFor(model => model.SEOKeyword) %></td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold;font-weight:bold">
                        <%= Html.LabelFor(model => model.SEODescription) %></td>
                    <td style="height: 30px">
                       <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
                    </td>
                </tr>
            </table>

        <%--<fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.CategoryID) %>
            </div>
            <div class="editor-field">
                <%= Model.CategoryID  %>                
            </div>
            <div class="editor-label" style="color:Blue">
                <%= Html.Label("CategoryName") %>
            </div>
            <div class="editor-field">
                <%= Model.CategoryReference.CreateSourceQuery().First().Description  %>
            </div>
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.LanguageID) %>
            </div>
            <div class="editor-field">
                <%= Model.LanguageID %>
            </div>
                 <div class="editor-label" style="color:Blue">
                <%= Html.Label("LanguageName") %>
            </div>
            <div class="editor-field">
                <%= Model.LanguageReference.CreateSourceQuery().First().Name  %>
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Name) %>
                <%= Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEOUrl) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOUrl) %>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEOKeyword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEOKeyword) %>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
            </div>
            
            <div class="editor-label" style="color:Blue">
                <%= Html.LabelFor(model => model.SEODescription) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.SEODescription) %>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>--%>
            <p>
                <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %>

</asp:Content>

