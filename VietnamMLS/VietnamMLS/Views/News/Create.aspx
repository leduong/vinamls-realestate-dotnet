<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.News>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<%--<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        VietnamMLS.Models.VietnamMLSEntities db = new VietnamMLS.Models.VietnamMLSEntities();
        DropDownList1.DataSource = db.Cities;
        DropDownList1.DataBind();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label1.Text = DropDownList1.SelectedValue.ToString();
    }
</script>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form2" runat="server" enctype="multipart/form-data">
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
            <table cellpadding="0" cellspacing="0" style="width: 637px">
            <%using (Ajax.BeginForm("GetParentCateByCity","NewsController", new AjaxOptions() { UpdateTargetId = "ParentID", LoadingElementId="ParentID"}))
                { %>
                    <tr>
                        <td style="width: 105px; height:30px;font-weight:bold" align="right">
                            City</td>
                        <td style="width: 13px; height:30px;font-weight:bold">
                            &nbsp;</td>
                        <td style="height: 30px">
                            <%= Html.DropDownList("CityID", ViewData["CityIDs"] as SelectList, new{onchange="this.form.submit()"})%>
                            <%= Html.ValidationMessageFor(model => model.City.CityID) %>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 105px; height:30px;font-weight:bold" align="right">
                            ParentCategory</td>
                        <td style="width: 13px; height:30px;font-weight:bold">
                            &nbsp;</td>
                        <td style="height: 30px">
                            <%= Html.DropDownList("ParentID",ViewData["ParentIDs"] as SelectList) %>
                            <%= Html.ValidationMessageFor(model => model.ParentCategory.ParentCategoryID) %>
                        </td>
                    </tr>
                 <% } %>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        Category</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.DropDownList("CateID",ViewData["CateIDs"] as SelectList )%>
                        <%= Html.ValidationMessageFor(model => model.Category.CategoryID) %>
                    </td>
                </tr>
                
                <%if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                  { %>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        PostedDate</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <%= Html.Telerik().DatePicker()
                        .Name("PostedDate")
                        .Value(DateTime.Today.Date)%>
                        <%= Html.ValidationMessageFor(model => model.PostedDate)%>
                        <%= Html.Encode(ViewData["InvalidDate"])%>  
                    </td>
                </tr>
                <%} %>
                
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        MainImage</td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px">
                        <input type="file" id="file1" name="file1" />
                    </td>
                </tr>
                
                <%if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                          { %>
                <tr>                
                    <td style="width: 105px; height:30px;font-weight:bold" align="right">
                        IsApproved </td>
                    <td style="width: 13px; height:30px;font-weight:bold">
                        &nbsp;</td>
                    <td style="height: 30px;padding-left:3px">                        
                                <%= Html.CheckBoxFor(model => model.IsApproved)%>
                    </td>
                </tr>
                <%} %>
                <tr>
                    <td style="height:30px;font-weight:bold" align="left" colspan="3">
                    <p>
                        <input type="submit" value="Create"/> | <%= Html.ActionLink("Back to List", "Index") %>
                    </p>
                    </td>
                </tr>                
                </table>
    <% } %>
    </form>
</asp:Content>

