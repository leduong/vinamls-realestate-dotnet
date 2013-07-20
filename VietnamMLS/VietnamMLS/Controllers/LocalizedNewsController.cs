using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;
using VietnamMLS.Helpers;
using System.Data;
using System.Net;
using System.Web.Security;

namespace VietnamMLS.Controllers
{
    [HandleError]
    public class LocalizedNewsController : ApplicationController
    {
        VietnamMLSEntities db = new VietnamMLSEntities();
        //
        // GET: /LocalizedNews/

        [GridAction]
        public ActionResult Index()
        {
            ViewData["Message"] = "Localized News";
            if(Roles.GetRolesForUser(User.Identity.Name).First()=="admin")
                return View(new GridModel(LocalizedNewsRepository.GetAll()));
            return View(new GridModel(LocalizedNewsRepository.GetByUser(User.Identity.Name)));
        }

        //
        // GET: /LocalizedNews/Details/5

        public ActionResult Details(int newsid,int langid)
        {
            ViewData["Message"] = "Localized News Preview";
            lNews = db.LocalizedNews.Where(lNe => lNe.NewsID==newsid && lNe.LanguageID==langid).First();
            return View(lNews);
        }

        public ActionResult News(int newsid, int langid)
        {
            lNews = db.LocalizedNews.Where(lNe => lNe.NewsID == newsid && lNe.LanguageID == langid).First();
            return View(lNews);
        }        

        //
        // GET: /LocalizedNews/Create
        public void create_SelectList()
        {
            ViewData["NewsID"] = new SelectList(db.News.Where(n=>n.User.Username==User.Identity.Name), "NewsId", "NewsId");
            ViewData["LangID"] = new SelectList(db.Languages, "LanguageID", "Name");
        }
        string NewsID = "";
        public ActionResult Create()
        {
            ViewData["Message"] = "Create Localized News";
            //NewsID= System.Web.HttpContext.Current.Request.RawUrl.Substring(System.Web.HttpContext.Current.Request.RawUrl.LastIndexOf("/") + 1);
            create_SelectList();
            return View();
        } 

        //
        // POST: /LocalizedNews/Create

        [HttpPost][ValidateInput(false)]
        public ActionResult Create(LocalizedNew localNews)
        {
            NewsID = System.Web.HttpContext.Current.Request.RawUrl.Substring(System.Web.HttpContext.Current.Request.RawUrl.LastIndexOf("/") + 1);
            try
            {
                if (NewsID.ToLower() == "create")
                {
                    if (db.LocalizedNews.Where(ln => ln.NewsID == localNews.NewsID && ln.LanguageID == localNews.LanguageID).Count() > 0)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["LanguageDuplicateMessage"] = "Please choose another language for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else if (localNews.Title == null)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["NullMessage"] = "Please type the Title for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else if (db.LocalizedNews.Where(ln => ln.SEOUrl == localNews.SEOUrl).Count() > 0)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["TitleDuplicateMessage"] = "Please choose another Title for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else
                    {
                        string content = Request.Form["FckEditor1"].ToString();
                        localNews.News = db.News.Where(n => n.NewsId == localNews.NewsID).First();
                        localNews.News = db.News.Where(n => n.NewsId == localNews.NewsID).First();
                        localNews.Language = db.Languages.Where(n => n.LanguageID == localNews.LanguageID).First();
                        localNews.FullContent = content;
                        localNews.SEOUrl = Utilities.ProduceUrl(localNews.Title);
                        db.AddToLocalizedNews(localNews);
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
                else
                {
                    localNews.NewsID = int.Parse(NewsID);
                    if (db.LocalizedNews.Where(ln => ln.NewsID == localNews.NewsID && ln.LanguageID == localNews.LanguageID).Count() > 0)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["LanguageDuplicateMessage"] = "Please choose another language for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else if (localNews.Title == null)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["NullMessage"] = "Please type the Title for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else if (db.LocalizedNews.Where(ln => ln.SEOUrl == localNews.SEOUrl).Count() > 0)
                    {
                        ViewData["Message"] = "Create Localized News";
                        ViewData["TitleDuplicateMessage"] = "Please choose another Title for this News.";
                        create_SelectList();
                        return View(localNews);
                    }
                    else
                    {
                        string content = Request.Form["FckEditor1"].ToString();
                        localNews.News = db.News.Where(n => n.NewsId == localNews.NewsID).First();
                        localNews.Language = db.Languages.Where(n => n.LanguageID == localNews.LanguageID).First();
                        localNews.FullContent = content;
                        localNews.SEOUrl = Utilities.ProduceUrl(localNews.Title);
                        db.AddToLocalizedNews(localNews);
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                }
            }
            catch
            {
                create_SelectList();
                ViewData["Message"] = "Create Localized News";
                ViewData["CreatingMessage"] = "Create unsucessfully.";
                return View(localNews);
            }
        }
        


        public ActionResult Edit(int newsid, int langid)
        {
            ViewData["Message"] = "Edit Localized News";
            create_SelectList();
            lNews = db.LocalizedNews.Where(lNe => lNe.NewsID==newsid && lNe.LanguageID==langid).First();
            return View(lNews);
        }

        //
        // POST: /LocalizedNews/Edit/5

        [HttpPost][ValidateInput(false)]
        public ActionResult Edit(int newsid,int langid,FormCollection collection)
        {
            lNews = db.LocalizedNews.Where(lNe => lNe.NewsID == newsid && lNe.LanguageID == langid).First();
            try
            {
                string seoUrl = Utilities.ProduceUrl(Request.Form["txtTitle"].ToString());
                if (seoUrl == "")
                {
                    ViewData["Message"] = "Edit Localized News";
                    ViewData["NullMessage"] = "Please type the Title for this News.";
                    create_SelectList();
                    return View(lNews);
                }
                else
                {
                    string oldSEOUrl = lNews.SEOUrl;
                    lNews.SEOUrl = seoUrl;
                    db.SaveChanges();
                    if (db.LocalizedNews.Where(ln => ln.SEOUrl == seoUrl).Count() > 1)
                    {
                        lNews.SEOUrl = oldSEOUrl;
                        ViewData["Message"] = "Edit Localized News";
                        ViewData["DuplicateMessage"] = "Please choose another Title for this News.";
                        create_SelectList();
                        return View(lNews);
                    }
                    else
                    {
                        string content = Request.Form["FckEditor1"].ToString();
                        //string seoKeyword = Request.Form["txtSEOKeyword"].ToString();
                        //string seoDescription = Request.Form["txtSEODescription"].ToString();
                        string title = Request.Form["txtTitle"].ToString();
                        string tags = Request.Form["txtTags"].ToString();
                        lNews.News = db.News.Where(n => n.NewsId == newsid).First();
                        lNews.Language = db.Languages.Where(l => l.LanguageID == langid).First();
                        lNews.Title = title;
                        //lNews.SEODescription = seoDescription;
                        lNews.FullContent = content;
                        //lNews.SEOKeyword = seoKeyword;
                        lNews.Tags = tags;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
            }
            catch
            {
                create_SelectList();
                ViewData["Message"] = "Edit Localized News";
                ViewData["EditingMessage"] = "Edit unsucessfully.";
                return View(lNews);
            }
        }

        //
        // GET: /LocalizedNews/Delete/5
        LocalizedNew lNews;
        public ActionResult Delete(int newsid,int langid)
        {
            ViewData["Message"] = "Delete Localized News";
            lNews= db.LocalizedNews.Where(lNe => lNe.NewsID == newsid && lNe.LanguageID == langid).First();
            return View(lNews);
        }

        //
        // POST: /LocalizedNews/Delete/5

        [HttpPost]
        public ActionResult Delete(int newsid, int langid,FormCollection collection)
        {
            lNews = db.LocalizedNews.Where(lNe => lNe.NewsID == newsid && lNe.LanguageID == langid).First();
            try
            {
                db.DeleteObject(lNews);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                ViewData["Message"] = "Delete Localized News";
                ViewData["DeletingMessage"] = "Delete unsucessfully.";
                return View(lNews);
            }
        }
    }
}
