using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace VietnamMLS.Controllers
{
    public abstract class ThemeControllerBase : AdminController
    {
        protected override void Execute(System.Web.Routing.RequestContext requestContext)
        {
            // Add code here to set the Theme based on your database or some other storage
            requestContext.HttpContext.Items["themeName"] = "User";



            // Allow the Theme to be overriden via the querystring
            // If a Theme Name is Passed in the querystring then use it and override the previously set Theme Name
            // http://localhost/Default.aspx?theme=Default
            var previewTheme = requestContext.HttpContext.Request.QueryString["theme"];
            if (!string.IsNullOrEmpty(previewTheme))
            {
                requestContext.HttpContext.Items["themeName"] = previewTheme;
            }

            base.Execute(requestContext);
        }

    }
}
