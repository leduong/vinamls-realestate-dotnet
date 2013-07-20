<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Role>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <table cellpadding="0" cellspacing="0" style="width: 350px">
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                RoleID :</td>
            <td style="height: 30px">
                <%= Html.Encode(Model.RoleID) %>
            </td>
        </tr>
        <tr>
            <td style="width: 105px; height:30px;font-weight:bold">
                RoleName :</td>
            <td style="height: 30px">
                 <%= Html.Encode(Model.RoleName) %>
            </td>
        </tr>
    </table>
    <h3>Included Users</h3>

    <%= Html.Telerik().Grid<VietnamMLS.Models.User>()
        .Name("userGrid")
        .DataKeys(keys => keys.Add(u => u.UserID))
            //commands => commands.Insert()
                //.ToolBar(commands => commands.Insert())
                        .DataBinding(dataBinding =>
                            {
                                //dataBinding.Server().Select("_Index", "User", new { ajax = true });
                                //dataBinding.Ajax()
                                //    .Select("_Index", "User").Enabled(true)
                                //    .Insert("Create", "User")
                                //    .Update("Edit", "User")
                                //    .Delete("Delete", "User");
                                dataBinding.Ajax().Select("GetUserOfRole", "Role");
                            })
        .Columns(columns =>
        {
            columns.Bound(u => u.UserID).Width(20).ReadOnly();
            columns.Bound(u => u.Username).Width(70);
            columns.Bound(u => u.Password).Width(80);
            columns.Bound(u => u.Email).Width(120);
            //columns.Bound(u => u.RoleName).Width(70);
            columns.Bound(u => u.UserID)
                .ClientTemplate("<a href='" + Url.Content("/Admin/User/Edit/") + "<#= UserID#>'><img src='/Content/img/edit.png' alt='editCommand' /></a>"
                        + "<a href='" + Url.Content("/Admin/User/Delete/") + "<#= UserID#>'><img src='/Content/img/cancel.png' alt='deleteCommand' /></a>"
                        + "<a href='" + Url.Content("/Admin/User/Details/") + "<#= UserID#>'><img src='/Content/img/ico_page.png' alt='detailCommand' /></a>")
                     .Title("Commands").Width(60);            
        })
        .Sortable().Scrollable(scrolling=>scrolling.Height(400)).Pageable().Groupable().Filterable()
    %>
    
      <p>
        <%= Html.ActionLink("Back to List", "Index") %>
    </p>
 
</asp:Content>

