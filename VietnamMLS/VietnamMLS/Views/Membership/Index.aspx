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
                .ClientTemplate("<a href='" + Url.Action("ChangePassword", new { id = "<#= UserName #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                        //+ "<a href='" + Url.Action("Delete", new { id = "<#= Username #>" }) + "'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                        //+ "<a href='" + Url.Action("Details", new { id = "<#= UserID #>" }) + "'><img src='../../Content/img/ico_page.png' alt='detailCommand' /></a>"
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
                <%= Html.ActionLink("Create New", "Create")%>  only admin role have the ability to see this Create New link
            </p>
        <%}%>

    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

