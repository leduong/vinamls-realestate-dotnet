using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Telerik.Web.Mvc;
using VietnamMLS.Models;

namespace VietnamMLS.Controllers
{
    public class MembershipController : Controller
    {
        //
        // GET: /Membership/
        VietnamMLSEntities db = new VietnamMLSEntities();
        UserRoleRepository urr = new UserRoleRepository();
        public ActionResult Index()
        {
            ViewData["Message"] = "User Index Viewer";
            return View(urr.GetAllAccounts());
        }
        [GridAction]
        public ActionResult _Index()
        {
            ViewData["Message"] = "User Index Viewer";
            return View(new GridModel(urr.GetAllAccounts()));
        }
        //
        // GET: /Membership/Details/5

        public ActionResult Details(string username)
        {
            ViewData["message"] = "Account details";
            try
            {
                return View(urr.GetAccInfo(username));
            }
            catch
            {
                return View("NotFound");
            }
        }

        //
        // GET: /Membership/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Membership/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Membership/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Membership/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Membership/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Membership/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
