<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VietnamMLS.Models.Language>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <form id="form1" runat="server" enctype="multipart/form-data">
  
    <% using (Html.BeginForm()) {%>
        <%= Html.ValidationSummary(true) %>
<div>
            <table cellpadding="0" cellspacing="0" style="width: 350px">
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        LanguageID :</td>
                    <td style="height: 30px">
                        <%=Model.LanguageID %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        LanguageCode :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.LanguageCode) %>
                         <%= Html.ValidationMessageFor(model => model.LanguageCode) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Name :</td>
                    <td style="height: 30px">
                         <%= Html.TextBoxFor(model => model.Name) %>
                         <%= Html.ValidationMessageFor(model => model.Name) %>
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Flag :</td>
                    <td style="height: 30px">
                         <input type="file" id="file2" name="file1" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        IsUsed :</td>
                    <td style="height: 30px">
                        <%= Html.CheckBoxFor(model => model.IsUsed) %>
                        <%= Html.ValidationMessageFor(model => model.IsUsed) %>
                    </td>
                </tr>
                
                 <tr>
                    <td style="width: 105px; height:30px;font-weight:bold">
                        Sort Order :</td>
                    <td style="height: 30px">
                          <%= Html.TextBoxFor(model => model.SortOrder) %>
                          <%= Html.ValidationMessageFor(model => model.SortOrder) %>
                    </td>
                </tr>
     
                
            </table>
                
        </div>
        
        <p>
            <b><input type="submit" value="Save" /></b>  |  <%= Html.ActionLink("Back to List", "Index", null, new { style="font-weight:bold" })%>
        </p>
    <% } %> 
    
    </form>

</asp:Content>

