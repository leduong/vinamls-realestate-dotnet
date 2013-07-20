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
<table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.NewsID) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        Title</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                    </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        StartedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.StartedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        EndedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.EndedDate)) %>
                    </td>
                </tr>
                                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        Description</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        IsUsed</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.CheckBox("Used",Model.IsUsed,new{disabled=true}) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="height:30px;font-weight:bold; text-align: left;" align="right">
                        LevelID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.LevelID) %>
                    </td>
                </tr>                
            </table>
         <p>

        <%= Html.ActionLink("Edit", "Edit", new { id=Model.NewsID }) %> |
        <%= Html.ActionLink("Delete", "Delete", new { id=Model.NewsID }) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>
</form>
</asp:Content>

