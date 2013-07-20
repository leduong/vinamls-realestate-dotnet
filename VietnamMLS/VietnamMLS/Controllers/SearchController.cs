using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.Text;
using System.Web.UI.WebControls;
using System.Data;

namespace VietnamMLS.Controllers
{
    public class SearchController : ApplicationController
    {
        //
        // GET: /Search/
        
        public ActionResult Index()
        {
            return View();
        }
        private VietnamMLSEntities entities = new VietnamMLSEntities();

        //public VietnamMLSEntities Entities
        //{
        //    get { return entities; }
        //}
        //public int LanguageID
        //{
        //    get { return int.Parse(System.Web.HttpContext.Current.Request.Cookies["language"].Value); }
        //}
        public string strSearch
        {
            get { return (System.Web.HttpContext.Current.Request.Cookies["search"].Value.ToString()); }
        }
        public int pageID
        {
            get { try { return int.Parse(System.Web.HttpContext.Current.Request.Cookies["page"].Value.ToString()); } catch { return 1; } }
        }
        public SearchController()
        {
            //language
            //HttpCookie languageCookie = new HttpCookie("language");
            //languageCookie.Expires = DateTime.Now.AddYears(50);
            //if (System.Web.HttpContext.Current.Request.QueryString["languageID"] != null)
            //{
            //    int selectedLanguageID = int.Parse(System.Web.HttpContext.Current.Request.QueryString["languageID"].ToString());
            //    languageCookie.Value = selectedLanguageID.ToString();
            //    System.Web.HttpContext.Current.Response.Cookies.Add(languageCookie);

            //    string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
            //    string urlWithoutQuery = rawUrl.Remove(rawUrl.IndexOf('?'));
            //    System.Web.HttpContext.Current.Response.Redirect(urlWithoutQuery);
            //}
            //else if (System.Web.HttpContext.Current.Request.Cookies["language"] == null)
            //{
            //    languageCookie.Value = "1";
            //    System.Web.HttpContext.Current.Response.Cookies.Add(languageCookie);

            //}
            //stringSearch
            HttpCookie searchCookie = new HttpCookie("search");
            searchCookie.Expires = DateTime.Now.AddMinutes(30);
            HttpCookie pageCookie = new HttpCookie("page");
            pageCookie.Expires = DateTime.Now.AddSeconds(3);
            if (System.Web.HttpContext.Current.Request.QueryString["search"] != null)
            {
                if (System.Web.HttpContext.Current.Request.QueryString["page"] != null)
                {
                    int selectPageID = int.Parse(System.Web.HttpContext.Current.Request.QueryString["page"].ToString());
                    pageCookie.Value = selectPageID.ToString();
                    System.Web.HttpContext.Current.Response.Cookies.Add(pageCookie);
                }
                else if (System.Web.HttpContext.Current.Request.Cookies["page"] == null)
                {
                    pageCookie.Value = "1";
                    System.Web.HttpContext.Current.Response.Cookies.Add(pageCookie);
                }

                string stringSearch = System.Web.HttpContext.Current.Request.QueryString["search"].ToString();
                searchCookie.Value = stringSearch;
                System.Web.HttpContext.Current.Response.Cookies.Add(searchCookie);

                string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
                string urlWithoutQuery = rawUrl.Remove(rawUrl.IndexOf('?'));
                System.Web.HttpContext.Current.Response.Redirect(urlWithoutQuery);
            }
            else if (System.Web.HttpContext.Current.Request.Cookies["search"] == null)
            {
                searchCookie.Value = " ";
                System.Web.HttpContext.Current.Response.Cookies.Add(searchCookie);

            }
            //pageID
            //HttpCookie pageCookie = new HttpCookie("page");
            //pageCookie.Expires = DateTime.Now.AddSeconds(3);
            //if (System.Web.HttpContext.Current.Request.QueryString["page"] != null)
            //{
            //    int selectPageID = int.Parse(System.Web.HttpContext.Current.Request.QueryString["page"].ToString());
            //    pageCookie.Value = selectPageID.ToString();
            //    System.Web.HttpContext.Current.Response.Cookies.Add(pageCookie);

                //string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
                //string urlWithoutQuery = rawUrl.Remove(rawUrl.IndexOf('?'));
                //System.Web.HttpContext.Current.Response.Redirect(urlWithoutQuery);
            //}
            //else if (System.Web.HttpContext.Current.Request.Cookies["page"] == null)
            //{
            //    pageCookie.Value = "1";
            //    System.Web.HttpContext.Current.Response.Cookies.Add(pageCookie);
            //}

            //load
            if (pageID <= 0)
            {
 
            }
            else
            {
                LoadSearchData();
            }
        }
        private void LoadSearchData()
        {           
            StringBuilder sbSearchData = new StringBuilder();
            sbSearchData.Append("<ul> <table cellpadding='0' cellspacing='0' style='width: 100%;border:1px;'>");
            string rawUrl = System.Web.HttpContext.Current.Request.RawUrl;
            string newUrl = "";
            if (rawUrl.Contains('?'))
                newUrl = rawUrl.Remove(rawUrl.IndexOf('?'));
            else
                newUrl = System.Web.HttpContext.Current.Request.Url.ToString();
            int ps, pi;
            ps = 5;
            pi = pageID;
            List<LocalizedNew> list = new List<LocalizedNew>();
            foreach (News news in entities.News.Where(n => n.IsApproved == true).OrderByDescending(n => n.PostedDate))
            {
                foreach (LocalizedNew localnews in entities.LocalizedNews.Where(ln => ln.LanguageID == LanguageID && ln.NewsID == news.NewsId).OrderByDescending(ln => ln.NewsID))
                {
                    if (localnews.Title.ContainsWord(strSearch) == true || localnews.FullContent.ContainsWord(strSearch) == true)
                    {
                        //string s1 = localnews.FullContent;
                        //string s2 = "";
                        //int ind1 = s1.IndexOf("<strong>");
                        //int ind2 = s1.IndexOf(@"</strong>");
                        //s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
                        //sbSearchData.Append("<tr><td style='width: 30px;'>");
                        //sbSearchData.Append("<br/><img src='http://ngoisao.net/News/Thu-gian/Tro-choi/2010/05/3B9CF6DD/zf.jpg'></td><td> &nbsp;&nbsp;&nbsp;</td>");
                        //sbSearchData.Append("<td style='width: 500px;'><br/><a href='' style='color:green;font-style:oblique'>" + localnews.Title + "</a><br/><div style='color:gray'>" + localnews.NewsReference.CreateSourceQuery().First().PostedDate + "</div><a href=''>" + s2 + "...</a></td></tr>");
                        list.Add(localnews);
                    }
                }
            }
            if (pageID > list.Count / ps + 1)
            {
                sbSearchData.Append("<tr>");
                sbSearchData.Append("OverLoad");
                sbSearchData.Append("</tr></table></ul>");
            }
            else
            {
                if (list.Count != 0)
                {
                    if (pi <= list.Count / ps + 1)
                    {
                        int i = 0;
                        foreach (LocalizedNew localnews in list.Skip((pi - 1) * ps))
                        {
                            if (i < ps)
                            {
                                string s1 = localnews.FullContent;
                                string s2 = "";
                                int ind1 = s1.IndexOf("<strong>");
                                int ind2 = s1.IndexOf(@"</strong>");
                                s2 = s1.Substring(ind1 + 8, ind2 - ind1 - 8);
                                sbSearchData.Append("<tr><td style='width: 30px;'>");
                                sbSearchData.Append("<br/><img src='../../Content/Images/NewsImages/" + entities.News.Where(n => n.NewsId == localnews.NewsID).FirstOrDefault().MainImage + "' width=100px height=65px></td><td> &nbsp;&nbsp;&nbsp;</td>");
                                sbSearchData.Append("<td style='width: 500px;'><br/><a href='/Articles/" + localnews.SEOUrl + "' style='color:green;font-style:oblique'>" + localnews.Title + "</a><br/><div style='color:gray'>" + localnews.NewsReference.CreateSourceQuery().First().PostedDate + "</div><a href='/Articles/" + localnews.SEOUrl + "'>" + s2 + "...</a></td></tr>");
                                i++;
                            }
                            else
                                break;
                        }

                    }
                    sbSearchData.Append("<tr>");
                    if (list.Count / ps + 1 == 1)
                    {
                        sbSearchData.Append("<div style='color:gray'>" + ViewData["first"] + "|" + ViewData["previous"] + "|" + ViewData["page"] + ": " + pageID + "/" + (list.Count / ps + 1) + "|" + ViewData["next"] + "|" + ViewData["last"] + "</div>");

                    }
                    else
                    {
                        if (pi == 1)
                        {
                            sbSearchData.Append("<div style='color:gray'>" + ViewData["first"] + "|" + ViewData["previous"] + "|" + ViewData["page"] + ": " + pageID + "/" + (list.Count / ps + 1) + "|<a href='"
                                                      + newUrl + "?search=" + strSearch + "&page=" + (pi + 1)
                                                      + "' style='color:blue' >" + ViewData["next"] + "</a>|<a href='"
                                                      + newUrl + "?search=" + strSearch + "&page=" + (list.Count / ps + 1)
                                                      + "' style='color:blue'>" + ViewData["last"] + "</a></div>");

                        }
                        else
                        {

                            if (pi == (list.Count / ps) + 1)
                            {
                                sbSearchData.Append("<div style='color:gray'><a href='"
                                   + newUrl + "?search=" + strSearch + "&page=1"
                                   + "' style='color:blue' >" + ViewData["first"] + "</a>|<a href='"
                                   + newUrl + "?search=" + strSearch + "&page=" + (pi - 1)
                                   + "' style='color:blue' >" + ViewData["previous"] + "</a>|" + ViewData["page"] + ": " + pageID + "/" + (list.Count / ps + 1) + "|" + ViewData["next"] + "|" + ViewData["last"] + "</div>");
                            }
                            else
                            {

                                sbSearchData.Append("<div style='color:gray'><a href='"
                                                          + newUrl + "?search=" + strSearch + "&page=1"
                                                          + "' style='color:blue'>" + ViewData["first"] + "</a>|<a href='"
                                                          + newUrl + "?search=" + strSearch + "&page=" + (pi - 1)
                                                          + "' style='color:blue'>" + ViewData["previous"] + "</a>|" + ViewData["page"] + ": " + pageID + "/" + (list.Count / ps + 1) + "|<a href='"
                                                          + newUrl + "?search=" + strSearch + "&page=" + (pi + 1)
                                                          + "' style='color:blue'>" + ViewData["next"] + "</a>|<a href='"
                                                          + newUrl + "?search=" + strSearch + "&page=" + (list.Count / ps + 1)
                                                          + "' style='color:blue'>" + ViewData["last"] + "</a></div>");
                            }
                        }

                        //sbSearchData.Append("<div style='color:gray'>");
                        //for (int i = 1; i <= (list.Count / ps) + 1; i++)
                        //{

                        //    if (i == pageID)
                        //    {
                        //        sbSearchData.Append(i);
                        //    }
                        //    else
                        //    {
                        //        sbSearchData.Append("<a href='"
                        //                                  + newUrl + "?search=" + strSearch + "&page=" + i
                        //                                  + "' style='color:blue'>" + i + "</a>");
                        //    }
                        //    if (i > 5)
                        //    {

                        //    }
                        //}
                        //sbSearchData.Append("</div>");
                    }
                }
                else
                {
                    sbSearchData.Append(ViewData["searchnull"] + " " + strSearch);
                }
                sbSearchData.Append("</tr></table></ul>");
            }
            ViewData["loadSearch"] = sbSearchData.ToString();
        }
    }
}
