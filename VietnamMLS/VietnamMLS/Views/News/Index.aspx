<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%= Html.Telerik().Grid<VietnamMLS.Models.NewsModel>()
        .Name("Grid")
        .DataKeys(keys => { keys.Add(n => n.NewsID); })
        .DataKeys(keys => { keys.Add(n => n.IsApproved); })
        .DataBinding(dataBinding =>
        {
            dataBinding.Ajax()
                .Select("Index", "News");
        })
        .Columns(columns =>
        {
            columns.Bound(c => c.NewsID).Width(55).Title("ID");
            columns.Bound(c => c.CreatedDate).Width(100);
            columns.Bound(c => c.PostedDate).Width(100);
            columns.Bound(c => c.MainImage).Width(100)
                .ClientTemplate("<img alt='<#= NewsID #> Image' src='"
                    + Url.Content("~/Content/Images/NewsImages/")
                    + "<#= MainImage #> ' width=50px height=24px />");
            columns.Bound(c => c.IsApproved).Width(75).Title("Approved");
            columns.Bound(c => c.City).Width(115);
            columns.Bound(c => c.NewsID)
                     .ClientTemplate("<a href='/Admin/News/Details/<#= NewsID #>' title='Detail'><img src='../../Content/img/ico_page.png' alt='detailCommand'/></a>"
                        + " | <a href='/Admin/News/Edit/<#= NewsID #>' title='Edit'><img src='../../Content/img/edit.png' alt='editCommand'/></a>"
                        + " | <a href='/Admin/News/Delete/<#= NewsID #>' title='Delete'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + " | <a href='/Admin/LocalizedNews/Create/<#= NewsID #>' title='Edit Content'><img src='../../Content/img/ico_posts.png'/></a>")
                     .Title("Commands").Width(120);
        })
        .Scrollable(scrolling => scrolling.Height(500))
        .Pageable(p => p.PageSize(20))
        .Sortable()
        %>           
    <p>
        <%=Html.ActionLink("Create New","Create","News") %>
    </p>
    </asp:Content>