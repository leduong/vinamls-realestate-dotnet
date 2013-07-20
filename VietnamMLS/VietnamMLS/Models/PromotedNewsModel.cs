using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class PromotedNewsModel
    {
        [ReadOnly(true)]
        public int NewsID { get; set; }

        [DataType(DataType.Date)]
        public DateTime StartedDate { get; set; }

        [DataType(DataType.Date)]
        public DateTime EndedDate { get; set; }

        public string Title { get; set; }

        public string Descrition { get; set; }

        public bool IsUsed { get; set; }

        public int? LevelID { get; set; }
    }

    public static class PromotedNewsRepository
    {
        public static List<PromotedNewsModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<PromotedNewsModel> pNews = new List<PromotedNewsModel>();
            string Title = "";
            foreach (PromotedNew pn in entities.PromotedNews)
            {
                Title = (from ln in entities.LocalizedNews
                         where ln.NewsID == pn.NewsID && ln.LanguageID == 1
                         select new { ln.Title }).First().Title.ToString();
                PromotedNewsModel pNewsModel = new PromotedNewsModel()
                {
                    NewsID = pn.NewsID,
                    StartedDate = pn.StartedDate,
                    EndedDate = pn.EndedDate,
                    IsUsed = pn.IsUsed,
                    LevelID = pn.LevelID,
                    Descrition = pn.Description,
                    Title = Title
                };
                pNews.Add(pNewsModel);
            }
            return pNews;
        }

        public static List<PromotedNewsModel> GetByUser(string username)
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<PromotedNewsModel> pNews = new List<PromotedNewsModel>();
            string Title = "";
            foreach (PromotedNew pn in entities.PromotedNews.Where(p=>p.News.User.Username==username))
            {
                Title = (from ln in entities.LocalizedNews
                         where ln.NewsID == pn.NewsID && ln.LanguageID == 1
                         select new { ln.Title }).First().Title.ToString();
                PromotedNewsModel pNewsModel = new PromotedNewsModel()
                {
                    NewsID = pn.NewsID,
                    StartedDate = pn.StartedDate,
                    EndedDate = pn.EndedDate,
                    IsUsed = pn.IsUsed,
                    LevelID = pn.LevelID,
                    Descrition = pn.Description,
                    Title = Title
                };
                pNews.Add(pNewsModel);
            }
            return pNews;
        }
    }
}
