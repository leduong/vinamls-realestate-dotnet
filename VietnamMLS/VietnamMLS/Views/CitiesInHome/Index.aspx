<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<VietnamMLS.Models.CitiesInHomeModel>>" %>

<%@ Import Namespace="VietnamMLS.Helpers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%--<table>
        <tr>
            <th></th>
            <th>
                CityName
            </th>
            <th>
                IsDefault
            </th>
            <th>
                SortOrder
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edit", new { id=item.CityID }) %> |
                <%= Html.ActionLink("Details", "Details", new { id=item.CityID })%> |
                <%= Html.ActionLink("Delete", "Delete", new { id=item.CityID })%>
            </td>
            <td>
                <%= Html.Encode(item.CityReference.CreateSourceQuery().First().Description) %>
            </td>
            <td>
                <%= Html.CheckBox("check", item.IsDefault, new { disable = item.IsDefault })%>
            </td>
            <td>
                <%= Html.Encode(item.SortOrder) %>
            </td>
        </tr>
    
    <% } %>

    </table>--%>

    <%--<p>
        <%= Html.ActionLink("Create New", "Create") %>
    </p>
    
--%>
<%= Html.Telerik().Grid<VietnamMLS.Models.CitiesInHomeModel>()
            .Name("CitiesInHomeGrid")
        .DataKeys(key=>key.Add(pc=>pc.CityID))
        .DataBinding(dataBingding =>
        {   
            dataBingding.Ajax()
                .Select("_Index", "CitiesInHome").Enabled(true);
        })  
         .Columns(column=>
         {
             column.Bound(p => p.CityID).Width(20).Title("ID");
             column.Bound(p => p.Description).Width(120);
             column.Bound(p => p.IsDefault).Width(50);
             column.Bound(p => p.SortOrder).Width(50);
             
             column.Bound(p => p.CityID)
                 .ClientTemplate("<a href='" + Url.Action("Edit", new { id = "<#= CityID #>" }) + "'><img src='../../Content/img/edit.png' alt='editCommand' /></a>"
                 //+ "<a href='/CitiesInHome/Delete/<#= CityID #>'><img src='../../Content/img/cancel.png' alt='deleteCommand' /></a>"
                    )
                 .Title("Commands").Width(55);
          })              
          //.Selectable()
          //.ClientEvents(events => events.OnRowSelected("onRowSelected"))
          .Sortable().Scrollable().Pageable().Groupable().Filterable()
    %>
</asp:Content>

