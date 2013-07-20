using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class NewsModel
    {
        [ReadOnly(true)]
        public int NewsID { get; set; }

        [DataType(DataType.Date)]
        public DateTime? PostedDate { get; set; }

        [DataType(DataType.Date)]
        public DateTime? CreatedDate { get; set; }

        public string Category { get; set; }

        public string User { get; set; }

        public bool IsApproved { get; set; }

        public string ParentCategory { get; set; }

        public string City { get; set; }

        public string MainImage { get; set; }
    }

    public static class NewsModelReposiroty
    { 
        public static List<NewsModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<NewsModel> News = new List<NewsModel>();

            foreach (News n in entities.News)
            {
                NewsModel NewsModel = new NewsModel()
                {
                    NewsID = n.NewsId,
                    PostedDate = n.PostedDate,
                    CreatedDate = n.CreatedDate,
                    IsApproved = n.IsApproved,
                    City = n.CityReference.CreateSourceQuery().First().Description,
                    Category = n.CategoryReference.CreateSourceQuery().First().Description,
                    ParentCategory = n.ParentCategoryReference.CreateSourceQuery().First().Description,
                    User = n.UserReference.CreateSourceQuery().First().Username,
                    MainImage = n.MainImage
                };
                News.Add(NewsModel);
            }

            return News;
        }

        public static List<NewsModel> GetByUser(string username)
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<NewsModel> News = new List<NewsModel>();
            foreach (News n in entities.News.Where(n=>n.User.Username==username))
            {
                NewsModel NewsModel = new NewsModel()
                {
                    NewsID = n.NewsId,
                    PostedDate = n.PostedDate,
                    CreatedDate = n.CreatedDate,
                    IsApproved = n.IsApproved,
                    City = n.CityReference.CreateSourceQuery().First().Description,
                    Category = n.CategoryReference.CreateSourceQuery().First().Description,
                    ParentCategory = n.ParentCategoryReference.CreateSourceQuery().First().Description,
                    User = n.UserReference.CreateSourceQuery().First().Username,
                    MainImage = n.MainImage
                };
                News.Add(NewsModel);
            }
            return News;
        }
    }
}
