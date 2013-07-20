<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.LocalizedCityModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%--<table>
        <tr>
            <th></th>
            <th>
                CityID
            </th>
            <th>
                LanguageID
            </th>
            <th>
                Name
            </th>
            <th>
                SEOUrl
            </th>
            <th>
                SEOKeyword
            </th>
            <th>
                SEODescription
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { idl = item.LanguageID, idc = item.CityID }) %> |
                <%= Html.ActionLink("Delete", "Delete", new { idl = item.LanguageID, idc = item.CityID })%>
            </td>
            <td>
                <%= Html.Encode(item.CityID) %>
            </td>
            <td>
                <%= Html.Encode(item.LanguageID) %>
            </td>
            <td>
                <%= Html.Encode(item.Name) %>
            </td>
            <td>
                <%= Html.Encode(item.SEOUrl) %>
            </td>
            <td>
                <%= Html.Encode(item.SEOKeyword) %>
            </td>
            <td>
                <%= Html.Encode(item.SEODescription) %>
            </td>
        </tr>
    
    <% } %>

    </table>--%>

    
<%=Html.Telerik().Grid<VietnamMLS.Models.LocalizedCity>()
    .Name("LocalizedCitiesGrid")
    .DataBinding(databind=>
        {
           // databind.Server().Select("Index", "LocalizedCities", new { ajax = true });
            databind.Ajax().Select("_Index","LocalizedCities").Enabled(true);
        })
       
            .Columns(column=>
                {
                    //column.Bound(c => c.d).Width(15).ReadOnly();                    
                    column.Bound(c => c.Language).Width(80).ReadOnly();                    
                    column.Bound(c => c.Name).Width(100);
                    column.Bound(c => c.SEOUrl).Width(80);
                    //column.Bound(c => c.SEOKeyword).Width(20);
                    //column.Bound(c => c.SEODescription).Width(80);
                    column.Bound(c => c.Name)
                        .ClientTemplate("<a href='/Admin/LocalizedCities/Edit?idl=<#=LanguageID#>&idc=<#= CityID#>'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                            + "<a href='/Admin/LocalizedCities/Delete?idl=<#=LanguageID#>&idc=<#= CityID#>'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>")
                            .Title("Command").Width(55);
                })
                .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
    <p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

</asp:Content>

