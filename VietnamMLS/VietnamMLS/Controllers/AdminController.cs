using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using VietnamMLS.ActionFilters;

namespace VietnamMLS.Controllers
{
    //[Authorize]
    [HandleResourceNotFound, HandleError]
    public abstract class AdminController : Controller
    {
        //private VietnamMLSEntities entities = new VietnamMLSEntities();

        //public VietnamMLSEntities Entities
        //{
        //    get { return entities; }
        //}
    }
}
