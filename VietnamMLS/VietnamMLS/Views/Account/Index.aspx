<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.UserRoleRepository+AccountInfoModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%= Html.Telerik().Grid<VietnamMLS.Models.UserRoleRepository.AccountInfoModel>()
        .Name("userGrid")
        .DataKeys(keys => keys.Add(u => u.UserId))
            //commands => commands.Insert()
                //.ToolBar(commands => commands.Insert())
                        .DataBinding(dataBinding =>
                            {
                                dataBinding.Server().Select("_Index", "Account", new { ajax = true });
                                dataBinding.Ajax()
                                    .Select("_Index", "Account").Enabled(true)
                                    .Insert("Create", "User")
                                    .Update("Edit", "User")
                                    .Delete("Delete", "User");
                            })
        .Columns(columns =>
        {
            columns.Bound(u => u.UserName).Width(70);
            columns.Bound(u => u.Email).Width(120);
            columns.Bound(u => u.RoleName).Width(70);
            //columns.Bound(u => u.RoleReference.CreateSourceQuery().First().RoleID).Width(50);
            columns.Bound(u => u.UserId)
                .ClientTemplate("<a href='" + Url.Action("Edit", new { username = "<#= UserName #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Action("Delete", new { username = "<#= UserName #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Action("Details", new { username = "<#= UserName #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>"
                        )
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
        <%if (HttpContext.Current.User.IsInRole("admin")) {%>
            <p>
                <%= Html.ActionLink("Create New", "Register", null, new { style = "font-weight:bold" })%>  only admin role have the ability to see this Create New link
            </p>
        <%}%>


    <%--<table>
        <tr>
            <th></th>
            <th>
                UserName
            </th>
            <th>
                Email
            </th>
            <th>
                RoleName
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { /* id=item.PrimaryKey */ }) %> |
                <%= Html.ActionLink("Details", "Details", new { /* id=item.PrimaryKey */ })%> |
                <%= Html.ActionLink("Delete", "Delete", new { /* id=item.PrimaryKey */ })%>
            </td>
            <td>
                <%= Html.Encode(item.UserName) %>
            </td>
            <td>
                <%= Html.Encode(item.Email) %>
            </td>
            <td>
                <%= Html.Encode(item.RoleName) %>
            </td>
        </tr>
    
    <% } %>

    </table>--%>

   
</asp:Content>

