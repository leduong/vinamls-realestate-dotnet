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
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%=Html.TextBoxFor(model=>model.NewsID,new{disabled=true}) %>
                       <%--<%= Html.TextBox("NewsID",Model.NewsID,new{disabled=true}) %>--%>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Language</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model=>model.LanguageReference.CreateSourceQuery().First().Name,new{disabled=true}) %>
                        <%--<%= Html.TextBox("Language",Model.LanguageReference.CreateSourceQuery().First().Name,new{disabled=true}) %>--%>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtTitle", Model.Title, new { style = "width:500px" })%>
                        <%= Html.Encode(ViewData["NullMessage"])%>
                        <%= Html.Encode(ViewData["DuplicateMessage"])%>
                       <%-- <%= Html.ValidationMessageFor(model => model.Title) %>--%>
                    </td>
                </tr>
                                
               <%-- <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEOUrl</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtSEOUrl", Model.SEOUrl, new { style = "width:300px" })%>
                        <%= Html.TextBoxFor(model=>model.SEOUrl) %>
                        <%= Html.Encode(ViewData["NullMessage"])%>
                        <%= Html.Encode(ViewData["DuplicateMessage"])%>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEOKeyword</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtSEOKeyword",Model.SEOKeyword, new { style = "width:300px" })%>
                        <%= Html.TextBoxFor(model=>model.SEOKeyword) %>
                        <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        SEODescription</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtSEODescription", Model.SEODescription, new { style = "width:300px" })%>
                        <%= Html.TextBoxFor(model=>model.SEODescription) %>
                        <%= Html.ValidationMessageFor(model => model.SEODescription) %>
                    </td>
                </tr>--%>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Tags</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtTags", Model.Tags)%>
                        <%--<%= Html.TextBoxFor(model=>model.Tags) %>--%>
                        <%= Html.ValidationMessageFor(model => model.Tags) %>
                    </td>
                </tr>                
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Full Content</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        &nbsp;</td>
                </tr>                
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="right" colspan="3">
                        <%= Html.TextArea("FckEditor1",Model.FullContent)%>
                        <%= Html.ValidationMessageFor(model => model.FullContent) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" valign="top" colspan="3">
                    <p>
                        <input type="submit" value="Save" /> | <%= Html.ActionLink("Back to List", "Index") %>
                            L&#432;u ý ph&#7843;i th&#7921;c hi&#7879;n: n&#7897;i dung bài vi&#7871;t xin vui lòng in &#273;&#7853;m &#273;o&#7841;n &#273;&#7847;u tiên (ho&#7863;c ý ch&#7911; &#273;&#7873; bài 
                            vi&#7871;t - quét kh&#7889;i text và ch&#7885;n B - Bold trên thanh công c&#7909; c&#7911;a text editor)</p>
                    </td>
                </tr>
                
                                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        &nbsp;</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <h5><%= Html.Encode(ViewData["EditingMessage"])%></h5>
                    </td>
                </tr>
            </table>
        
        <%--<fieldset>
            <legend>Fields</legend>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.NewsID) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.NewsID) %>
                <%= Html.ValidationMessageFor(model => model.NewsID) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.LanguageID) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.LanguageReference.CreateSourceQuery().First().Name) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Title) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("txtTitle",Model.Title) %>
                <%= Html.ValidationMessageFor(model => model.Title) %>
            </div>            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.FullContent) %>
            </div>            
            <div class="editor-field">
                <%= Html.TextArea("FckEditor1",Model.FullContent)%>
                <%= Html.ValidationMessageFor(model => model.FullContent) %>
            </div>
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEOUrl) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("txtSEOUrl",Model.SEOUrl)%>
                <%= Html.ValidationMessageFor(model => model.SEOUrl) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEOKeyword) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("txtSEOKeyword",Model.SEOKeyword)%>
                <%= Html.ValidationMessageFor(model => model.SEOKeyword) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.SEODescription) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("txtSEODescription", Model.SEODescription)%>
                <%= Html.ValidationMessageFor(model => model.SEODescription) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Tags) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBox("txtTags", Model.Tags)%>
                <%= Html.ValidationMessageFor(model => model.Tags) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>--%>
    <% } %>  

</asp:Content>

