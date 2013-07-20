using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Reflection;

namespace VietnamMLS.ActionFilters
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method,
    Inherited = true, AllowMultiple = false)]
    public sealed class HandleResourceNotFoundAttribute :
        FilterAttribute, IExceptionFilter
    {
        public string View { get; set; }

        public HandleResourceNotFoundAttribute()
        {
            View = "Error";
        }

        public HandleResourceNotFoundAttribute(string view)
        {
            View = view;
        }

        public void OnException(ExceptionContext filterContext)
        {
            Controller controller = filterContext.Controller as Controller;
            if (controller == null || filterContext.ExceptionHandled)
                return;

            Exception exception = filterContext.Exception;
            if (exception == null)
                return;

            // Action method exceptions will be wrapped in a
            // TargetInvocationException since they're invoked using 
            // reflection, so we have to unwrap it.
            if (exception is TargetInvocationException)
                exception = exception.InnerException;

            // If this is not a ResourceNotFoundException error, ignore it.
            if (!(exception is ResourceNotFoundException))
                return;

            filterContext.Result = new ViewResult()
            {
                TempData = controller.TempData,
                ViewName = View
            };

            filterContext.ExceptionHandled = true;
            filterContext.HttpContext.Response.Clear();
            filterContext.HttpContext.Response.StatusCode = 404;
        }
    }
}
