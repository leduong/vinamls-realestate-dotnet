<%@Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>

<asp:Content ID="changePasswordSuccessContent" ContentPlaceHolderID="MainContent" runat="server">

    <p>
        Congratulations on successfully change your password.<br />
        Please click <%= Html.ActionLink("here", "LogOn","Account") %> to back for logging in
    </p>
</asp:Content>