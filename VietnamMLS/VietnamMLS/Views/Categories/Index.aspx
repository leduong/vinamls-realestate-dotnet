<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
<%=Html.Telerik().Grid<VietnamMLS.Models.Category>()
    .Name("CategoriesGrid")
    .DataKeys(key=>key.Add(c=>c.CategoryID))
    .DataBinding(databind=>
        {
            //databind.Server().Select("Index", "Categories", new { ajax = true });
            databind.Ajax().Select("Index","Categories").Enabled(true);
        })
       
            .Columns(column=>
                {
                    column.Bound(c => c.CategoryID).Width(20).ReadOnly().Title("ID");
                    column.Bound(c => c.Description).Width(80);
                    column.Bound(c => c.IsUsed).Width(30);
                            
                    column.Bound(c => c.DefaultImage).Width(60)
                        .ClientTemplate("<img alt='<#= Description#> image' src='" + Url.Content("~/Content/Images/Categories/") + "<#= DefaultImage #>' width=20 height=20 />");
                    column.Bound(c => c.ParentCategory).Width(50).Title("Parent");
                    column.Bound(c => c.ParentCategory)
                    .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= CategoryID #>" }) + "' title='Edit'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Action("Delete", new { id = "<#= CategoryID #>" }) + "' title='Delete'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Action("Details", new { id = "<#= CategoryID #>" }) + "' title='Detail'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                     .Title("Commands").Width(60);
                })
                .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>
</asp:Content>

