<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.PromotedNew>" %>
<script runat="server">
    VietnamMLS.Models.VietnamMLSEntities entities = new VietnamMLS.Models.VietnamMLSEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        string Title=(from p in entities.PromotedNews 
                     join n in entities.News on p.NewsID equals n.NewsId
                     join l in entities.LocalizedNews on n.NewsId equals l.NewsID
                     where l.LanguageID==1 && p.NewsID==Model.NewsID
                     select new{l.Title}).First().Title;
        lblTitle.Text = Title;
    }
    </script>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<form id="form1" runat="server">
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
        
        <table cellpadding="0" cellspacing="0" style="width: 637px" align="left">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        News</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.TextBox("txtNewsID",Model.NewsID,new{disabled=true}) %>
                       <%= Html.ValidationMessageFor(model => model.NewsID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <asp:TextBox ID="lblTitle" runat="server" Text="" ReadOnly="true" Width="432px"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        StartedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("StartedDate")
                        .Value(DateTime.Today.Date) %>
                        <%= Html.ValidationMessageFor(model => model.StartedDate) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        EndedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("EndedDate")
                        .Value(DateTime.Today.Date)%>
                        <%= Html.ValidationMessageFor(model => model.EndedDate) %>                        
                        <%= Html.Encode(ViewData["InvalidDate"])%>
                    </td>
                </tr>
                                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Description</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtDescription",Model.Description) %>
                        <%= Html.ValidationMessageFor(model => model.Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsUsed</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.CheckBox("chkIsUsed",Model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        LevelID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.TextBox("txtLevelID",Model.LevelID) %>
                        <%= Html.ValidationMessageFor(model => model.LevelID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                    <p>
                        <input type="submit" value="Save" /> | <%= Html.ActionLink("Back to List", "Index") %>
                    </p>
                        </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <h4><%= Html.Encode(ViewData["EditingMessage"])%></h4>
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
                <%= Html.LabelFor(model => model.StartedDate) %>
            </div>
            <div class="editor-field">
                 <%= Html.Telerik().DatePicker()
                        .Name("StartedDate")
                        .Value(DateTime.Today.Date)
                %>
                <%= Html.ValidationMessageFor(model => model.StartedDate) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.EndedDate) %>
            </div>
            <div class="editor-field">
                <%= Html.Telerik().DatePicker()
                        .Name("EndedDate")
                        .Value(DateTime.Today.Date)
                %>
                <%= Html.ValidationMessageFor(model => model.EndedDate) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.Description) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.Description) %>
                <%= Html.ValidationMessageFor(model => model.Description) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.IsUsed) %>
            </div>
            <div class="editor-field">
                <%= Html.CheckBoxFor(model => model.IsUsed) %>
                <%= Html.ValidationMessageFor(model => model.IsUsed) %>
            </div>
            
            <div class="editor-label">
                <%= Html.LabelFor(model => model.LevelID) %>
            </div>
            <div class="editor-field">
                <%= Html.TextBoxFor(model => model.LevelID) %>
                <%= Html.ValidationMessageFor(model => model.LevelID) %>
            </div>
            
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>--%>

    <% } %>
    </form>
</asp:Content>

