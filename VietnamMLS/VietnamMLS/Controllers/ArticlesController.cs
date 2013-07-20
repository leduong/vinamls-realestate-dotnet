using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;

namespace VietnamMLS.Controllers
{
    public class ArticlesController : ApplicationController
    {
        VietnamMLSEntities entities = new VietnamMLSEntities();
        //
        // GET: /Articles/

        public ActionResult Index(string titleUrl)
        {
            try
            {
                var news = entities.LocalizedNews.Where(ln => ln.SEOUrl == titleUrl).First();
                ViewData["FullContent"] = news.FullContent;
                ViewData["Date"] = news.NewsReference.CreateSourceQuery().First().PostedDate.ToString();
                ViewData["Title"] = news.Title;
                int NewsID = news.NewsID;
                ViewData["User"] = entities.News.Where(n => n.NewsId == NewsID).First().UserReference.CreateSourceQuery().First().Username;
                ViewData["TheSameCategoryNews"] = LoadOtherNews();
                return View(news);
            }
            catch
            {
                ViewData["message"] = "Article not found";
                return View("ArticleNotFound");
            }
        }

    }
}
