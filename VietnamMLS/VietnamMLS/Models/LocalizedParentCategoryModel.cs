using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;


namespace VietnamMLS.Models
{
    public class LocalizedParentCategoryModel
    {
        [ReadOnly(true)]
        public int ParentCategoryID { get; set; }
        public string ParentCategory { get; set; }
        [ReadOnly(true)]
        public int LanguageID { get; set; }
        public string Language { get; set; }
        public string Name { get; set; }
        public string SEOUrl { get; set; }
        public string SEOKeyword { get; set; }
        public string SEODescription { get; set; }
    }
    public static class LocalizedParentCategoryRepository
    {
        public static List<LocalizedParentCategoryModel> GetAll()
        {
            List<LocalizedParentCategoryModel> localparentcategories = new List<LocalizedParentCategoryModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedParentCategory category in entity.LocalizedParentCategories)
            {
                LocalizedParentCategoryModel model = new LocalizedParentCategoryModel()
                {
                    ParentCategoryID = category.ParentCategoryID,
                    ParentCategory = category.ParentCategoryReference.CreateSourceQuery().First().Description,
                    LanguageID = category.LanguageID,
                    Language = category.LanguageReference.CreateSourceQuery().First().Name,
                    Name = category.Name,
                    SEOUrl = category.SEOUrl,
                    SEOKeyword = category.SEOKeyword,
                    SEODescription = category.SEODescription

                };
                localparentcategories.Add(model);
            }
            return localparentcategories;
        }
        public static List<LocalizedParentCategoryModel> GetByID(int id)
        {
            List<LocalizedParentCategoryModel> localparentcategories = new List<LocalizedParentCategoryModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedParentCategory category in entity.LocalizedParentCategories.Where(lc => lc.ParentCategoryID == id))
            {
                LocalizedParentCategoryModel model = new LocalizedParentCategoryModel()
                {
                    ParentCategoryID = category.ParentCategoryID,
                    ParentCategory = category.ParentCategoryReference.CreateSourceQuery().First().Description,
                    LanguageID = category.LanguageID,
                    Language = category.LanguageReference.CreateSourceQuery().First().Name,
                    Name = category.Name,
                    SEOUrl = category.SEOUrl,
                    SEOKeyword = category.SEOKeyword,
                    SEODescription = category.SEODescription

                };
                localparentcategories.Add(model);
            }
            return localparentcategories;
        }
    }
}
