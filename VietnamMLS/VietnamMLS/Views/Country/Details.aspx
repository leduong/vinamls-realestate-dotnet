<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Country>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                CountryID :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.CountryID)%>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                Name :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.Name)%>
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
    <h3>Included Cities</h3>
    <%= Html.Telerik().Grid<VietnamMLS.Models.CityModel>()
        .Name("Grid")
           .DataBinding(data=>
               {
                   data.Ajax().Select("GetLocalByID", "country");
               })
                   .Columns(columns =>
                    {
                        //columns.Bound(o => o.CityID).Width(50);
                        columns.Bound(o => o.Description).Width(100);
                        columns.Bound(o => o.Country).Width(100);
                        columns.Bound(o => o.IsUsed).Width(50);
                        columns.Bound(o => o.CityID)
                    .ClientTemplate("<a href='../../City/Edit/<#= CityID #>'><img src='/Content/img/edit.png' alt='editCommand' /></a>" +
                    "<a href='../../City/Delete/<#= CityID #>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>"
                    + "<a href='../../City/Details/<#= CityID #>'><img src='/Content/img/ico_page.png' alt='detailCommand' /></a>")
                    .Title("Command").Width(55);
                    })
            .Sortable().Scrollable().Pageable().Groupable().Filterable() %>
    <p>
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>

</asp:Content>

