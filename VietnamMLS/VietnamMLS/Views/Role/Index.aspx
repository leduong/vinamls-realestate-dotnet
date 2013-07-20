<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.Role>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%= Html.Telerik().Grid<VietnamMLS.Models.Role>()
        .Name("roleGrid")
        .DataKeys(keys => keys.Add(u => u.RoleID))
            //commands => commands.Insert()
                //.ToolBar(commands => commands.Insert())
                        .DataBinding(dataBinding =>
                            {
                                dataBinding.Server().Select("_Index", "User", new { ajax = true });
                                dataBinding.Ajax()
                                    .Select("_Index", "User").Enabled(true)
                                    .Insert("Create", "User")
                                    .Update("Edit", "User")
                                    .Delete("Delete", "User");
                            })
        .Columns(columns =>
        {
            columns.Bound(u => u.RoleID).Width(70);
            columns.Bound(u => u.RoleName).Width(80);            
            //columns.Bound(u => u.RoleReference.CreateSourceQuery().First().RoleID).Width(50);
            columns.Bound(u => u.RoleID)
                .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= RoleID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Action("Delete", new { id = "<#= RoleID #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Action("Details", new { id = "<#= RoleID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>")
                     .Title("Commands").Width(60);
            //columns.Command(commands =>
            //{
            //    commands.Edit();
            //    commands.Delete();
            //}).Width(200);
        })
                //.DataBinding(dataBinding =>
                //{
                //    dataBinding.Ajax()
                //        .Select("_Index", "User").Enabled(true)
                //        .Insert("Create", "User")
                //        .Update("Edit", "User")
                //        .Delete("Delete", "User");
                //})
        .Sortable().Scrollable(scrolling=>scrolling.Height(400)).Pageable().Groupable().Filterable()
    %>
    
     <p>
        <%= Html.ActionLink("Create New", "Create")%>
    </p>
    
</asp:Content>

