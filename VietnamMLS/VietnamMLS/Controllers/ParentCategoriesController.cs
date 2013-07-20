
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
    public class ParentCategoriesController : AdminController
    {
        //
        // GET: /ParentCategories/
        VietnamMLSEntities entities = new VietnamMLSEntities();

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Parent Caterogies Index Viewer";
                return View(ParentCategoryRepository.GetAll());
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
                ViewData["Message"] = "Parent Caterogies Index Viewer";
                return View(new GridModel(ParentCategoryRepository.GetAll()));
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
        public ActionResult GetCategories(int parentID)
        {
            return View(new GridModel<CategoryModel>(CategoryRepository.GetByParentID(parentID)));
        }

        //

        // GET: /ParentCategories/Details/5

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "get detail";
                try
                {
                    ViewData["Message"] = "Detail Parent Caterogies";
                    return View(ParentCategoryRepository.GetByID(id));
                    //ViewData["ParentName"] = entities.ParentCategories
                    //    .Where(p => p.ParentCategoryID == id)
                    //    .FirstOrDefault()
                    //    .Description;        

                    //return View();
                }
                catch {                                       
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
            return View(new GridModel(LocalizedParentCategoryRepository.GetByID(id)));
        }
        [GridAction]
        public ActionResult GetCategoryByID(int id)
        {
            return View(new GridModel(CategoryRepository.GetByParentID(id)));
        }
        //
        // GET: /ParentCategories/Create
      
        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new Parent Caterogies";
                this.ViewData["CitiesToCreate"] = new SelectList(entities.Cities.ToList(), "CityID", "Description");
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        } 

        //
        // POST: /ParentCategories/Create

        [HttpPost]
        public ActionResult Create(ParentCategory parentCategoriesToCreate )
        {
            ViewData["Message"] = "Create new Parent Caterogies";
            
            int CityID = int.Parse(Request.Form["CityID"]);
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    parentCategoriesToCreate.City = (from c in entities.Cities where c.CityID == CityID select c).First();
                    entities.AddToParentCategories(parentCategoriesToCreate);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    this.ViewData["CitiesToCreate"] = new SelectList(entities.Cities.ToList(), "CityID", "Description");
                    return View(parentCategoriesToCreate);
                }
            }
            else
            {
                this.ViewData["CitiesToCreate"] = new SelectList(entities.Cities.ToList(), "CityID", "Description");
                return View(parentCategoriesToCreate);
            }
            
        }

        //
        // GET: /ParentCategories/Delete/5
 
        public ActionResult Delete(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "delete";
                try
                {
                    if (id != null)
                    {
                        ViewData["Message"] = "Delete Parent Caterogies: " + id.ToString();
                        ParentCategory parentCategoriesToDelete = entities.ParentCategories.Where(p => p.ParentCategoryID == id).FirstOrDefault();
                        if (parentCategoriesToDelete == null)
                        {
                            return View("Error");
                        }
                        else
                        {
                            return View(parentCategoriesToDelete);
                        }
                    }
                    else {
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
        // POST: /ParentCategories/Delete/5

        [HttpPost]        
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete Parent Caterogies";
            ParentCategory parentCategoriesToDelete = entities.ParentCategories.Where(p => p.ParentCategoryID == id).FirstOrDefault();
            try
            {
                entities.DeleteObject(parentCategoriesToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                Response.Write("<script>alert('go to hell')</script>");
                return View(parentCategoriesToDelete);
            }
        }

        //
        // GET: /ParentCategories/Edit/5

        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "edit";
                try
                {
                    if (id != null)
                    {
                        ViewData["Message"] = "Edit Parent Caterogies: " + id.ToString();
                        ParentCategory parentCategoriesToEdit = entities.ParentCategories.Where(p => p.ParentCategoryID == id).FirstOrDefault();
                        if (parentCategoriesToEdit != null)
                        {
                            this.ViewData["CitiesToEdit"] =
                                new SelectList(entities.Cities.ToList(),
                                    "CityID", "Description",
                                    parentCategoriesToEdit.CityReference.CreateSourceQuery().First().CityID);
                            return View(parentCategoriesToEdit);
                        }
                        else
                        {
                            return View("Error");
                        }
                    }
                    else
                    { return View("Error"); }
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
        // POST: /ParentCategories/Edit/5

        [HttpPost]
        [GridAction]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit Parent Caterogies";

            ParentCategory parentCategoriesToEdit = entities.ParentCategories.Where(p => p.ParentCategoryID == id).FirstOrDefault();
            int cityID = int.Parse(Request.Form["CityID"]);
            if (ModelState.IsValid)
            {
                try
                {
                    parentCategoriesToEdit.City = entities.Cities.Where(c => c.CityID == cityID).First();
                    UpdateModel(parentCategoriesToEdit);
                    entities.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch
                {
                    this.ViewData["CitiesToEdit"] = new SelectList(entities.Cities.ToList(), "CityID", "Description", parentCategoriesToEdit.CityReference.CreateSourceQuery().First().CityID);
                    return View(parentCategoriesToEdit);
                }
            }
            else
            {
                this.ViewData["CitiesToEdit"] = new SelectList(entities.Cities.ToList(), "CityID", "Description", parentCategoriesToEdit.CityReference.CreateSourceQuery().First().CityID);
                return View(parentCategoriesToEdit);
            }
        }
    }
}
