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
    <h4>Are you sure you want to delete this?</h4>
    
    <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.NewsID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                        <td style="width: 13px; height:30px;font-weight:bold">
                    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        StartedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.StartedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        EndedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.EndedDate)) %>
                    </td>
                </tr>
                                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Description</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsUsed</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.CheckBox("Used",Model.IsUsed,new{disabled=true}) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        LevelID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.LevelID) %>
                    </td>
                </tr> 
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                     <% using (Html.BeginForm()) { %>
                     <p>
                        <input type="submit" value="Delete" /> |
		                    <%= Html.ActionLink("Back to List", "Index") %>
                     </p>
                    <% } %>
                        </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                        <h4><%= Html.Encode(ViewData["DeletingMessage"])%></h4>
                    </td>
                </tr>
            </table>
    </form>
</asp:Content>

