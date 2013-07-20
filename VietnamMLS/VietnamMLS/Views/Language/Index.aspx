<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.Language>>" %>

<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<ul id="leftColumn">
        <%= Ajax.ActionLink("select", "Index", new AjaxOptions { UpdateTargetId = "divLanguageList"})%>
    </ul>--%>
    <div id="divLanguageList">
        <% Html.RenderPartial("LanguageList", Model); %>
    </div>
    <%--<%= Html.Telerik().Grid<VietnamMLS.Models.Language>()
        .Name("languagesGrid")
        //.DataKeys(keys => keys.Add(l => l.LanguageID))
        .Columns(columns =>
        {
            columns.Bound(l => l.LanguageID).Width(30).Title("ID");
            columns.Bound(l => l.LanguageCode).Width(40).Title("Code");
            columns.Bound(l => l.Name).Width(120);
            columns.Bound(l => l.Flag).Width(60)
                .ClientTemplate("<img alt='<#= Name #> flag' src='" 
                    + Url.Content("~/Content/Images/Languages/") 
                    + "<#= Flag #>?" + DateTime.Now + "' />");            
            columns.Bound(l => l.IsUsed).Width(40);
            columns.Bound(l => l.LanguageID)
                 .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= LanguageID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                    + "<a href='" + Url.Action("Delete", new { id = "<#= LanguageID #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                    + "<a href='" + Url.Action("Details", new { id = "<#= LanguageID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                 .Title("Commands").Width(75);
        })
        .DataBinding(dataBinding =>
        {
            dataBinding.Ajax()
                .Select("_Index", "Language").Enabled(true);
        })
        .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>--%>
</asp:Content>
