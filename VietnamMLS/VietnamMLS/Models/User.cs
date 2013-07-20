using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using VietnamMLS.Models;

namespace VietnamMLS.Models
{
    public class EmailAttribute : RegularExpressionAttribute
    {
        //^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$
        //
        public EmailAttribute()
            : base("^[a-z0-9_\\+-]+(\\.[a-z0-9_\\+-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*\\.([a-z]{2,4})$")
        { }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class User
    {
        [Bind(Exclude = "UserID")]
        public class UserMetaData
        {
            [Required(ErrorMessage="Nhap vao Username")]
            [StringLength(16,ErrorMessage="Username it hon 16 ki tu")]
            [RegularExpression(@"[A-Za-z\s]+",ErrorMessage="Username chi bao gom ki tu a-z")]
            public string Username { get; set; }

            [Required(ErrorMessage = "Nhap vao Password")]
            [StringLength(16, ErrorMessage = "Password it hon 16 ki tu")]
            [RegularExpression(@"[A-Za-z\s]+", ErrorMessage = "Password chi bao gom ki tu a-z")]
            public string Password { get; set; }

            [Required(ErrorMessage = "Nhap vao Email")]
            [RegularExpression("^[a-z0-9_\\+-]+(\\.[a-z0-9_\\+-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*\\.([a-z]{2,4})$",
                ErrorMessage="Email khong dung")]
            //[Email(ErrorMessage = "Email khong dung")]
            public string Email { get; set; }            
        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class City
    {
        [Bind(Exclude = "CityID")]
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Decription")]
            public string Description { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class Category
    {
        [Bind(Exclude = "CategoryID")]
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Decription")]
            public string Description { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class LocalizedCategory
    {
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Ten Category")]
            public string Name { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class ParentCategory
    {
        [Bind(Exclude = "ParentCategoryID")]
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Decription")]
            public string Description { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class LocalizedParentCategory
    {
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Name")]
            public string Name { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class Language
    {
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Language Code")]
            public string LanguageCode { get; set; }

            [Required(ErrorMessage = "Nhap vao Language Name")]
            public string Name { get; set; }

        }
    }

    [MetadataType(typeof(UserMetaData))]
    public partial class Country
    {
        [Bind(Exclude = "CountryID")]
        public class UserMetaData
        {
            [Required(ErrorMessage = "Nhap vao Decription")]
            public string Name { get; set; }

        }
    }

    public partial class News
    {
        VietnamMLSEntities db = new VietnamMLSEntities();
        public bool isCreatedBy(string username)
        {
            News n = new News();
            string uID=n.UserReference.CreateSourceQuery().First().UserID.ToString();
            var info = from u in db.Users
                        where username == u.Username
                        select u;
            string id = string.Empty;
            foreach (var item in info)
            {
                id = item.UserID.ToString();
            }
            return uID.Equals(id, StringComparison.InvariantCultureIgnoreCase);
        }
    }

}
