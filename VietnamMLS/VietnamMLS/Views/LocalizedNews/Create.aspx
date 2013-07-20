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
            oFCKeditor.Width = "680";
            oFCKeditor.Height = "700";
            oFCKeditor.ReplaceTextarea();
        }
    </script>
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>

            <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                        <%if (System.Web.HttpContext.Current.Request.RawUrl.Substring(System.Web.HttpContext.Current.Request.RawUrl.LastIndexOf("/") + 1).ToString().ToLower()!="create")
                          {%>
                          <td style="height: 30px">
                                <%= Html.TextBox("txtNewsID",System.Web.HttpContext.Current.Request.RawUrl.Substring(System.Web.HttpContext.Current.Request.RawUrl.LastIndexOf("/") + 1).ToString(),new{disabled=true })%>
                                <%= Html.ValidationMessageFor(model => model.NewsID)%>
                            </td>
                            <%}else{ %>
                                <td style="height: 30px">
                                <%= Html.DropDownListFor(model => model.NewsID, ViewData["NewsID"] as SelectList)%>
                                <%= Html.ValidationMessageFor(model => model.NewsID)%>
                            </td>
                            <%}%>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Language</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.DropDownListFor(model => model.LanguageID,ViewData["LangID"] as SelectList) %>
                        <%= Html.ValidationMessageFor(model => model.LanguageID) %>
                        <%= Html.Encode(ViewData["LanguageDuplicateMessage"])%>
                    </td>
                </tr>                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Title) %>
                        <%= Html.ValidationMessageFor(model => model.Title) %>
                        <%= Html.Encode(ViewData["NullMessage"])%>
                        <%= Html.Encode(ViewData["TitleDuplicateMessage"])%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Tags</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBoxFor(model => model.Tags) %>
                        <%= Html.ValidationMessageFor(model => model.Tags) %>
                    </td>
                </tr>                
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right" 
                        valign="top">
                        Full Content</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" 
                        valign="top" colspan="3">
                        <%= Html.TextArea("FckEditor1","")%>
                        <%= Html.ValidationMessageFor(model => model.FullContent) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <p>
                           <input type="submit" value="Create" /> | 
                           <%= Html.ActionLink("Back to List", "Index") %>
                            L&#432;u ý ph&#7843;i th&#7921;c hi&#7879;n: n&#7897;i dung bài vi&#7871;t xin vui lòng in &#273;&#7853;m &#273;o&#7841;n &#273;&#7847;u tiên (ho&#7863;c ý ch&#7911; &#273;&#7873; bài 
                            vi&#7871;t - quét kh&#7889;i text và ch&#7885;n B - Bold trên thanh công c&#7909; c&#7911;a text editor)</p>
                    </td>
                </tr>
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <h4><%= Html.Encode(ViewData["CreatingMessage"])%></h4>
                    </td>
                </tr>
            </table>
    <% } %>
</asp:Content>

