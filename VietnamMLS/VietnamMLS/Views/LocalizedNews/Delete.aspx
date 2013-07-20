<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedNew>" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
 <script src="<%=Url.Content("~/Content/fckeditor.js") %>" type="text/javascript"></script>
    <script type="text/javascript">
        window.onload = function() {
            var sBasePath = '<%= Url.Content("~/fckeditor/") %>';
            var oFCKeditor = new FCKeditor('FckEditor1');
            oFCKeditor.BasePath = sBasePath;
            oFCKeditor.Width = "690";
            oFCKeditor.Height = "700";
            oFCKeditor.ReplaceTextarea();
        }
    </script>
    
    <h4>Are you sure you want to delete this?</h4>
    
    <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.NewsID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Language</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.LanguageReference.CreateSourceQuery().First().Name) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.Title) %>
                    </td>
                </tr>
                                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEOUrl</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.SEOUrl) %>
                    </td>
                </tr>
                
                <%--<tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEOKeyword</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.SEOKeyword) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEODescription</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.SEODescription) %>
                    </td>
                </tr>--%>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Tags</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.Tags) %>
                    </td>
                </tr>                
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Full Content</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <%= Html.TextArea("FckEditor1",Model.FullContent,new { @name="FckEditor1"})%>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <% using (Html.BeginForm()) { %>
                           <p> <input type="submit" value="Delete" /> | <%= Html.ActionLink("Back to List", "Index") %></p>
                        <% } %>
                    </td>
                </tr>                
        </table>
    <%--<fieldset>
        <legend>Fields</legend>
        
        <div class="display-label">NewsID</div>
        <div class="display-field"><%= Html.Encode(Model.NewsID) %></div>
        
        <div class="display-label">LanguageID</div>
        <div class="display-field"><%= Html.Encode(Model.LanguageID) %></div>
        
        <div class="display-label">Title</div>
        <div class="display-field"><%= Html.Encode(Model.Title) %></div>
        
        <div class="display-label">FullContent</div>
        <div class="display-field"><%= Html.Encode(Model.FullContent) %></div>
        
        <div class="display-label">SEOUrl</div>
        <div class="display-field"><%= Html.Encode(Model.SEOUrl) %></div>
        
        <div class="display-label">SEOKeyword</div>
        <div class="display-field"><%= Html.Encode(Model.SEOKeyword) %></div>
        
        <div class="display-label">SEODescription</div>
        <div class="display-field"><%= Html.Encode(Model.SEODescription) %></div>
        
        <div class="display-label">Tags</div>
        <div class="display-field"><%= Html.Encode(Model.Tags) %></div>
        
    </fieldset>--%>
</asp:Content>

