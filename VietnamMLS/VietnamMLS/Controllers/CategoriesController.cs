using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.IO;
using Telerik.Web.Mvc;
using System.Drawing;
using System.Data;

namespace VietnamMLS.Controllers
{
    
    public class CategoriesController : ApplicationController
    {
        //
        // GET: /Categories/

        VietnamMLSEntities entities = new VietnamMLSEntities();
        [GridAction, Authorize]
        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Category Index Viewer";
                return View(new GridModel(CategoryRepository.GetAll()));
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

        protected string GetMainContent(int NewsID, int LangID)
        {
            var source = db.LocalizedNews.Where(ln => ln.NewsID == NewsID && ln.LanguageID == LangID).First();
            string s1 = source.FullContent;
            string s2 = "";
            int ind1 = s1.IndexOf("<strong>");
            int ind2 = s1.IndexOf(@"</strong>");
            s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
            return s2;
        }
        VietnamMLS.Models.VietnamMLSEntities db = new VietnamMLS.Models.VietnamMLSEntities();

        protected DataTable Load_Data(string cateName)
        {
            int LangID = int.Parse(Request.Cookies["language"].Value);
            string currentUrl = System.Web.HttpContext.Current.Request.RawUrl;
            var source = (from lcate in entities.LocalizedCategories
                          join cate in entities.Categories on lcate.CategoryID equals cate.CategoryID
                          join pcate in entities.ParentCategories on cate.ParentCategory.ParentCategoryID equals pcate.ParentCategoryID
                          join lpcate in entities.LocalizedParentCategories on pcate.ParentCategoryID equals lpcate.ParentCategoryID
                          join news in entities.News on cate.CategoryID equals news.Category.CategoryID
                          join lnews in entities.LocalizedNews on news.NewsId equals lnews.NewsID
                          where (lcate.SEOUrl == cateName || lpcate.SEOUrl == cateName) && lnews.LanguageID == LangID
                              && news.City.CityID == CityID && news.IsApproved == true
                          select new
                          {
                              news.NewsId,
                              news.MainImage,
                              news.PostedDate,
                              lnews.Title,
                              lnews.LanguageID,
                              lnews.SEOUrl
                          }).Distinct();

            System.Data.DataTable dt = new System.Data.DataTable();
            dt.Columns.Add("NewsId");
            dt.Columns.Add("LanguageID");
            dt.Columns.Add("MainImage");
            dt.Columns.Add("PostedDate");
            dt.Columns.Add("Title");
            dt.Columns.Add("Sumary");
            dt.Columns.Add("SEOUrl");
            System.Data.DataRow row;
            foreach (var s in source)
            {
                row = dt.NewRow();
                row[0] = s.NewsId;
                row[1] = s.LanguageID;
                row[2] = s.MainImage;
                row[3] = s.PostedDate;
                row[4] = s.Title;
                row[5] = GetMainContent((int)s.NewsId, (int)s.LanguageID);
                row[6] = s.SEOUrl;
                dt.Rows.Add(row);
            }
            return dt;
        }
        //
        // GET: /Categories/Details/5
        public ActionResult GetNewsByCategory(string name)
        {
            ViewData["Source"] = Load_Data(name);
            return View(ViewData["Source"]);
        }
        [Authorize]
        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                 ViewData["action"] = "get detail";
                try
                {
                ViewData["Message"]="Categories Details";
                ViewData["CategoryName"] = entities.Categories.Where(c => c.CategoryID == id).FirstOrDefault().Description;
                return View();
                }
                catch
                {
                    return View("CategoryError");
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
            return View(new GridModel(LocalizedCategoryRepository.GetByID(id)));
        }
        //
        // GET: /Categories/Create

        [Authorize]
        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create new category";
                this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Categories/Create

        [HttpPost,Authorize]
        public ActionResult Create(Category categoriesToCreate)
        {
            int parentCtgID = int.Parse(Request.Form["ParentCategoryID"]);
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    categoriesToCreate.ParentCategory = entities.ParentCategories.Where(pc => pc.ParentCategoryID == parentCtgID).First();
                    entities.AddToCategories(categoriesToCreate);
                    entities.SaveChanges();
                    categoriesToCreate.DefaultImage = categoriesToCreate.CategoryID + ".jpg";
                    entities.SaveChanges();
                    //Save Image
                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                    Utilities.SaveImage(file, @"Categories/" + categoriesToCreate.DefaultImage, 100, 100);

                    return RedirectToAction("Index");
                }
                catch
                {
                    this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
                    return View(categoriesToCreate);
                }
            }
            this.ViewData["ParentCategoriesToCreate"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description");
            return View(categoriesToCreate);
        }

        //
        // GET: /Categories/Delete/5
        [Authorize]
        public ActionResult Delete(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {ViewData["action"] = "delete";
                try
                {
                    if (id != null)
                    {
                        ViewData["Message"] = "Delete Category: " + id.ToString();
                        Category categoriesToDelete = entities.Categories.Where(c => c.CategoryID == id).FirstOrDefault();
                        if (categoriesToDelete == null)
                        {
                            return View("CategoryError");
                        }
                        else
                        {
                            return View(categoriesToDelete);
                        }
                    }
                    else
                    {
                        return View("CategoryError");
                    }
                }
                catch
                {
                    return View("CategoryError");
                }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Categories/Delete/5

        [HttpPost,Authorize]
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete Category";
            Category categoriesToDelete = entities.Categories.Where(c => c.CategoryID == id).FirstOrDefault();
            try
            {
                // TODO: Add delete logic here
                FileInfo file = new FileInfo(Server.MapPath(@"/Content/Images/Categories/" + categoriesToDelete.DefaultImage));
                file.Delete();
                entities.DeleteObject(categoriesToDelete);
                entities.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View(categoriesToDelete);
            }
        }

        //
        // GET: /Categories/Edit/5
        [Authorize]
        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["action"] = "edit";
                try
                {
                    if (id != null)
                    {
                        ViewData["Message"] = "Edit Category: " + id.ToString();
                        Category categoriesToEdit = entities.Categories.Where(c => c.CategoryID == id).FirstOrDefault();
                        if (categoriesToEdit != null)
                        {
                            this.ViewData["ParentCategoriesToEdit"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description", categoriesToEdit.ParentCategoryReference.EntityKey.EntityKeyValues.First().Value);
                            return View(categoriesToEdit);
                        }
                        else
                        {
                            return View("CategoryError");
                        }
                    }
                    else
                    { return View("CategoryError"); }
                }
                catch
                {
                    return View("CategoryError");
                }
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Categories/Edit/5

        [HttpPost,Authorize]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit Category";

            Category categoriesToEdit = entities.Categories.Where(c => c.CategoryID == id).FirstOrDefault();
            int parentCtgID = int.Parse(Request.Form["ParentCategoryID"]);
            try
            {
                // TODO: Add update logic here
                categoriesToEdit.ParentCategory = entities.ParentCategories.Where(pc => pc.ParentCategoryID == parentCtgID).First();
                UpdateModel(categoriesToEdit);
                if (categoriesToEdit.DefaultImage != null)
                    Utilities.DeleteImage(@"Categories/" + categoriesToEdit.DefaultImage);
                else
                    categoriesToEdit.DefaultImage = categoriesToEdit.CategoryID + ".jpg";
                entities.SaveChanges();
                HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                try
                {
                    Utilities.SaveImage(file, @"Categories/" + categoriesToEdit.DefaultImage, 100, 100);
                }
                catch
                {
                    Image i = Image.FromFile(Server.MapPath(@"\Content\Images\NewsImages\Default.jpg"));
                    i.Save(Server.MapPath(@"\Content\Images\Categories\") + categoriesToEdit.DefaultImage);
                }
                return RedirectToAction("Index");
            }
            catch
            {
                this.ViewData["ParentCategoriesToEdit"] = new SelectList(entities.ParentCategories, "ParentCategoryID", "Description", categoriesToEdit.ParentCategoryReference.EntityKey.EntityKeyValues.First().Value);

                return View(categoriesToEdit);
            }
        }
    }
}
