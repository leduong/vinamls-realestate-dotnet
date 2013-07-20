<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.LocalizedNew>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>
<script runat="server">
    VietnamMLS.Models.VietnamMLSEntities entities = new VietnamMLS.Models.VietnamMLSEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Model.FullContent;
    }
</script>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
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
                    <td style="width: 105px; height:30px;font-weight:bold" align="left" 
                        valign="top">
                        Full Content</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                    </td>
                </tr>
                <tr>
                    <td style="height:30px" align="left" 
                        valign="top" colspan="3">
                            <asp:Label ID="Label1" runat="server" Text="Label" Width="629px" BorderWidth="1px"></asp:Label>
                    </td>
                </tr>
                
            </table>    
    <p>
        <%= Html.ActionLink("Edit", "Edit", new { newsid=Model.NewsID,langid=Model.LanguageID }) %> |
        <%= Html.ActionLink("Delete", "Delete", new { newsid=Model.NewsID,langid=Model.LanguageID }) %> |
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>

    </form>

</asp:Content>

