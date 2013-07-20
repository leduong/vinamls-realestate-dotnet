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
    public class CityController : AdminController
    {
        //
        // GET: /City/

        VietnamMLSEntities entities = new VietnamMLSEntities();

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "City Index Viewer";
                return View(CityRepository.GetAll());
                //return View(entities.Cities.ToList());
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
                ViewData["Message"] = "City Index Viewer";
                return View(new GridModel(CityRepository.GetAll()));
                //return View(new GridModel(entities.Cities.ToList()));
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
        public ActionResult GetLocalByID(int id)
        {
            return View(new GridModel(LocalizedCityRepository.GetByLocalizedCityID(id)));
        }

        //
        // GET: /City/Details/5

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "detail";
                try
                {
                    ViewData["Message"] = "City Detail";

                    City CityToDetails = entities.Cities
                          .Where(l => l.CityID == id).FirstOrDefault();
                    if (CityToDetails != null)
                    {
                        return View(CityToDetails);
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
        // GET: /City/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new city";
                this.ViewData["CountryToCreate"] = new SelectList(entities.Countries.ToList(), "CountryID", "Name");
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /City/Create

        [HttpPost]
        public ActionResult Create(City CityToCreate)
        {
            ViewData["Message"] = "Create new city";
            int countryID = int.Parse(Request.Form["CountryID"]);
            if (ModelState.IsValid)
            {
                try
                {

                    CityToCreate.Country = entities.Countries.Where(c => c.CountryID == countryID).First();
                    //Country country = entities.Countries.Where(c => c.CountryID == countryID).First();
                    //CityToCreate.Country = country;                
                    entities.AddToCities(CityToCreate);
                    entities.SaveChanges();

                    CitiesInHome citiesinhome = new CitiesInHome();
                    citiesinhome.City = entities.Cities.Where(c => c.CityID == CityToCreate.CityID).First();
                    citiesinhome.IsDefault = false;
                    entities.AddToCitiesInHomes(citiesinhome);

                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    this.ViewData["CountryToCreate"] = new SelectList(entities.Countries.ToList(), "CountryID", "Name");
                    return View(CityToCreate);
                }
            }
            else
            {
                this.ViewData["CountryToCreate"] = new SelectList(entities.Countries.ToList(), "CountryID", "Name");
                return View(CityToCreate);
            }
        }

        //
        // GET: /City/Edit/5

        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "Edit";
                try
                {
                    ViewData["Message"] = "Edit City";
                    City CityToEdit = entities.Cities
                          .Where(l => l.CityID == id).FirstOrDefault();
                    this.ViewData["CountryToEdit"] = new SelectList(entities.Countries.ToList(), "CountryID", "Name");
                    if (CityToEdit != null)
                    {
                        return View(CityToEdit);
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
        // POST: /City/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit City";
            City CityToEdit = entities.Cities
                  .Where(l => l.CityID == id).FirstOrDefault();

            int countryID = int.Parse(Request.Form["CountryID"]);
            if (ModelState.IsValid)
            {
                try
                {
                    Country country = entities.Countries.Where(c => c.CountryID == countryID).First();
                    CityToEdit.Country = country;
                    UpdateModel(CityToEdit);
                    entities.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch
                {
                    return View();
                }
            }
            else
                return View();
        }

        //
        // GET: /City/Delete/5

        public ActionResult Delete(int id)
        {
            ViewData["action"] = "Delete";
            try
            {
                ViewData["Message"] = "Delete City";
                City CityToDelete = entities.Cities.Where(p => p.CityID == id).FirstOrDefault();
                if (CityToDelete != null)
                {
                    return View(CityToDelete);
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
        // POST: /City/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Delete City";
                City CityToDelete = entities.Cities.Where(p => p.CityID == id).FirstOrDefault();
                try
                {
                    CitiesInHome CitiesInHomeToDelete = entities.CitiesInHomes
                     .Where(l => l.CityID == id).FirstOrDefault();
                    entities.DeleteObject(CitiesInHomeToDelete);
                    entities.SaveChanges();

                    entities.DeleteObject(CityToDelete);
                    entities.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(CityToDelete);
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
