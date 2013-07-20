using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;
using System.Text;
using System.Data;

namespace VietnamMLS.Controllers
{
    public class HomeController : ApplicationController
    {
        VietnamMLSEntities db = new VietnamMLSEntities();

        public ActionResult Index()
        {
            int langid = int.Parse(Request.Cookies["language"].Value);
            int cityid = int.Parse(Request.Cookies["city"].Value);
            ViewData["Source"] = Load_Data(langid,cityid);
            return View(ViewData["Source"]);
        }
        protected string GetMainContent(int NewsID, int LangID)
        {
            var source = db.LocalizedNews.Where(ln => ln.NewsID == NewsID && ln.LanguageID == LangID).First();
            string s1 = source.FullContent;
            string s2 = "";
            try
            {
                int ind1 = s1.IndexOf("<strong>");
                int ind2 = s1.IndexOf(@"</strong>");
                s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
            }
            catch
            {
                s2 = s1.Substring(0,100);
            }
            return s2;
        }


        protected DataTable Load_Data(int LangID, int CityID)
        {
            var source = from n in db.News
                         join ln in db.LocalizedNews on n.NewsId equals ln.NewsID
                         where n.City.CityID == CityID
                              && ln.LanguageID == LangID
                              && n.IsApproved == true
                         orderby n.PostedDate descending
                         select new
                         {
                             n.NewsId,
                             n.MainImage,
                             n.PostedDate,
                             ln.Title,
                             ln.LanguageID,
                             ln.SEOUrl
                         };
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
        public ActionResult About()
        {
            return View();
        }
    }
}
