<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<VietnamMLS.Models.ParentCategory>>" %>
<%= Html.DropDownList("ddlParentCate",ViewData["ParentIDs"] as SelectList) %>