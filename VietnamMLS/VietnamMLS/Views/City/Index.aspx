<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.CityModel>>" %>

<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

        <%= Html.Telerik().Grid<VietnamMLS.Models.CityModel>()
            .Name("CityGrid")
            .DataKeys(keys => keys.Add(c => c.CityID))
            .DataBinding(dataBinding => 
                {
                        dataBinding.Ajax()
                             .Select("_Index", "City").Enabled(true);
                })
            .Columns(columns =>
            {
                columns.Bound(o => o.CityID).Width(20).Title("ID");
                columns.Bound(o => o.Description).Width(120).Title("City");
                columns.Bound(o => o.Country).Width(100);
                columns.Bound(o => o.IsUsed).Width(40);
                columns.Bound(o => o.CityID)
                 .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= CityID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Action("Delete", new { id = "<#= CityID #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Action("Details", new { id = "<#= CityID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                     .Title("Commands").Width(60);
            })
            .Sortable().Scrollable().Pageable().Groupable().Filterable() %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

