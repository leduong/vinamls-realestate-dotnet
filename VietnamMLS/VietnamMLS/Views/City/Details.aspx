<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.City>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                CityID :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.CityID)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Name :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.Description)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Country :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.CountryReference.CreateSourceQuery().First().Name)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                IsUsed :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.IsUsed)%>
            </td>
        </tr>
    </table>
    <h3>Included Localized Cities</h3>
    <%= Html.Telerik().Grid<VietnamMLS.Models.LocalizedCity>()
        .Name("Grid")
           .DataBinding(data=>
               {
                   data.Ajax().Select("GetLocalByID", "city");
               })
                   .Columns(columns =>
                    {
                        //columns.Bound(c => c.d).Width(15).ReadOnly();                    
                        columns.Bound(c => c.Language).Width(80).ReadOnly();
                        columns.Bound(c => c.Name).Width(100);
                        //columns.Bound(c => c.SEOUrl).Width(20);
                        //columns.Bound(c => c.SEOKeyword).Width(20);
                        columns.Bound(c => c.SEODescription).Width(80);
                        columns.Bound(c => c.Name)
                            .ClientTemplate("<a href='/Admin/LocalizedCities/Edit?idl=<#=LanguageID#>&idc=<#= CityID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                                + "<a href='/Admin/LocalizedCities/Delete?idl=<#=LanguageID#>&idc=<#= CityID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>")
                                .Title("Command").Width(55);
                    })
            .Sortable().Scrollable().Pageable().Groupable().Filterable() %>
    <p>
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>


</asp:Content>

