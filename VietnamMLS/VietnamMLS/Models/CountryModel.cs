using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace VietnamMLS.Models
{
    public class CountryModel
    {
        [ReadOnly(true)]
        public int CountryID { get; set; }

        public string Name { get; set; }

        [DisplayName("Is Used")]
        public bool IsUsed { get; set; }
    }
    public static class CountryRepository
    {
        public static List<CountryModel> GetAll()
        {
            VietnamMLSEntities entities = new VietnamMLSEntities();
            List<CountryModel> countries = new List<CountryModel>();

            foreach (Country country in entities.Countries)
            {
                CountryModel countryModel = new CountryModel()
                {
                    CountryID = country.CountryID,
                    Name = country.Name,
                    IsUsed = country.IsUsed
                };
                countries.Add(countryModel);
            }
            return countries;
        }

       
    }
}

