using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class CityModel
    {
        [ReadOnly(true)]
        public int CityID { get; set; }

        public string Description { get; set; }

        public string Country { get; set; }

        public bool? IsUsed { get; set; }

    }

    public static class CityRepository
    {
        public static List<CityModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<CityModel> cities = new List<CityModel>();

            foreach (City city in entities.Cities)
            {
                CityModel ctymodel = new CityModel()
                {
                    CityID = city.CityID,
                    Country = city.CountryReference.CreateSourceQuery().First().Name,
                    Description = city.Description,
                    IsUsed = city.IsUsed
                };
                cities.Add(ctymodel);
            }
            return cities;
        }

        public static List<CityModel> GetByCityID(int cityID)
        {
            VietnamMLSEntities entity = new VietnamMLSEntities();
            List<CityModel> cities = new List<CityModel>();
            foreach (City city in entity.Cities.Where(c => c.Country.CountryID == cityID))
            {
                CityModel cityModel = new CityModel()
                {
                    CityID = city.CityID,
                    Country = city.CountryReference.CreateSourceQuery().First().Name,
                    Description = city.Description,
                    IsUsed = city.IsUsed
                };
                cities.Add(cityModel);
            }
            return cities;
        }
    }
}
