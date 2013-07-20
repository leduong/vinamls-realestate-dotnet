using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;

namespace VietnamMLS.Controllers
{
    [Authorize]
    public class CitiesInHomeController : AdminController
    {
        //
        // GET: /CitiesInHome/
        private VietnamMLSEntities entities = new VietnamMLSEntities();
        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "CitiesInHome Index Viewer";
                return View(CitiesInHomeRepository.GetAll());
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }

        //
        // GET: /CitiesInHome/Details/5
        [GridAction]
        public ActionResult _Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "CitiesInHome Index Viewer";
                return View(new GridModel(CitiesInHomeRepository.GetAll()));
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // GET: /CitiesInHome/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /CitiesInHome/Create

        [HttpPost]
        public ActionResult Create(CitiesInHome CitiesInHomeToCreate)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    entities.AddToCitiesInHomes(CitiesInHomeToCreate);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(CitiesInHomeToCreate);
                }
            }
            return View(CitiesInHomeToCreate);
        }

        //
        // GET: /CitiesInHome/Edit/5

        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Edit CitiesInHome ";
                CitiesInHome CitiesInHomeToEdit = entities.CitiesInHomes
                     .Where(l => l.CityID == id).FirstOrDefault();

                return View(CitiesInHomeToEdit);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /CitiesInHome/Edit/5
        
        [HttpPost]
        [GridAction]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit CitiesInHome ";
            CitiesInHome CitiesInHomeToEdit = entities.CitiesInHomes
                 .Where(l => l.CityID == id).FirstOrDefault();

            try
            {
                UpdateModel(CitiesInHomeToEdit);
                entities.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View(CitiesInHomeToEdit);
            }
        }

        //
        // GET: /CitiesInHome/Delete/5

        public ActionResult Delete(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /CitiesInHome/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            CitiesInHome CitiesInHomeToDelete = entities.CitiesInHomes
                 .Where(l => l.CityID == id).FirstOrDefault();

            try
            {
                // TODO: Add delete logic here
                entities.DeleteObject(CitiesInHomeToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(CitiesInHomeToDelete);
            }
        }
    }
}
