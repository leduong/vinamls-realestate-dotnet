using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.IO;
using Telerik.Web.Mvc;

namespace VietnamMLS.Controllers
{
    [Authorize]
    public class CountryController : AdminController
    {
        //
        // GET: /Country/
        private VietnamMLSEntities entities = new VietnamMLSEntities();

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Country Index Viewer";
                return View(CountryRepository.GetAll());
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

        [GridAction]
        public ActionResult _Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Country Index Viewer";
                return View(new GridModel(CountryRepository.GetAll()));
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
        // GET: /Country/Details/5

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "Detail";
                try
                {
                    ViewData["Message"] = "Country Detail";
                    Country CountryToDetails = entities.Countries
                        .Where(l => l.CountryID == id).FirstOrDefault();
                    if (CountryToDetails != null)
                    {
                        return View(CountryToDetails);
                    }
                    else
                    {
                        return View("Error");
                    }
                }
                catch
                {
                    return View("Error");
                }
                
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }
        [GridAction]
        public ActionResult GetLocalByID(int id)
        {
            return View(new GridModel(CityRepository.GetByCityID(id)));
        }
        //
        // GET: /Country/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new country";
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Country/Create

        [HttpPost]
        [GridAction]
        public ActionResult Create(Country CountryToCreate)
        {
            ViewData["Message"] = "Create new country";
            if (ModelState.IsValid)
            {
                try
                {
                    entities.AddToCountries(CountryToCreate);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(CountryToCreate);
                }
            }
            return View(CountryToCreate);
        }

        //
        // GET: /Country/Edit/5

        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "Edit";
                try
                {
                    ViewData["Message"] = "Edit Country";
                    Country CountryToEdit = entities.Countries
                        .Where(l => l.CountryID == id).FirstOrDefault();
                    if (CountryToEdit != null)
                    {
                        return View(CountryToEdit);
                    }
                    else
                    {
                        return View("Error");
                    }
                    
                }
                catch
                {
                    return View("Error");
                }
                
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }


        // POST: /Country/Edit/5

        [HttpPost]
        [GridAction]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit Country";
            Country CountryToEdit = entities.Countries
                .Where(l => l.CountryID == id).FirstOrDefault();
            if (ModelState.IsValid)
            {
                try
                {
                    UpdateModel(CountryToEdit);
                    entities.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(CountryToEdit);
                }
            }
            else
                return View(CountryToEdit);

        }


        //
        // GET: /Country/Delete/5

        public ActionResult Delete(int id)
        {
            ViewData["action"] = "Delete";
            try
            {
                ViewData["Message"] = "Delete Country";
                Country CountryToDelete = entities.Countries.Where(p => p.CountryID == id).FirstOrDefault();
                if (CountryToDelete != null)
                {
                    return View(CountryToDelete);
                }
                else
                {
                    return View("Error");
                }
            }
            catch
            {
                return View("Error");
            }
           
        }

        //
        // POST: /Country/Delete/5

        [HttpPost]
        [GridAction]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Delete Country";
                Country CountryToDelete = entities.Countries.Where(p => p.CountryID == id).FirstOrDefault();
                try
                {
                    // TODO: Add delete logic here
                    entities.DeleteObject(CountryToDelete);
                    entities.SaveChanges();
                    //return RedirectToAction("Index");
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(CountryToDelete);
                }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }
    }
}
