using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace VietnamMLS
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // routes.MapRoute(
            //    "Login", // Route name
            //    "Admin/{username}", // URL with parameters
            //    new { controller = "AdminHome", action = "Login", username = "" } // Parameter defaults
            //);
            // routes.MapRoute(
            //    "User", // Route name
            //    "{username}/{controller}/{action}/{id}", // URL with parameters
            //    new { controller = "AdminHome", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            //);

            routes.MapRoute(
                "Account",
                "admin/Account/{action}/{username}",
                new
                {
                    controller = "Account",
                    action = "Index",
                    username = UrlParameter.Optional,
                }
                );

            routes.MapRoute(
                "Adminsection",
                "admin/{controller}/{action}/{id}",
                new
                {
                    controller = "Account",
                    action = "Index",
                    id = UrlParameter.Optional,
                }
                );

            routes.MapRoute(
                "localhostroute", // Route name
                "", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

            routes.MapRoute(
               "Default",
               "Articles/{titleUrl}",
               new
               {
                   controller = "Articles",
                   action = "Index",
                   titleUrl = UrlParameter.Optional
               }
               );

            routes.MapRoute(
              "Searchfield",
              "Search/{action}",
              new
              {
                  controller = "Search",
                  action = "Index"
                  
              }
              );

            routes.MapRoute(
                "Categories", "{controller}/{name}",
                new
                {
                    controller = "Categories",
                    action = "GetNewsByCategory",
                    name = (string)null
                }
                );

            routes.MapRoute(
                "Error",
                "{*url}",
                new { controller = "Error", action = "NotFound" });
        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
            
            //in testing process
            //System.Web.Mvc.ViewEngines.Engines.Clear();
            //System.Web.Mvc.ViewEngines.Engines.Add(new WebFormThemeViewEngine());
        }
    }
}