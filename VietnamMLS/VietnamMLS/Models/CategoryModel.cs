using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;

namespace VietnamMLS.Models
{
    public class CategoryModel
    {
        [ReadOnly(true)]
        public int CategoryID { get; set; }
        public string Description { get; set; }
        [DisplayName("Is Used")]
        public bool? IsUsed     { get; set; }
        [DisplayName("Sort Order")]
        public int? SortOder { get; set; }
        public string DefaultImage { get; set; }
        public string ParentCategory { get; set; }
 
    }
    public static class CategoryRepository
    {
        public static List<CategoryModel> GetAll()
        {
            VietnamMLSEntities entity = new VietnamMLSEntities();
            List<CategoryModel> categories = new List<CategoryModel>();
            foreach (Category category in entity.Categories)
            {
                CategoryModel cateModel = new CategoryModel()
                {
                    CategoryID = category.CategoryID,
                    Description = category.Description,
                    IsUsed = category.IsUsed,
                    SortOder = category.SortOrder,
                    DefaultImage = category.DefaultImage,
                    ParentCategory = category.ParentCategoryReference.CreateSourceQuery().First().Description
                };
                categories.Add(cateModel);
            }
            return categories;
        }
        
        public static List<CategoryModel> GetByParentID(int parentID)
        {
            VietnamMLSEntities entity = new VietnamMLSEntities();
            List<CategoryModel> categories = new List<CategoryModel>();
            foreach (Category category in entity.Categories.Where(c => c.ParentCategory.ParentCategoryID == parentID))
            {
                CategoryModel cateModel = new CategoryModel()
                {
                    CategoryID = category.CategoryID,
                    Description = category.Description,
                    IsUsed = category.IsUsed,
                    SortOder = category.SortOrder,
                    DefaultImage = category.DefaultImage,
                    ParentCategory = category.ParentCategoryReference.CreateSourceQuery().First().Description
                };
                categories.Add(cateModel);
            }
            return categories;
        }        
    }

}
