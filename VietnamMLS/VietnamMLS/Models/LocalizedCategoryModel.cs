using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;

namespace VietnamMLS.Models
{
    public class LocalizedCategoryModel
    {
        [ReadOnly(true)]
        public int CategoryID { get; set; }
        public string Category { get; set; }
        [ReadOnly(true)]
        public int LanguageID { get; set; }
        public string Language { get; set; }
        public string Name { get; set; }
        public string SEOUrl { get; set; }
        public string SEOKeyword { get; set; }
        public string SEODescription { get; set; }
    }
    public static class LocalizedCategoryRepository
    {
        public static List<LocalizedCategoryModel> GetAll()
        {
            List<LocalizedCategoryModel> localcategories = new List<LocalizedCategoryModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedCategory category in entity.LocalizedCategories)
            {
                LocalizedCategoryModel model = new LocalizedCategoryModel()
                {
                    CategoryID = category.CategoryID,
                    Category = category.CategoryReference.CreateSourceQuery().First().Description,
                    LanguageID = category.LanguageID,
                    Language = category.LanguageReference.CreateSourceQuery().First().Name,
                    Name = category.Name,
                    SEOUrl = category.SEOUrl,
                    SEOKeyword = category.SEOKeyword,
                    SEODescription = category.SEODescription

                };
                localcategories.Add(model);
            }
            return localcategories;
        }


        public static List<LocalizedCategoryModel> GetByID(int id)
        {
            List<LocalizedCategoryModel> localcategories = new List<LocalizedCategoryModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedCategory category in entity.LocalizedCategories.Where(c => c.CategoryID == id))
            {
                LocalizedCategoryModel model = new LocalizedCategoryModel()
                {
                    CategoryID = category.CategoryID,
                    Category = category.CategoryReference.CreateSourceQuery().First().Description,
                    LanguageID = category.LanguageID,
                    Language = category.LanguageReference.CreateSourceQuery().First().Name,
                    Name = category.Name,
                    SEOUrl = category.SEOUrl,
                    SEOKeyword = category.SEOKeyword,
                    SEODescription = category.SEODescription

                };
                localcategories.Add(model);
            }
            return localcategories;
        }

        public static List<LocalizedCategoryModel> GetBySEOUrl(string name)
        {
            List<LocalizedCategoryModel> localcategories = new List<LocalizedCategoryModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedCategory category in entity.LocalizedCategories.Where(c => c.SEOUrl==name))
            {
                LocalizedCategoryModel model = new LocalizedCategoryModel()
                {
                    CategoryID = category.CategoryID,
                    Category = category.CategoryReference.CreateSourceQuery().First().Description,
                    LanguageID = category.LanguageID,
                    Language = category.LanguageReference.CreateSourceQuery().First().Name,
                    Name = category.Name,
                    SEOUrl = category.SEOUrl,
                    SEOKeyword = category.SEOKeyword,
                    SEODescription = category.SEODescription

                };
                localcategories.Add(model);
            }
            return localcategories;
        }

    }
}