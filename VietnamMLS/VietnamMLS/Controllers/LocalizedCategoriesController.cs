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
    public class LocalizedCategoriesController : AdminController
    {
        //
        // GET: /LocalizedCategories/
        VietnamMLSEntities entities = new VietnamMLSEntities();

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Localized Categories Index Viewer";
                //return View(entities.LocalizedCategories.ToList());
                return View(LocalizedCategoryRepository.GetAll());
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
                ViewData["Message"] = "Localized Categories Index Viewer";
                //return View(entities.LocalizedCategories.ToList());
                return View(new GridModel(LocalizedCategoryRepository.GetAll()));
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
        // GET: /LocalizedCategories/Details/5

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Detail Localized Categories";
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // GET: /LocalizedCategories/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new Localized Categories";
                this.ViewData["CategoriesToCreate"] = new SelectList(entities.Categories, "CategoryID", "Description");
                this.ViewData["LanguagesToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        } 

        //
        // POST: /LocalizedCategories/Create

        [HttpPost]
        public ActionResult Create(LocalizedCategory localizedCategoriesToCreate)
        {
            ViewData["Message"] = "Create new Localized Categories";
            if (ModelState.IsValid)
            {
                try
                {
                    localizedCategoriesToCreate.Category = entities.Categories
                        .Where(c => c.CategoryID == localizedCategoriesToCreate.CategoryID).First();
                    localizedCategoriesToCreate.Language = entities.Languages.Where(l => l.LanguageID == localizedCategoriesToCreate.LanguageID).First();
                    localizedCategoriesToCreate.SEOUrl = Utilities.ProduceUrl(localizedCategoriesToCreate.Name);

                    entities.AddToLocalizedCategories(localizedCategoriesToCreate);
                    entities.SaveChanges();

                    return RedirectToAction("Index");
                }
                catch
                {
                    ViewData["MessageEro"] = "This Category and Language are unavailable, please try with another one";
                    this.ViewData["CategoriesToCreate"] = new SelectList(entities.Categories, "CategoryID", "Description");
                    this.ViewData["LanguagesToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                    return View(localizedCategoriesToCreate);
                }
            }
            else
            {
                ViewData["MessageeEro"] = "This Category and Language are unavailable, please try with another one";
                this.ViewData["CategoriesToCreate"] = new SelectList(entities.Categories, "CategoryID", "Description");
                this.ViewData["LanguagesToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                return View(localizedCategoriesToCreate);
            }
            
        }

        //
        // GET: /LocalizedCategories/Delete/5
 
        public ActionResult Delete(int id,int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            {  ViewData["action"] = "delete";
            try
            {
                ViewData["Message"] = "Delete Localized Categories";
                LocalizedCategory localizedCategoriesToDelete = entities.LocalizedCategories.Where(lc => lc.CategoryID == id && lc.LanguageID == id2).First();

                if (localizedCategoriesToDelete != null)
                {
                    return View(localizedCategoriesToDelete);

                }
                else
                {
                    return View("LocalCError");
                }
            }
            catch { return View("LocalCError"); }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /LocalizedCategories/Delete/5

        [HttpPost]
        public ActionResult Delete(int id,int id2, FormCollection collection)
        {
            ViewData["Message"] = "Delete Localized Categories";
            LocalizedCategory localizedCategoriesToDelete = entities.LocalizedCategories.Where(lc => lc.CategoryID == id && lc.LanguageID == id2).First();
            try
            {
                // TODO: Add delete logic here
                entities.DeleteObject(localizedCategoriesToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(localizedCategoriesToDelete);
            }
        }

        //
        // GET: /LocalizedCategories/Edit/5
 
        public ActionResult Edit(int id,int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            { ViewData["action"] = "edit";
            try
            {
                ViewData["Message"] = "Edit Localized Categories";
                LocalizedCategory localizedCategoriesToEdit = entities.LocalizedCategories.Where(lc => lc.CategoryID == id && lc.LanguageID == id2).First();
                if (localizedCategoriesToEdit != null)
                {
                    return View(localizedCategoriesToEdit);
                }
                else
                {
                    return View("LocalCError");
                }
            }
            catch { return View("LocalCError"); }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /LocalizedCategories/Edit/5

        [HttpPost]
        public ActionResult Edit(int id,int id2, FormCollection collection)
        {
            ViewData["Message"] = "Edit Localized Categories";
            LocalizedCategory localizedCategoriesToEdit = entities.LocalizedCategories.Where(lc => lc.CategoryID == id && lc.LanguageID == id2).First();
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add update logic here
                    localizedCategoriesToEdit.Language = entities.Languages.Where(l => l.LanguageID == id2).First();
                    localizedCategoriesToEdit.Category = entities.Categories.Where(c => c.CategoryID == id).First();
                    UpdateModel(localizedCategoriesToEdit);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                    //return Redirect(Url.Action("Details", "Categories", new { id = id }));
                }
                catch
                {
                    return View(localizedCategoriesToEdit);
                }
            }
            else
                return View(localizedCategoriesToEdit);

        }
    }
}
