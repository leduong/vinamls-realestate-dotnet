using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class ParentCategoryModel
    {
        [ReadOnly(true)]
        public int ParentCategoryID { get; set; }

        public string Description { get; set; }

        [DisplayName("Is Used")]
        public bool IsUsed { get; set; }

        [DisplayName("Sort Order")]
        public int? SortOrder { get; set; }
                
        //[UIHint("City"), Required]
        public string City { get; set; }
    }

    public static class ParentCategoryRepository
    {
        public static List<ParentCategoryModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<ParentCategoryModel> parents = new List<ParentCategoryModel>();

            foreach (ParentCategory parent in entities.ParentCategories)
            {
                ParentCategoryModel parentModel = new ParentCategoryModel()
                {
                    City = parent.CityReference.CreateSourceQuery().First().Description,
                    Description = parent.Description,
                    IsUsed = parent.IsUsed,
                    ParentCategoryID = parent.ParentCategoryID,
                    SortOrder = parent.SortOrder
                };
                parents.Add(parentModel);
            }

            return parents;
        }

        public static ParentCategoryModel GetByID(int id)
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            ParentCategory parent = entities.ParentCategories
                .Where(p => p.ParentCategoryID == id)
                .FirstOrDefault();

            return new ParentCategoryModel
            {
                City = parent.CityReference.CreateSourceQuery().First().Description,
                Description = parent.Description,
                IsUsed = parent.IsUsed,
                ParentCategoryID = parent.ParentCategoryID,
                SortOrder = parent.SortOrder
            };
        }
    }
}
