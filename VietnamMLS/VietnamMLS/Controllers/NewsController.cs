using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.IO;
using Telerik.Web.Mvc;
using System.Drawing;
using System.Web.Security;
using System.Text;

namespace VietnamMLS.Controllers
{
    public class NewsController : AdminController
    {
        VietnamMLSEntities db = new VietnamMLSEntities();

        // GET: /News/
        [GridAction]
        public ActionResult Index()
        {
            ViewData["Message"] = "News Index Viewer";
            ViewData["id"] = 1;
            if (Roles.GetRolesForUser(User.Identity.Name).First()=="admin")
                return View(new GridModel(NewsModelReposiroty.GetAll()));
            return View(new GridModel(NewsModelReposiroty.GetByUser(User.Identity.Name)));
        }

        //
        // GET: /News/Details/5

        public ActionResult Details(int id)
        {
            ViewData["Message"] = "News Detail";
            News ne = db.News.Where(n=>n.NewsId==id).First();
            return View(ne);
        }

        [GridAction]
        public ActionResult GetLocalizedNewsByNewsID(int id)
        {
            return View(new GridModel(LocalizedNewsRepository.GetByNewsID(id)));
        }


        //
        // GET: /News/Create
        public void create_SelectList()
        {
            ViewData["Message"] = "Create new News";
            ViewData["CateIDs"] = new SelectList(db.Categories, "CategoryID", "Description");
            ViewData["CityIDs"] = new SelectList(db.Cities, "CityID", "Description");
            ViewData["ParentIDs"] = new SelectList(db.ParentCategories, "ParentCategoryID", "Description");
        }
        public ActionResult Create()
        {
            ViewData["Message"] = "Create new News";
            create_SelectList();
            return View();
        }

        [HttpPost]
        public ActionResult GetParentCateByCity(int CityID)
        {
            ViewData["ParentIDs"] = new SelectList(
                db.ParentCategories.Where(p=>p.City.CityID==CityID), "ParentCategoryID", "Description");
            return View(ViewData["ParentIDs"]);
        }

        //
        // POST: /News/Create
        [HttpPost]
        public ActionResult Create(News ne)
        {
            ViewData["Message"] = "Create new News";
            try
            {
                int CateId = int.Parse(Request.Form["CateID"].ToString());
                int ParentId = int.Parse(Request.Form["ParentID"].ToString());
                int UserId = db.Users.Where(u => u.Username == User.Identity.Name).First().UserID;
                int CityId = int.Parse(Request.Form["CityID"].ToString());
                DateTime CreatedDate = DateTime.Today;
                if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                {
                    DateTime PostedDate = DateTime.Parse(Request.Form["PostedDate"].ToString());
                    if (PostedDate < CreatedDate)
                    {
                        ViewData["InvalidDate"] = "The PostedDate must be equal or larger than The CreatedDate.";
                        return View(ne);
                    }
                    else
                    {
                        ne.Category = db.Categories.Where(c => c.CategoryID == CateId).First();
                        ne.ParentCategory = db.ParentCategories.Where(p => p.ParentCategoryID == ParentId).First();
                        ne.City = db.Cities.Where(ci => ci.CityID == CityId).First();
                        ne.User = db.Users.Where(u => u.UserID == UserId).First();
                        ne.PostedDate = PostedDate;
                        ne.CreatedDate = CreatedDate;

                        db.AddToNews(ne);
                        db.SaveChanges();
                        ne.MainImage = ne.NewsId + ".jpg";
                        db.SaveChanges();

                        try
                        {
                            HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                            Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                        }
                        catch
                        {
                            Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                            i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                        }
                        //Session["NewsID1"] = ne.NewsId.ToString();
                        return RedirectToAction("Index");
                        //return RedirectToAction("Create", "LocalizedNews");
                    }
                }
                else
                {
                    ne.Category = db.Categories.Where(c => c.CategoryID == CateId).First();
                    ne.ParentCategory = db.ParentCategories.Where(p => p.ParentCategoryID == ParentId).First();
                    ne.City = db.Cities.Where(ci => ci.CityID == CityId).First();
                    ne.User = db.Users.Where(u => u.UserID == UserId).First();
                    ne.CreatedDate = CreatedDate;

                    db.AddToNews(ne);
                    db.SaveChanges();
                    ne.MainImage = ne.NewsId + ".jpg";
                    db.SaveChanges();

                    try
                    {
                        HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                        Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                    }
                    catch
                    {
                        Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                        i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                    }
                    //Session["NewsID1"] = ne.NewsId.ToString();
                    return RedirectToAction("Index");
                }
            }
            catch
            {
                create_SelectList();
                ViewData["CreatingMessage"] = "Create unsucessfully.";
                return View(ne);
            }
        }
        //
        // GET: /News/Edit/5
        public ActionResult Edit(int id)
        {
            ViewData["Message"] = "Edit News";

            create_SelectList();
            News ne = db.News.Where(n => n.NewsId == id).First();            
            ViewData["CateIDs"] = new SelectList(db.Categories, "CategoryID", "Description",ne.CategoryReference.CreateSourceQuery().First().CategoryID);
            ViewData["CityIDs"] = new SelectList(db.Cities, "CityID", "Description",ne.CityReference.CreateSourceQuery().First().CityID);
            ViewData["ParentIDs"] = new SelectList(db.ParentCategories, "ParentCategoryID", "Description",ne.ParentCategoryReference.CreateSourceQuery().First().ParentCategoryID);
            return View(ne);
        }

        //
        // POST: /News/Edit/5

        [HttpPost]
        public ActionResult Edit(int id,FormCollection collection)
        {
            ViewData["Message"] = "Edit News";
            News ne = db.News.Where(n => n.NewsId == id).First();
            try
            {
                int CateId = int.Parse(Request.Form["CateID"].ToString());
                int ParentId = int.Parse(Request.Form["ParentID"].ToString());
                int UserId = db.Users.Where(u=>u.Username==User.Identity.Name).First().UserID;
                int CityId = int.Parse(Request.Form["CityID"].ToString());

                if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                {
                    DateTime PostedDate = DateTime.Parse(Request.Form["PostedDate"].ToString());
                    DateTime CreatedDate = (DateTime)db.News.Where(n => n.NewsId == id).First().CreatedDate;
                    if (PostedDate < CreatedDate)
                    {
                        ViewData["InvalidDate"] = "The PostedDate must be equal or larger than The CreatedDate.";
                        ViewData["CateIDs"] = new SelectList(db.Categories, "CategoryID", "Description", ne.CategoryReference.CreateSourceQuery().First().CategoryID);
                        ViewData["CityIDs"] = new SelectList(db.Cities, "CityID", "Description", ne.CityReference.CreateSourceQuery().First().CityID);
                        ViewData["ParentIDs"] = new SelectList(db.ParentCategories, "ParentCategoryID", "Description", ne.ParentCategoryReference.CreateSourceQuery().First().ParentCategoryID);
                        return View(ne);
                    }
                    else
                    {
                        ne.Category = db.Categories.Where(c => c.CategoryID == CateId).First();
                        ne.ParentCategory = db.ParentCategories.Where(p => p.ParentCategoryID == ParentId).First();
                        ne.City = db.Cities.Where(ci => ci.CityID == CityId).First();
                        ne.User = db.Users.Where(u => u.UserID == UserId).First();

                        //ne.CreatedDate = CreatedDate;
                        ne.PostedDate = PostedDate;
                        UpdateModel(ne);
                        db.SaveChanges();

                        HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                        if (ne.MainImage != null)
                        {
                            if (file.ContentLength > 0)
                            {
                                Utilities.DeleteImage("NewsImages\\" + ne.MainImage);
                                try
                                {
                                    Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                                }
                                catch
                                {
                                    Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                                    i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                                }
                            }
                        }
                        else
                        {
                            ne.MainImage = ne.NewsId + ".jpg";
                            db.SaveChanges();
                            try
                            {
                                Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                            }
                            catch
                            {
                                Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                                i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                            }
                        }


                        return View("Index");
                    }
                }
                else 
                {
                    ne.Category = db.Categories.Where(c => c.CategoryID == CateId).First();
                    ne.ParentCategory = db.ParentCategories.Where(p => p.ParentCategoryID == ParentId).First();
                    ne.City = db.Cities.Where(ci => ci.CityID == CityId).First();
                    ne.User = db.Users.Where(u => u.UserID == UserId).First();

                    //ne.CreatedDate = CreatedDate;
                    //ne.PostedDate = PostedDate;
                    UpdateModel(ne);
                    db.SaveChanges();

                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                    if (ne.MainImage != null)
                    {
                        if (file.ContentLength > 0)
                        {
                            Utilities.DeleteImage("NewsImages\\" + ne.MainImage);
                            try
                            {
                                Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                            }
                            catch
                            {
                                Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                                i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                            }
                        }
                    }
                    else
                    {
                        ne.MainImage = ne.NewsId + ".jpg";
                        db.SaveChanges();
                        try
                        {
                            Utilities.SaveImage(file, "NewsImages\\" + ne.MainImage);
                        }
                        catch
                        {
                            Image i = Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\Default.jpg");
                            i.Save(AppDomain.CurrentDomain.BaseDirectory + @"\Content\Images\NewsImages\" + ne.MainImage);
                        }
                    }
                    return View("Index");
                }
            }
            catch
            {
                ViewData["CateIDs"] = new SelectList(db.Categories, "CategoryID", "Description", ne.CategoryReference.CreateSourceQuery().First().CategoryID);
                ViewData["CityIDs"] = new SelectList(db.Cities, "CityID", "Description", ne.CityReference.CreateSourceQuery().First().CityID);
                ViewData["ParentIDs"] = new SelectList(db.ParentCategories, "ParentCategoryID", "Description", ne.ParentCategoryReference.CreateSourceQuery().First().ParentCategoryID);
                ViewData["EditingMessage"] = "Edit unsucessfully.";
                return View(ne);
            }
        }
        // GET: /News/Delete/5
 
        public ActionResult Delete(int id)
        {
            ViewData["Message"] = "Delete News";

            News ne = db.News.Where(n => n.NewsId == id).First();
            return View(ne);
        }

        //
        // POST: /News/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete News";

            News ne = db.News.Where(n => n.NewsId == id).First();
            try
            {
                db.DeleteObject(ne);
                Utilities.DeleteImage(@"\Content\Images\NewsImages\\" + ne.MainImage);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                create_SelectList();
                ViewData["DeletingMessage"] = "Delete unsucessfully.";
                return View(ne);
            }
        }
    }
}
