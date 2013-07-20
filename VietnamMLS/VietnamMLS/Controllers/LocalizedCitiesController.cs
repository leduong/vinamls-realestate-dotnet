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
    public class LocalizedCitiesController : AdminController
    {
        VietnamMLSEntities entities = new VietnamMLSEntities();
        //
        // GET: /LocalizedCities/

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Localized Cities Index Viewer";
                return View(LocalizedCityRepository.GetAll());
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
                ViewData["Message"] = "Localized Cities Index Viewer";
                return View(new GridModel(LocalizedCityRepository.GetAll()));
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
        // GET: /LocalizedCities/Details/5

        //public ActionResult Details(int id)
        //{
        //    ViewData["Message"] = "Detail Localized Cities";
        //    return View();
        //}

        public ActionResult Details(int id, int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Detail Localized Cities";
                LocalizedCity lcToDetails = entities.LocalizedCities.Where(lpc => lpc.CityID == id && lpc.LanguageID == id2).FirstOrDefault();
                return View(lcToDetails);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }
        
        // GET: /LocalizedCities/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new Localized Cities";
                Create_PageLoad();
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        private void Create_PageLoad()
        {
            ViewData["Message"] = "Create new Localized Cities";
            ViewData["ct"] = new SelectList(entities.Cities, "CityID", "Description");
            ViewData["lg"] = new SelectList(entities.Languages, "LanguageID", "Name");
        } 

        //
        // POST: /LocalizedCities/Create

        [HttpPost]
        public ActionResult Create(LocalizedCity city)
        {
            ViewData["Message"] = "Create new Localized Cities";
            if (ModelState.IsValid)
            {
                try
                {
                    city.City = (from c in entities.Cities where c.CityID == city.CityID select c).First();
                    city.Language = (from l in entities.Languages where l.LanguageID == city.LanguageID select l).First();
                    city.SEOUrl = Utilities.ProduceUrl(city.Name);
                    entities.AddToLocalizedCities(city);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    Create_PageLoad();
                    return View();
                }
            }
            else
            {
                Create_PageLoad();
                return View();
            }
        }
        
        //
        // GET: /LocalizedCities/Edit/5

        public ActionResult Edit(int idc, int idl)
        {

            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "Edit";
                try
                {
                    ViewData["Message"] = "Edit Localized Cities";
                    LocalizedCity LocalizedCityToEdit = entities.LocalizedCities
                        .Where(l => l.LanguageID == idl && l.CityID == idc).FirstOrDefault();
                    if (LocalizedCityToEdit != null)
                    {
                        return View(LocalizedCityToEdit);
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

        //
        // POST: /LocalizedCities/Edit/5

        [HttpPost]
        [GridAction]
        public ActionResult Edit(int idc, int idl, FormCollection collection)
        {
            ViewData["Message"] = "Edit Localized Cities";
            LocalizedCity LocalizedCityToEdit = entities.LocalizedCities
                .Where(l => l.LanguageID == idl && l.CityID == idc).FirstOrDefault();
            if (ModelState.IsValid)
            {
                try
                {
                    LocalizedCityToEdit.City = entities.Cities.Where(c => c.CityID == idc).First();
                    LocalizedCityToEdit.Language = entities.Languages.Where(l => l.LanguageID == idl).First();
                    UpdateModel(LocalizedCityToEdit);
                    entities.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(LocalizedCityToEdit);
                }
            }
            else
                return View(LocalizedCityToEdit);
        }
        //
        // GET: /LocalizedCities/Delete/5
 
        public ActionResult Delete(int idc, int idl)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "Delete";
                try
                {
                    ViewData["Message"] = "Delete Localized Cities";
                    LocalizedCity LocalizedCityToDelete = entities.LocalizedCities
                        .Where(l => l.LanguageID == idl && l.CityID == idc).FirstOrDefault();
                    if (LocalizedCityToDelete != null)
                    {
                        return View(LocalizedCityToDelete);
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

        //
        // POST: /LocalizedCities/Delete/5

        [HttpPost]
        [GridAction]
        public ActionResult Delete(int idc,int idl, FormCollection collection)
        {
            ViewData["Message"] = "Delete Localized Cities";
            LocalizedCity LocalizedCityToDelete = entities.LocalizedCities
                .Where(l => l.LanguageID == idl && l.CityID == idc).FirstOrDefault();
            try
            {
                LocalizedCityToDelete.City = entities.Cities.Where(c => c.CityID == idc).First();
                LocalizedCityToDelete.Language = entities.Languages.Where(l => l.LanguageID == idl).First();
                // TODO: Add delete logic here
                entities.DeleteObject(LocalizedCityToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(LocalizedCityToDelete);
            }
        }
    }
}
