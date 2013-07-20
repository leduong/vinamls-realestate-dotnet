using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;

namespace VietnamMLS.Models
{
    public class LocalizedNewsModel
    {
        [ReadOnly(true)]
        public int NewsID { get; set; }

        [ReadOnly(true)]
        public int LanguageID { get; set; }

        public string Title { get; set; }

        [DisplayName("Language Name")]
        public string LanguageName { get; set; }
        
        public string SEOUrl{ get; set; }
        
        public string SEOKeyword { get; set; }
        
        public string SEODescription { get; set; }

        public string Tags { get; set; }
    }

    public static class LocalizedNewsRepository
    {
        public static List<LocalizedNewsModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<LocalizedNewsModel> lNews = new List<LocalizedNewsModel>();

            foreach (LocalizedNew ln in entities.LocalizedNews)
            {
                LocalizedNewsModel lNewsModel = new LocalizedNewsModel()
                {
                    NewsID = ln.NewsID,
                    LanguageID = ln.LanguageID,
                    LanguageName = ln.LanguageReference.CreateSourceQuery().First().Name,
                    Tags = ln.Tags,
                    Title = ln.Title,
                    SEODescription = ln.SEODescription,
                    SEOKeyword = ln.SEOKeyword,
                    SEOUrl = ln.SEOUrl
                };
                lNews.Add(lNewsModel);
            }

            return lNews;
        }

        public static List<LocalizedNewsModel> GetByNewsID(int NewsID)
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<LocalizedNewsModel> lNews = new List<LocalizedNewsModel>();

            foreach (LocalizedNew ln in entities.LocalizedNews.Where(ln=>ln.NewsID==NewsID))
            {
                LocalizedNewsModel lNewsModel = new LocalizedNewsModel()
                {
                    NewsID = ln.NewsID,
                    LanguageID = ln.LanguageID,
                    LanguageName = ln.LanguageReference.CreateSourceQuery().First().Name,
                    Tags = ln.Tags,
                    Title = ln.Title,
                    SEODescription = ln.SEODescription,
                    SEOKeyword = ln.SEOKeyword,
                    SEOUrl = ln.SEOUrl
                };
                lNews.Add(lNewsModel);
            }

            return lNews;
        }

        public static List<LocalizedNewsModel> GetByUser(string username)
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<LocalizedNewsModel> lNews = new List<LocalizedNewsModel>();

            foreach (LocalizedNew ln in entities.LocalizedNews.Where(ln => ln.News.User.Username == username))
            {
                LocalizedNewsModel lNewsModel = new LocalizedNewsModel()
                {
                    NewsID = ln.NewsID,
                    LanguageID = ln.LanguageID,
                    LanguageName = ln.LanguageReference.CreateSourceQuery().First().Name,
                    Tags = ln.Tags,
                    Title = ln.Title,
                    SEODescription = ln.SEODescription,
                    SEOKeyword = ln.SEOKeyword,
                    SEOUrl = ln.SEOUrl
                };
                lNews.Add(lNewsModel);
            }

            return lNews;
        }
    }
}
