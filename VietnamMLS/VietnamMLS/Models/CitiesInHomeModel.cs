using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class CitiesInHomeModel
    {
        [ReadOnly(true)]
        public int CityID { get; set; }

        public string Description { get; set; }

        [DisplayName("Is Default")]
        public bool? IsDefault { get; set; }

        [DisplayName("Sort Order")]
        public int? SortOrder { get; set; }
    }
    public static class CitiesInHomeRepository
    {
        public static List<CitiesInHomeModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<CitiesInHomeModel> CitiesHome = new List<CitiesInHomeModel>();

            foreach (CitiesInHome cthome in entities.CitiesInHomes)
            {
                CitiesInHomeModel citiesHomeModel = new CitiesInHomeModel()
                {
                    Description = cthome.CityReference.CreateSourceQuery().First().Description,
                    CityID = cthome.CityID,
                    IsDefault = (bool)cthome.IsDefault,
                    SortOrder = cthome.SortOrder
                };
                CitiesHome.Add(citiesHomeModel);
            }

            return CitiesHome;
        }
    }
}
