<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.News>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>News Details</h2>

            <table cellpadding="0" cellspacing="0" style="width: 637px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        NewsID</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.NewsId) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        User</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                       <%= Html.Encode(Model.UserReference.CreateSourceQuery().First().Username) %> 
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        ParentCategory</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.ParentCategoryReference.CreateSourceQuery().First().Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        Category</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.CategoryReference.CreateSourceQuery().First().Description) %> 
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        City</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.CityReference.CreateSourceQuery().First().Description) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        CreatedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.CreatedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        PostedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(String.Format("{0:g}", Model.PostedDate)) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        MainImage</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Encode(Model.MainImage) %>
                    </td>
                </tr>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="left">
                        IsApproved </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">
                        <%= Html.CheckBox("Approved", Model.IsApproved, new { disabled = true })%>
                    </td>
                </tr>
                
                <tr>
                <table>
                    <td style="height:30px;font-weight:bold;color:Blue" align="left">
                    &nbsp;
                    <%= Html.ActionLink("Edit", "Edit", new { id = Model.NewsId }, new { style ="color:Blue" })%> |
                    <%= Html.ActionLink("Delete", "Delete", new { id = Model.NewsId }, new { style = "color:Blue" })%> |
                    <%= Html.ActionLink("Back to NewsList", "Index",null, new { style = "color:Blue" })%>
                    </td>
                </tr>
                </table>
            </table>
    <h3>Relative LocalizedNews of this News</h3>
    <%= Html.Telerik().Grid<VietnamMLS.Models.LocalizedNewsModel>()
        .Name("Grid")
        .DataKeys(key=>key.Add(ln=>ln.NewsID))
        .DataKeys(key => key.Add(ln => ln.LanguageID))
        .DataBinding(dataBingding =>
            {
                dataBingding.Ajax().Select("GetLocalizedNewsByNewsID","News").Enabled(true);
            })            
         .Columns(column=>
             {
                 column.Bound(c =>c.Title).Width(350);
                 column.Bound(c => c.LanguageName).Width(80).Title("Language");
                 column.Bound(c => c.SEOUrl).Width(150).Title("Url");
                 column.Bound(c=>c.NewsID)
                     .ClientTemplate("<a href='/Admin/LocalizedNews/Details?newsid=<#= NewsID #>&langid=<#= LanguageID #>'><img src='../../../Content/img/ico_page.png' alt='detailCommand'/></a>"
                        + " | <a href='/Admin/LocalizedNews/Edit?newsid=<#= NewsID #>&langid=<#= LanguageID #>'><img src='../../../Content/img/edit.png' alt='editCommand'/></a>"
                        + " | <a href='/Admin/LocalizedNews/Delete/?newsid=<#= NewsID #>&langid=<#= LanguageID #>'><img src='../../../Content/img/cancel.png' alt='deleteCommand' /></a>")
                     .Title("Commands").Width(90);
              })
              .Sortable().Scrollable(scrolling => scrolling.Height(150)).Pageable(p=>p.PageSize(5))
    %>
    
</asp:Content>

