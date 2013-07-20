using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.Text;
using System.Xml;
using System.IO;

namespace VietnamMLS.Controllers
{
    public abstract class ApplicationController : AdminController
    {
        private VietnamMLSEntities entities = new VietnamMLSEntities();

        public VietnamMLSEntities Entities
        {
            get { return entities; }
        }
        public int LanguageID
        {
            get { return int.Parse(System.Web.HttpContext.Current.Request.Cookies["language"].Value); }
        }
        public int CityID
        {
            get { return int.Parse(System.Web.HttpContext.Current.Request.Cookies["city"].Value); }
        }
        public string strTag
        {
            get { return (System.Web.HttpContext.Current.Request.Cookies["tag"].Value.ToString()); }
        }

        public ApplicationController()
        {
            //language
            HttpCookie languageCookie = new HttpCookie("language");
            languageCookie.Expires = DateTime.Now.AddDays(7);
            if (System.Web.HttpContext.Current.Request.QueryString["languageID"] != null)
            {
                int selectedLanguageID = int.Parse(System.Web.HttpContext.Current.Request.QueryString["languageID"].ToString());
                languageCookie.Value = selectedLanguageID.ToString();
                System.Web.HttpContext.Current.Response.Cookies.Add(languageCookie);

                string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
                string urlWithoutQuery = rawUrl.Remove(rawUrl.IndexOf('?'));
                System.Web.HttpContext.Current.Response.Redirect(urlWithoutQuery);
            }
            else if (System.Web.HttpContext.Current.Request.Cookies["language"] == null)
            {
                languageCookie.Value = "1";
                System.Web.HttpContext.Current.Response.Cookies.Add(languageCookie);

            }

            //tagnews
            HttpCookie tagCookie = new HttpCookie("tag");
            tagCookie.Expires = DateTime.Now.AddSeconds(5);
            try
            {
                string currentUrl = System.Web.HttpContext.Current.Request.RawUrl;
                string titleUrl = currentUrl.Substring(currentUrl.LastIndexOf('/') + 1);
                tagCookie.Value = titleUrl.ToString();
                System.Web.HttpContext.Current.Response.Cookies.Add(tagCookie);
            }
            catch
            {
                tagCookie.Value = "null";
                System.Web.HttpContext.Current.Response.Cookies.Add(tagCookie);
            }
            

            //city
            HttpCookie cityCookie = new HttpCookie("city");
            cityCookie.Expires = DateTime.Now.AddDays(7);
            if (System.Web.HttpContext.Current.Request.QueryString["cityID"] != null)
            {
                int selectedcityID = int.Parse(System.Web.HttpContext.Current.Request.QueryString["cityID"].ToString());
                cityCookie.Value = selectedcityID.ToString();
                System.Web.HttpContext.Current.Response.Cookies.Add(cityCookie);

                string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
                string urlWithoutQuery = rawUrl.Remove(rawUrl.IndexOf('?'));
                System.Web.HttpContext.Current.Response.Redirect(urlWithoutQuery);
            }
            else if (System.Web.HttpContext.Current.Request.Cookies["city"] == null)
            {
                cityCookie.Value = "1";
                System.Web.HttpContext.Current.Response.Cookies.Add(cityCookie);
            }
            LoadResource();
            LoadLanguageImage();
            BuildCategoriesTree();
            LoadPromotedNews();
            LoadCitiesInHome();
            LoadLatestNews();
            LoadTagNews();
            //try
            //{
            //    Session["HaveTagNews"] = LoadTagNews().ToString();
            //}
            //catch {};
            GetTodayDate();
            GetCurrentTime();
        }

        public void GetTodayDate()
        {
            DateTime today=DateTime.Today;
            if (LanguageID == 2)
                ViewData["today"] = today.DayOfWeek.ToString() + ", " + String.Format("{0:MMMM dd,yyyy}", today);
            else
            {
                if(GetResources(today.DayOfWeek.ToString()).Contains("Invalid"))
                    ViewData["today"] = today.DayOfWeek.ToString() + ", " + String.Format("{0:MMMM dd,yyyy}", today);
                else
                    ViewData["today"] = GetResources(today.DayOfWeek.ToString()) + ", " + String.Format("{0:dd/MM/yyyy}", today);
            }
        }

        public void GetCurrentTime()
        {
            ViewData["curTime"] = DateTime.Now.ToShortTimeString();
        }

        string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
        private void LoadLanguageImage()
        {
            string seo = rawUrl.Substring(rawUrl.LastIndexOf('/') + 1);
            int id;
            StringBuilder sbLangImg = new StringBuilder();
            sbLangImg.AppendLine("<div class='sub-icons'>");
            if (rawUrl.Contains("Articles"))
            {
                try
                {
                    id = entities.LocalizedNews.Where(l => l.SEOUrl == seo).First().NewsID;
                    foreach (var lang in entities.Languages.Where(l => l.IsUsed == true).OrderBy(l => l.SortOrder).ToList())
                    {
                        var news = entities.LocalizedNews.Where(ln => ln.NewsID == id && ln.LanguageID == lang.LanguageID).First();

                        sbLangImg.AppendLine("<a  href='"
                            + rawUrl.Remove(rawUrl.LastIndexOf('/') + 1) + news.SEOUrl + "?languageID=" + lang.LanguageID
                            + "'><img class='rss-sub' src='/Content/Images/Languages/"
                            + lang.LanguageID + ".png'  alt='" + lang.Name + "' width=25px height=25px /></a>");
                    }
                }
                catch
                {
                    RedirectToAction("ArticleNotFound", "Articles");
                }
            }
            else if (rawUrl.Contains("Categories"))
            {
                try
                {
                    id = entities.LocalizedCategories.Where(l => l.SEOUrl == seo).First().CategoryID;

                    foreach (var lang in entities.Languages.Where(l => l.IsUsed == true).OrderBy(l => l.SortOrder).ToList())
                    {
                        var cate = entities.LocalizedCategories.Where(lc => lc.CategoryID == id && lc.LanguageID == lang.LanguageID).First();
                        sbLangImg.AppendLine("<a  href='"
                            + rawUrl.Remove(rawUrl.LastIndexOf('/') + 1) + cate.SEOUrl + "?languageID=" + lang.LanguageID
                            + "'><img class='rss-sub' src='/Content/Images/Languages/"
                            + lang.LanguageID + ".png'  alt='" + lang.Name + "' width=25px height=25px /></a>");
                    }
                }
                catch
                {
                    try
                    {
                        id = entities.LocalizedParentCategories.Where(lp => lp.SEOUrl == seo).First().ParentCategoryID;

                        foreach (var lang in entities.Languages.Where(l => l.IsUsed == true).OrderBy(l => l.SortOrder).ToList())
                        {
                            var pcate = entities.LocalizedParentCategories.Where(lp => lp.ParentCategoryID == id && lp.LanguageID == lang.LanguageID).First();
                            sbLangImg.AppendLine("<a  href='"
                                + rawUrl.Remove(rawUrl.LastIndexOf('/') + 1) + pcate.SEOUrl + "?languageID=" + lang.LanguageID
                                + "'><img class='rss-sub' src='/Content/Images/Languages/"
                                + lang.LanguageID + ".png'  alt='" + lang.Name + "' width=25px height=25px /></a>");
                        }
                    }
                    catch
                    {
                      
                    }
                }
            }
            else
            {
                foreach (var lang in entities.Languages.Where(l => l.IsUsed == true).OrderBy(l => l.SortOrder).ToList())
                {
                    sbLangImg.AppendLine("<a  href='"
                        + System.Web.HttpContext.Current.Request.Url + "?languageID=" + lang.LanguageID
                        + "'><img class='rss-sub' src='/Content/Images/Languages/"
                        + lang.LanguageID + ".png'  alt='" + lang.Name + "' width=25px height=25px /></a>");
                }
            }

            sbLangImg.AppendLine("</div>");
            ViewData["langImg"] = sbLangImg.ToString();
        }

        private void BuildCategoriesTree()
        {
            StringBuilder treeBuilder = new StringBuilder();
            treeBuilder.AppendLine("<ul>");
            bool flag = false;
            foreach (LocalizedParentCategory parent in entities.LocalizedParentCategories
                .Where(lpc => lpc.LanguageID == LanguageID && lpc.ParentCategory.City.CityID==CityID))
            {
                flag = true;
                treeBuilder.AppendLine("<li><a href='../../Categories/" + parent.SEOUrl + "'>" + parent.Name + "</a>");
                treeBuilder.AppendLine("<ul>");

                foreach (LocalizedCategory category in entities.LocalizedCategories
                    .Where(lc => lc.LanguageID == LanguageID
                        && lc.Category.ParentCategory.ParentCategoryID == parent.ParentCategoryID))
                {
                    treeBuilder.AppendLine("<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href='../../Categories/" + category.SEOUrl + "'>" + category.Name + "</a></li>");
                }
                treeBuilder.AppendLine("</ul>");
            }
            if (flag == false)
            {
                foreach (LocalizedParentCategory parent in entities.LocalizedParentCategories
                               .Where(lpc => lpc.LanguageID == 2&&lpc.ParentCategory.City.CityID==CityID))
                {
                    treeBuilder.AppendLine("<li><a href='../../Categories/" + parent.SEOUrl + "'>" + parent.Name + "</a>");
                    treeBuilder.AppendLine("<ul>");

                    foreach (LocalizedCategory category in entities.LocalizedCategories
                        .Where(lc => lc.LanguageID == 2
                            && lc.Category.ParentCategory.ParentCategoryID == parent.ParentCategoryID))
                    {
                        treeBuilder.AppendLine("<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href='../../Categories/" + category.SEOUrl + "'>" + category.Name + "</a></li>");
                    }
                    treeBuilder.AppendLine("</ul>");
                }
            }
            treeBuilder.AppendLine("</ul");

            ViewData["CategoriesTree"] = treeBuilder;
        }
        
        public void LoadCitiesInHome()
        {
            StringBuilder sbCityInHome = new StringBuilder();
            string currentCityName;
            try
            {
                currentCityName = Entities.LocalizedCities.Where(lc => lc.CityID == CityID && lc.LanguageID == LanguageID).First().Name;
            }
            catch
            {
                currentCityName = Entities.LocalizedCities.Where(lc => lc.CityID == CityID && lc.LanguageID == 2).First().Name;
            }
            sbCityInHome.AppendLine("<li><a href=''>" + currentCityName + "</a>");
            sbCityInHome.AppendLine("<ul>");

            foreach (CitiesInHome citiesInHome in entities.CitiesInHomes.OrderBy(cth => cth.SortOrder)
                .ThenBy(cth => cth.City.Description))
            {
                if (citiesInHome.IsDefault)
                {
                    try
                    {
                        LocalizedCity localcity = entities.LocalizedCities.Where(lc => lc.CityID == citiesInHome.CityID && lc.LanguageID == LanguageID).FirstOrDefault();
                        sbCityInHome.AppendLine("<li><a href='../../?cityID=" + localcity.CityID
                            + "' ; return false;>" + localcity.Name + "</a></li>");
                        
                    }
                    catch
                    {
                        LocalizedCity localcity = entities.LocalizedCities.Where(lc => lc.CityID == citiesInHome.CityID && lc.LanguageID == 1).FirstOrDefault();
                        sbCityInHome.AppendLine("<li><a href='../../?cityID=" + localcity.CityID
                            + "' ; return false;>" + localcity.Name + "</a></li>");
                    }
                }
            }
            sbCityInHome.AppendLine("</ul>");
            sbCityInHome.AppendLine("</li>");
            ViewData["cityInHome"] = sbCityInHome.ToString();
        }
        public void LoadPromotedNews()
        {
            StringBuilder sbPromote = new StringBuilder();

            sbPromote.AppendLine("<h2 class='feature-title'>" + ViewData["news"] + "</h2>");

            sbPromote.AppendLine("<div id='slideshow' class='clearfix'>");
            sbPromote.AppendLine("<ul class='slides-nav'>");
            int i = 1;
            foreach (PromotedNew pronew in entities.PromotedNews.Where(pn => pn.IsUsed == true && pn.StartedDate<=DateTime.Today && pn.EndedDate>=DateTime.Today).OrderBy(pn => pn.LevelID).ThenBy(pn => pn.NewsID).ToList())
            {
                try
                {
                    if (i == 1)
                    {
                        sbPromote.AppendLine("<li class='on clearfix' id='post-" + i + "' >");
                    }
                    else
                    {
                        sbPromote.AppendLine("<li id='post-" + i + "' class='clearfix'>");
                    }
                    sbPromote.AppendLine("<a href='#main-post-" + i + "' title='" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().Title + "'>");
                    sbPromote.AppendLine("<img src='/Content/EndUser/images/blank.gif' alt='' align='top' />");
                    sbPromote.AppendLine("</a></li>");
                    i++;
                }
                catch { }
                   if (i > 5)
                    { break; }
            }
            if (i < 5)
            {
                foreach (News news in entities.News.Where(n => n.IsApproved == true).OrderByDescending(n => n.PostedDate).ThenByDescending(n => n.NewsId).ToList())
                {
                    try
                    {
                        LocalizedNew localnews = entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault();
                        sbPromote.AppendLine("<li id='post-" + i + "' class='clearfix'>");
                        sbPromote.AppendLine("<a href='#main-post-" + i + "' title='" + localnews.Title + "'>");
                        sbPromote.AppendLine("<img src='/Content/EndUser/images/blank.gif' alt='' align='top' />");
                        sbPromote.AppendLine("</a></li>");
                        i++;
                    }
                    catch { }
                    if (i > 5)
                    {
                        break;
                    }
                }
            }
            sbPromote.AppendLine("</ul>");
            sbPromote.AppendLine("<div class='slides'>");
            sbPromote.AppendLine("<ul class='clearfix'>");
            i = 1;
            foreach (PromotedNew pronew in entities.PromotedNews.Where(pn => pn.IsUsed == true && pn.StartedDate <= DateTime.Today && pn.EndedDate >= DateTime.Today).OrderBy(pn => pn.LevelID).ThenBy(pn => pn.NewsID).ToList())
            {
                try
                {
                    string s1 = entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().FullContent; ;
                    string s2 = "";
                    try
                    {
                        int ind1 = s1.IndexOf("<strong>");
                        int ind2 = s1.IndexOf(@"</strong>");
                        s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
                    }
                    catch
                    {
                        s2 = s1.Substring(0, s1.IndexOf("."));
                    }
                    if (s2.Length > 150)
                    {
                        s2 = s2.Substring(0, 150);
                    }
                    sbPromote.AppendLine("<li id='main-post-" + i + "'><a href='/Articles/" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().SEOUrl + "' title='" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().Title + "'>");
                    sbPromote.AppendLine("<img src='/Content/Images/NewsImages/" + i + ".jpg' alt='" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().Title + "' class='large' width='540px' height='280px'/></a>");
                    sbPromote.AppendLine("<div class='entry'>"
                                        + "<h2 class='post-title'>"
                                        + "<a href='/Articles/" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().SEOUrl + "' rel='bookmark' title='" + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().Title + "'>"
                                        + entities.LocalizedNews.Where(ln => ln.NewsID == pronew.NewsID && ln.LanguageID == LanguageID).FirstOrDefault().Title + "</a></h2>"
                                        + "<p>" + s2 + "..." + "</p>"
                                        + "</div></li>");
                    i++;
                }
                catch { }
                if (i > 5)
                { break; }
            }
            if (i < 5)
            {
                foreach (News news in entities.News.Where(n => n.IsApproved == true).OrderByDescending(n => n.PostedDate).ThenByDescending(n => n.NewsId).ToList())
                {
                    try
                    {
                        string s1 = entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().FullContent;
                        string s2 = "";
                        try
                        {
                            int ind1 = s1.IndexOf("<strong>");
                            int ind2 = s1.IndexOf(@"</strong>");
                            s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
                        }
                        catch
                        {
                            s2 = s1.Substring(0, s1.IndexOf("."));
                        }
                        if (s2.Length > 150)
                        {
                            s2 = s2.Substring(0, 150);
                        }
                        sbPromote.AppendLine("<li id='main-post-" + i + "'><a href='/Articles/" + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().SEOUrl + "' title='" + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().Title + "'>");
                        sbPromote.AppendLine("<img src='/Content/Images/NewsImages/" + i + ".jpg' alt='" + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().Title + "' class='large' width='540px' height='280px'/></a>");
                        sbPromote.AppendLine("<div class='entry'>"
                                            + "<h2 class='post-title'>"
                                            + "<a href='/Articles/" + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().SEOUrl + "' rel='bookmark' title='" + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().Title + "'>"
                                            + entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault().Title + "</a></h2>"
                                            + "<p>" + s2 + "..." + "</p>"
                                            + "</div></li>");
                        i++;
                    }
                    catch { }
                  
                    if (i > 5)
                    { break; }
                }

            }
            sbPromote.AppendLine("</ul></div></div>");

            ViewData["PromotedNews"] = sbPromote.ToString();
        }

        public void LoadLatestNews()
        {
            StringBuilder sbLatestNews = new StringBuilder();
            
            sbLatestNews.Append("<div >"
                                + "<ul >");
            int i = 0;
            foreach (News lastestNews in entities.News.Where(ln => ln.IsApproved == true).OrderByDescending(ln => ln.PostedDate).ThenByDescending(ln => ln.NewsId))
            {
                
                    if (i < 10)
                    {
                        try
                        {
                            sbLatestNews.Append("<a href='/Articles/" + entities.LocalizedNews.Where(lc => lc.LanguageID == LanguageID && lc.NewsID == lastestNews.NewsId).First().SEOUrl + "'>" + entities.LocalizedNews.Where(lc => lc.LanguageID == LanguageID && lc.NewsID == lastestNews.NewsId).First().Title + "</a><br/>" + lastestNews.PostedDate + "<br/>");
                        }
                        catch { }
                        i++;
                    }
                    else
                    {
                        break;
                    }
                
               
            }
            sbLatestNews.Append("</ul></div>");
            ViewData["lastestNews"] = sbLatestNews.ToString();
        }
        public void LoadTagNews()
        {
            try
            {
                LocalizedNew localnews = entities.LocalizedNews.Where(ln => ln.SEOUrl == strTag).FirstOrDefault();
                StringBuilder sbTagNews = new StringBuilder();
                sbTagNews.Append("<div >"
                                   + "<ul >");
                int i = 0;
                foreach (News news in entities.News.Where(n => n.IsApproved == true && n.NewsId != localnews.NewsID).OrderByDescending(n => n.PostedDate).ThenByDescending(n => n.NewsId))
                {
                    if (i < 5)
                    {
                        try
                        {
                            LocalizedNew tagNews = entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID).FirstOrDefault();
                            if (tagNews.Tags.ContainsWord(localnews.Tags))
                            {
                                sbTagNews.Append("<a href='/Articles/" + tagNews.SEOUrl + "'>" + tagNews.Title + "</a><br/>" + news.PostedDate + "<br/>");
                                i++;
                            }
                        }
                        catch { }
                    }
                    else { break; }
                }
                sbTagNews.Append("</ul></div>");
                ViewData["tagNews"] = sbTagNews.ToString();
            }
            catch {}
        }

        public string LoadOtherNews()
        {
            StringBuilder sbOtherNews = new StringBuilder();
            sbOtherNews.Append("<div >"
                                   + "<ul >");
            try
            {
                string TitleUrl = rawUrl.Substring(rawUrl.LastIndexOf('/') + 1);
                int NewsID = int.Parse(entities.LocalizedNews.Where(ln => ln.SEOUrl == TitleUrl).First().NewsID.ToString());
                int CategoryID = entities.News.Where(n => n.NewsId == NewsID).First().CategoryReference.CreateSourceQuery().First().CategoryID;

                foreach (News news in entities.News.Where(n => n.IsApproved == true && n.Category.CategoryID == CategoryID && n.NewsId != NewsID && n.City.CityID == CityID))
                {
                    try
                    {
                        foreach (LocalizedNew lnews in entities.LocalizedNews.Where(ln => ln.NewsID == news.NewsId && ln.LanguageID == LanguageID))
                        {
                            sbOtherNews.Append("<a href='/Articles/" + lnews.SEOUrl + "'>" + lnews.Title + "</a><br/>" + news.PostedDate + "<br/>");
                        }
                    }
                    catch { }
                }
                sbOtherNews.Append("</ul></div>");
                return sbOtherNews.ToString();
            }
            catch
            {
                sbOtherNews.Append("</ul></div>");
                return sbOtherNews.ToString();
            }
        }

        public string GetResources(string id)
        {
            try
            {
                Language lang = entities.Languages.Where(l => l.LanguageID == LanguageID).FirstOrDefault();
                string resource = "Null";
                XmlDocument doc = new XmlDocument();
                doc.Load(AppDomain.CurrentDomain.BaseDirectory + "\\Content\\Language." + lang.LanguageCode + ".xml");
                XmlNodeList list = doc.ChildNodes[1].ChildNodes;
                int m = list.Count;
                for (int i = 0; i < m; i++)
                {
                    if (doc.ChildNodes[1].ChildNodes[i].Name == id)
                    {
                        resource = doc.ChildNodes[1].ChildNodes[i].InnerText;
                        break;
                    }

                }
                if (resource == "Null")
                {
                    resource = "Invalid";
                    doc.Load(AppDomain.CurrentDomain.BaseDirectory + "\\Content\\Language." + lang.LanguageCode + ".xml");
                    //doc.Load(Server.MapPath(@"Language." + lang.LanguageCode + ".xml"));
                    for (int i = 0; i < m; i++)
                    {
                        if (doc.ChildNodes[1].ChildNodes[i].Name == id)
                        {
                            resource = doc.ChildNodes[1].ChildNodes[i].InnerText;
                            break;
                        }
                    }

                }
                return resource;
            }
            catch
            {
                Language lang = entities.Languages.Where(l => l.LanguageID == 2).FirstOrDefault();
                string resource = "Null";
                XmlDocument doc = new XmlDocument();
                doc.Load(AppDomain.CurrentDomain.BaseDirectory + "\\Content\\Language." + lang.LanguageCode + ".xml");
                XmlNodeList list = doc.ChildNodes[1].ChildNodes;
                int m = list.Count;
                for (int i = 0; i < m; i++)
                {
                    if (doc.ChildNodes[1].ChildNodes[i].Name == id)
                    {
                        resource = doc.ChildNodes[1].ChildNodes[i].InnerText;
                        break;
                    }

                }
                if (resource == "Null")
                {
                    resource = "Invalid";
                    doc.Load(AppDomain.CurrentDomain.BaseDirectory + "\\Content\\Language." + lang.LanguageCode + ".xml");
                    //doc.Load(Server.MapPath(@"Language." + lang.LanguageCode + ".xml"));
                    for (int i = 0; i < m; i++)
                    {
                        if (doc.ChildNodes[1].ChildNodes[i].Name == id)
                        {
                            resource = doc.ChildNodes[1].ChildNodes[i].InnerText;
                            break;
                        }
                    }

                }
                return resource;
            }
        }
        public void LoadResource()
        {
            ViewData["about"] = GetResources("about");
            ViewData["optioncolor"] = GetResources("optioncolor");
            ViewData["default"] = GetResources("default");
            ViewData["blue"] = GetResources("blue");
            ViewData["green"] = GetResources("green");
            ViewData["pink"] = GetResources("pink");
            ViewData["plum"] = GetResources("plum");
            ViewData["red"] = GetResources("red");
            ViewData["rust"] = GetResources("rust");
            ViewData["turquoise"] = GetResources("turquoise");
            ViewData["news"] = GetResources("news");
            ViewData["sitesearch"] = GetResources("sitesearch");
            ViewData["entersearchterm"] = GetResources("entersearchterm");
            ViewData["search"] = GetResources("search");
            ViewData["first"] = GetResources("first");
            ViewData["previous"] = GetResources("previous");
            ViewData["page"] = GetResources("page");
            ViewData["next"] = GetResources("next");
            ViewData["last"] = GetResources("last");
            ViewData["searchnull"] = GetResources("searchnull");
            ViewData["searchresult"] = GetResources("searchresult");
            ViewData["othernews"] = GetResources("othernews");
            ViewData["categories"] = GetResources("categories");
            ViewData["tag"] = GetResources("tagnews");
            ViewData["lastnews"] = GetResources("lastnews");
        }
    }
}