using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;
using System.Web.Security;

namespace VietnamMLS.Controllers
{
    public class PromotedNewsController : AdminController
    {
        VietnamMLSEntities db = new VietnamMLSEntities();

        // GET: /PromotedNews/
        [GridAction]
        public ActionResult Index()
        {
            if (Roles.GetRolesForUser(User.Identity.Name).First() == "admin")
                return View(new GridModel(PromotedNewsRepository.GetAll()));
            return View(new GridModel(PromotedNewsRepository.GetByUser(User.Identity.Name)));
        }

        //
        // GET: /PromotedNews/Details/5

        public ActionResult Details(int id)
        {
            proNews = db.PromotedNews.Where(pNe => pNe.NewsID == id).First();
            return View(proNews);
        }

        //
        // GET: /PromotedNews/Create

        public void Create_SelectList()
        {
            if (Roles.GetRolesForUser(User.Identity.Name).First() != "admin")
            {
                ViewData["NewsID"] = new SelectList(
                          db.LocalizedNews.Where(
                                ln => ln.News.User.Username == User.Identity.Name && ln.LanguageID == 1),
                                "NewsId", "Title");
            }
            else
            {
                ViewData["NewsID"] = new SelectList(
                                         db.LocalizedNews.Where(
                                               ln => ln.LanguageID == 1),
                                               "NewsId", "Title");
            }
        }

        public ActionResult Create()
        {
            ViewData["Message"] = "Create Promoted News";
            Create_SelectList();   
            return View();
        } 

        //
        // POST: /PromotedNews/Create

        [HttpPost]
        public ActionResult Create(PromotedNew proNe)
        {
            try
            {
                if (db.PromotedNews.Where(pn => pn.NewsID == proNe.NewsID).Count() > 0)
                {
                    Create_SelectList();
                    ViewData["DuplicateMessage"] = "Please choose another News.";
                    return View(proNe);
                }
                else if (proNe.EndedDate <= proNe.StartedDate)
                {
                    Create_SelectList();
                    ViewData["InvalidDate"] = "The EndedDate must be equal or larger than The StartedDate.";
                    return View(proNe);
                }
                else
                {
                    proNe.StartedDate = DateTime.Parse(Request.Form["StartedDate"].ToString());
                    proNe.EndedDate = DateTime.Parse(Request.Form["EndedDate"].ToString());

                    proNe.News = db.News.Where(n => n.NewsId == proNe.NewsID).First();
                    db.AddToPromotedNews(proNe);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            catch
            {
                Create_SelectList();
                ViewData["Message"] = "Create Promoted News";
                ViewData["CreatingMessage"] = "Create unsucessfully.";
                return View(proNe);
            }
        }
        
        //
        // GET: /PromotedNews/Edit/5
 
        public ActionResult Edit(int id)
        {
            ViewData["Message"] = "Edit Promoted News";
            proNews = db.PromotedNews.Where(pNe => pNe.NewsID == id).First();
            return View(proNews);
        }

        //
        // POST: /PromotedNews/Edit/5
        PromotedNew proNews;
        [HttpPost]
        public ActionResult Edit(int id,FormCollection collection)
        {
            proNews = db.PromotedNews.Where(pNe => pNe.NewsID == id).First();
            try
            {
                DateTime starteddate = DateTime.Parse(Request.Form["StartedDate"].ToString());
                DateTime endeddate = DateTime.Parse(Request.Form["EndedDate"].ToString());
                string des = Request.Form["txtDescription"].ToString();
                bool isused = bool.Parse(Request.Form["chkIsUsed"].ToString());
                int levelid = int.Parse(Request.Form["txtLevelID"].ToString());
                if (endeddate <= starteddate)
                {
                    Create_SelectList();
                    ViewData["InvalidDate"] = "The EndedDate must be equal or larger than The StartedDate.";
                    return View(proNews);
                }
                else
                {
                    proNews.IsUsed = isused;
                    proNews.Description = des;
                    proNews.StartedDate = starteddate;
                    proNews.EndedDate =endeddate;
                    proNews.LevelID = levelid;
                    db.SaveChanges();

                    return RedirectToAction("Index");
                }
            }
            catch
            {
                Create_SelectList();
                ViewData["Message"] = "Edit Promoted News";
                ViewData["EditingMessage"] = "Edit unsucessfully.";
                return View(proNews);
            }
        }
        //public ActionResult Edit(PromotedNew updatingProNews)
        //{
        //    try
        //    {
        //        if (updatingProNews.EndedDate <= updatingProNews.StartedDate)
        //        {
        //            Create_SelectList();
        //            ViewData["InvalidDate"] = "The EndedDate must be equal or larger than The StartedDate.";
        //            return View(updatingProNews);
        //        }
        //        else
        //        {
        //            proNews= db.PromotedNews.Where(pNe => pNe.NewsID == updatingProNews.NewsID).First();

        //            proNews.IsUsed = updatingProNews.IsUsed;
        //            proNews.Description = updatingProNews.Description;
        //            proNews.StartedDate = DateTime.Parse(Request.Form["StartedDate"].ToString());
        //            proNews.EndedDate = DateTime.Parse(Request.Form["EndedDate"].ToString());
        //            proNews.LevelID = updatingProNews.LevelID;
        //            db.SaveChanges();

        //            return RedirectToAction("Index");
        //        }
        //    }
        //    catch
        //    {
        //        Create_SelectList();
        //        ViewData["EditingMessage"] = "Edit unsucessfully.";
        //        return View(updatingProNews);
        //    }
        //}

        //
        // GET: /PromotedNews/Delete/5
 
        public ActionResult Delete(int id)
        {
            ViewData["Message"] = "Delete Promoted News";
            proNews = db.PromotedNews.Where(pn=>pn.NewsID==id).First();
            return View(proNews);
        }

        //
        // POST: /PromotedNews/Delete/5

        [HttpPost]
        public ActionResult Delete(int id,FormCollection collection)
        {
            try
            {
                proNews = db.PromotedNews.Where(pn => pn.NewsID == id).First();
                db.DeleteObject(proNews);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                ViewData["Message"] = "Delete Promoted News";
                ViewData["DeletingMessage"] = "Delete unsucessfully.";
                return View(proNews);
            }
        }
    }
}
