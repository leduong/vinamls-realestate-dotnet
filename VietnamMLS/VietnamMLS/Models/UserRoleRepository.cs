using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VietnamMLS.Models;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using System.ComponentModel;
using System.Web.Security;

namespace VietnamMLS.Models
{
    public class UserRoleRepository
    {

        VietnamMLSEntities db = new VietnamMLSEntities();

        public class UserDept
        {
            public int UserID { get; set; }
            [Required(ErrorMessage = "Username Required")]
            [StringLength(16, ErrorMessage = "Your username must be under 16 characters")]
            public string Username { get; set; }
            [Required(ErrorMessage = "Username Required")]
            [StringLength(16, ErrorMessage = "Your username must be under 16 characters")]
            public string Password { get; set; }
            [Required(ErrorMessage = "Username Required")]
            [RegularExpression(
                "^[a-z0-9_\\+-]+(\\.[a-z0-9_\\+-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*\\.([a-z]{2,4})$",
                ErrorMessage = "Email is not valid")]
            public string Email { get; set; }
            public int RoleID { get; set; }
            public string RoleName { get; set; }
        }
        public class RoleDept
        {
            public int RoleID { get; set; }
            public string RoleNane { get; set; }
        }

        public List<UserDept> GetAllUsers()
        {
            List<UserDept> data = new List<UserDept>();
           
            foreach (var item in db.Users)
            {
                UserDept ud = new UserDept()
                {
                    UserID = item.UserID,
                    Username = item.Username,
                    Password = item.Password,
                    Email = item.Email,
                    RoleID = item.RoleReference.CreateSourceQuery().First().RoleID,
                    RoleName = item.RoleReference.CreateSourceQuery().First().RoleName
                };
                data.Add(ud); 
            }
            return data;
        }
        public List<RoleDept> GetAllRoles()
        {
            List<RoleDept> data = new List<RoleDept>();

            foreach (var item in db.Roles)
            {
                RoleDept ud = new RoleDept()
                {
                    RoleID = item.RoleID,
                    RoleNane = item.RoleName
                    
                };
                data.Add(ud);
            }
            return data;
        }
        public List<UserDept> GetAllUserByRoleID(int id)
        {
            List<UserDept> data = new List<UserDept>();

            //var u = from us in db.Users.Where(usr => usr.RoleReference.CreateSourceQuery().First().RoleID == id)
            var u = from us in db.Users.Where(usr => usr.Role.RoleID == id)
                    select us;
            foreach (var item in u)
            {
                UserDept ud = new UserDept()
                {
                    UserID = item.UserID,
                    Username = item.Username,
                    Password = item.Password,
                    Email = item.Email,
                    RoleID = item.RoleReference.CreateSourceQuery().First().RoleID,
                    RoleName = item.RoleReference.CreateSourceQuery().First().RoleName
                };
                data.Add(ud);
            }
            return data;
        }
        public User GetUserInfo(int id)
        {
            return db.Users.First(us => us.UserID == id);
        }
        public Role GetRoleInfo(int id)
        {
            return db.Roles.First(r => r.RoleID == id);
        }
        public void AddUser(User u)
        {
            db.AddToUsers(u);
        }
        public void AddRole(Role r)
        {
            db.AddToRoles(r);
        }
        public void UpdateUser(int id)
        {

        }
        public void DeleteUser(User u)
        {
            db.DeleteObject(u);
        }
        public void DeleteRole(Role r)
        {
            db.DeleteObject(r);
        }
        public void DelAllUserByRoleID(User u)
        {
            db.DeleteObject(u);
        }
        public void SaveAction()
        {
            db.SaveChanges();
        }

        public class AccountInfoModel
        {
            public string UserId { get; set; }

            [Required]
            [DisplayName("User name")]
            public string UserName { get; set; }

            [Required]
            [DataType(DataType.EmailAddress)]
            [DisplayName("Email address")]
            public string Email { get; set; }

            [Required]
            [DisplayName("Role name")]
            public string RoleName { get; set; }
        }

        public List<AccountInfoModel> GetAllAccounts()
        {
            List<AccountInfoModel> data = new List<AccountInfoModel>();
            
            var info = (from u in db.aspnet_Users
                        join
                            m in db.aspnet_Membership on u.UserId equals m.UserId
                        where u.UserId == m.UserId
                        select new { UserId = u.UserId, UserName = u.UserName, Email = m.Email });
            
            foreach (var item in info.ToList())
            {
                AccountInfoModel ud = new AccountInfoModel()
                {
                    //UserId = item.UserName,
                    UserName = item.UserName,
                    Email = item.Email,
                    RoleName = Roles.GetRolesForUser(item.UserName).First()
                };
                data.Add(ud);
            }
            return data;
        }

        public AccountInfoModel GetAccInfo(string username)
        {
            AccountInfoModel ud = new AccountInfoModel();
            var info = (from u in db.aspnet_Users
                        join
                            m in db.aspnet_Membership on u.UserId equals m.UserId
                        where u.UserName == username && u.UserId == m.UserId
                        select new { UserId = u.UserId, UserName = u.UserName, Email = m.Email }).FirstOrDefault();
            ud.UserName = info.UserName;
            ud.Email = info.Email;
            ud.RoleName = Roles.GetRolesForUser(info.UserName).First();
            return ud;
        }

        public void RemoveAccount(string username,string rolename)
        {
            var getUserID = (from u in db.aspnet_Users
                            where u.UserName == username
                            select u).First();
            Guid id = getUserID.UserId;
            Roles.RemoveUserFromRole(username, rolename);
            aspnet_Membership membershiptodel =
                db.aspnet_Membership.Where(m => m.UserId == id).FirstOrDefault();
            db.DeleteObject(membershiptodel);
            aspnet_Users usertodel = 
                db.aspnet_Users.Where(u => u.UserId == id).FirstOrDefault();
            db.DeleteObject(usertodel);
        }
    }
}
