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
    public class LocalizedParentCategoriesController : AdminController
    {
        //
        // GET: /LocalizedParentCategories/
        VietnamMLSEntities entities = new VietnamMLSEntities();

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Localized Parent Categories Index Viewer";
                //return View(entities.LocalizedParentCategories.ToList());
                return View(LocalizedParentCategoryRepository.GetAll());
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
                ViewData["Message"] = "Localized Parent Categories Index Viewer";
                //return View(entities.LocalizedParentCategories.ToList());
                return View(new GridModel(LocalizedParentCategoryRepository.GetAll()));
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
        // GET: /LocalizedParentCategories/Details/5

        public ActionResult Details(int id, int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Detail Localized Parent Categories";
                LocalizedParentCategory lpcToDetails = entities.LocalizedParentCategories.Where(lpc => lpc.ParentCategoryID == id && lpc.LanguageID == id2).FirstOrDefault();
                return View(lpcToDetails);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // GET: /LocalizedParentCategories/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new Localized Parent Categories";
                this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
                this.ViewData["LanguageToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        } 

        //
        // POST: /LocalizedParentCategories/Create

        [HttpPost]
        public ActionResult Create(LocalizedParentCategory localizedParentCategoriesToCreate)
        {
            ViewData["Message"] = "Create new Localized Parent Categories";
            
            if (ModelState.IsValid)
            {

                try
                {
                    localizedParentCategoriesToCreate.ParentCategory= (from pc in entities.ParentCategories where pc.ParentCategoryID == localizedParentCategoriesToCreate.ParentCategoryID select pc).First();
                    localizedParentCategoriesToCreate.Language = (from l in entities.Languages where l.LanguageID == localizedParentCategoriesToCreate.LanguageID select l).First();
                    localizedParentCategoriesToCreate.SEOUrl = Utilities.ProduceUrl(localizedParentCategoriesToCreate.Name);

                    entities.AddToLocalizedParentCategories(localizedParentCategoriesToCreate);
                    entities.SaveChanges();
                    
                    return RedirectToAction("Index");
                }
                catch
                {
                    ViewData["MessageEro"] = "This ParentCategory and Language are unavailable, please try with another one";
                    this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
                    this.ViewData["LanguageToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                    return View(localizedParentCategoriesToCreate);
                }
            }
            else
            {
                ViewData["MessageEro"] = "This ParentCategory and Language are unavailable, please try with another one";
                this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
                this.ViewData["LanguageToCreate"] = new SelectList(entities.Languages, "LanguageID", "Name");
                return View(localizedParentCategoriesToCreate);
            }
        }

        //
        // GET: /LocalizedParentCategories/Delete/5
 
        public ActionResult Delete(int id,int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "delete";
                try
                {
                   
                    ViewData["Message"] = "Delete Localized Parent Categories";
                    LocalizedParentCategory lpcToDelete = entities.LocalizedParentCategories.Where(lpc => lpc.ParentCategoryID == id && lpc.LanguageID == id2).FirstOrDefault();
                    if (lpcToDelete != null)
                    {
                        return View(lpcToDelete);

                    }
                    else
                    {
                        return View("LocalPCError");
                    }
                }
                catch { return View("LocalPCError"); }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /LocalizedParentCategories/Delete/5

        [HttpPost]
        public ActionResult Delete(int id,int id2, FormCollection collection)
        {
            ViewData["Message"] = "Delete Localized Parent Categories";

            LocalizedParentCategory lpcToDelete = entities.LocalizedParentCategories.Where(lpc => lpc.ParentCategoryID == id && lpc.LanguageID == id2).FirstOrDefault();
            try
            {
                // TODO: Add delete logic here
                entities.DeleteObject(lpcToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /LocalizedParentCategories/Edit/5
 
        public ActionResult Edit(int id,int id2)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "edit";
                try
                {
                    ViewData["Message"] = "Edit Localized Parent Categories";
                    LocalizedParentCategory lpcToEdit = entities.LocalizedParentCategories.Where(lpc => lpc.ParentCategoryID == id && lpc.LanguageID == id2).FirstOrDefault();
                    if (lpcToEdit != null)
                    {
                        return View(lpcToEdit);
                    }
                    else
                    {
                        return View("LocalPCError");
                    }
                }
                catch { return View("LocalPCError"); }
                
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /LocalizedParentCategories/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, int id2, FormCollection collection)
        {
            ViewData["Message"] = "Edit Localized Parent Categories";

            LocalizedParentCategory lpcToEdit = entities.LocalizedParentCategories.Where(lpc => lpc.ParentCategoryID == id && lpc.LanguageID == id2).FirstOrDefault();
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add update logic here
                    lpcToEdit.ParentCategory = entities.ParentCategories.Where(lpc => lpc.ParentCategoryID == id).First();
                    lpcToEdit.Language = entities.Languages.Where(l => l.LanguageID == id2).First();
                    UpdateModel(lpcToEdit);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {                    
                    return View(lpcToEdit);
                }
            }
            else
                return View(lpcToEdit);

        }
    }
}
