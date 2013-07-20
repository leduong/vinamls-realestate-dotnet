<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.ParentCategoryModel>>" %>

<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    
    <%= Html.Telerik().Grid<VietnamMLS.Models.ParentCategoryModel>()
        .Name("ParentCategoriesGrid")
        .DataKeys(key=>key.Add(pc=>pc.ParentCategoryID))
        .DataBinding(dataBingding =>
        {
            dataBingding.Ajax()
                .Select("_Index", "ParentCategories").Enabled(true);
        })  
         .Columns(column=>
         {
             column.Bound(p => p.ParentCategoryID).Title("ID").Width(25);
             column.Bound(p => p.Description).Width(100);
             column.Bound(p => p.IsUsed).Width(45);
             column.Bound(p => p.SortOrder).Width(50);
             column.Bound(p => p.City).Width(80);
             column.Bound(p => p.ParentCategoryID)
                 .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= ParentCategoryID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                    + "<a href='" + Url.Action("Delete", new { id = "<#= ParentCategoryID #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                    + "<a href='" + Url.Action("Details", new { id = "<#= ParentCategoryID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                 .Title("Commands").Width(55);
          })              
          .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>
</asp:Content>
