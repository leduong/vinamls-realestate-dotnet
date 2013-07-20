using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class LocalizedCityModel
    {
        [ReadOnly(true)]
        public int CityID { get; set; }
        public string Descipstion { get; set; }
        [ReadOnly(true)]
        public int LanguageID { get; set; }
        public string Language { get; set; }
        public string Name { get; set; }
        public string SEOUrl { get; set; }
        public string SEOKeyword { get; set; }
        public string SEODescription { get; set; }
    }
    public static class LocalizedCityRepository
    {
        public static List<LocalizedCityModel> GetAll()
        {
            List<LocalizedCityModel> localcities = new List<LocalizedCityModel>();
            VietnamMLSEntities entity = new VietnamMLSEntities();
            foreach (LocalizedCity city in entity.LocalizedCities)
            {
                LocalizedCityModel model = new LocalizedCityModel()
                {
                    CityID = city.CityID,
                    Descipstion = city.CityReference.CreateSourceQuery().First().Description,
                    LanguageID = city.LanguageID,
                    Language = city.LanguageReference.CreateSourceQuery().First().Name,
                    Name = city.Name,
                    SEOUrl = city.SEOUrl,
                    SEOKeyword = city.SEOKeyword,
                    SEODescription = city.SEODescription

                };
                localcities.Add(model);
            }
            return localcities;
        }
        public static List<LocalizedCityModel> GetByLocalizedCityID(int cityID)
        {
            VietnamMLSEntities entity = new VietnamMLSEntities();
            List<LocalizedCityModel> localizedcities = new List<LocalizedCityModel>();
            foreach (LocalizedCity localcity in entity.LocalizedCities.Where(c => c.City.CityID == cityID))
            {
                LocalizedCityModel model = new LocalizedCityModel()
                {
                    CityID = localcity.CityID,
                    Descipstion = localcity.CityReference.CreateSourceQuery().First().Description,
                    LanguageID = localcity.LanguageID,
                    Language = localcity.LanguageReference.CreateSourceQuery().First().Name,
                    Name = localcity.Name,
                    SEOUrl = localcity.SEOUrl,
                    SEOKeyword = localcity.SEOKeyword,
                    SEODescription = localcity.SEODescription

                };
                localizedcities.Add(model);
            }
            return localizedcities;
        }
    }
}
