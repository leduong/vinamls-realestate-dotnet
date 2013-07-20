<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.CountryModel>>" %>

<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%= Html.Telerik().Grid<VietnamMLS.Models.CountryModel>()
        .Name("CountriesGrid")
        .DataKeys(keys => keys.Add(l => l.CountryID))
        .DataBinding(dataBinding =>
        {
            dataBinding.Ajax()
                .Select("_Index", "Country").Enabled(true);
        })
        .Columns(columns =>
        {
            
            columns.Bound(l => l.Name).Width(200);
            columns.Bound(l => l.IsUsed).Width(100);
            columns.Bound(l => l.CountryID)
            
            .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= CountryID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Action("Delete", new { id = "<#= CountryID #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Action("Details", new { id = "<#= CountryID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                     .Title("Commands").Width(60);
        })
        
        .Sortable().Scrollable().Pageable().Groupable().Filterable()  %>
        <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

