using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;
using VietnamMLS.ActionFilters;

namespace VietnamMLS.Controllers
{
    [Authorize]
    public class UserController : AdminController
    {
        //
        // GET: /User/
        VietnamMLSEntities db = new VietnamMLSEntities();
        UserRoleRepository urr = new UserRoleRepository();
        
        public ActionResult Index()
        {
            ViewData["Message"] = "User Index Viewer";
            return View(urr.GetAllUsers());
        }

        [GridAction]
        public ActionResult _Index()
        {
            ViewData["Message"] = "User Index Viewer";
            return View(new GridModel(urr.GetAllUsers()));
        }
        //
        // GET: /User/Details/5
        [Authorize(Roles="admin")]
        public ActionResult Details(int id)
        {
            ViewData["Message"] = "User Details";
            try
            {
                var userdetail = urr.GetUserInfo(id);
                return View(urr.GetUserInfo(id));
            }
            catch
            {
                throw new ResourceNotFoundException();
            }
            
        }

        //
        // GET: /User/Create
        [Authorize]
        public ActionResult Create()
        {
            ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
                "RoleID", "RoleName");
            ViewData["Message"] = "Edit User";
            return View();
        }

        //
        // POST: /User/Create
        
        [HttpPost, Authorize]
        [GridAction]
        public ActionResult Create(User u)
        {
            ViewData["Message"] = "Create new user";
            int id = int.Parse(Request.Form["RoleID"]);
            string uName = Request.Form["Username"];
            var uNameResult = (from un in db.Users.Where(us => us.Username == uName)
                               select un);
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    if (uNameResult.Count() != 1)
                    {
                        //ViewData["duplicateMessage"] = "";
                        u.Role = (from r in db.Roles.Where(ro => ro.RoleID == id)
                                  select r).First();
                        db.AddToUsers(u);
                        db.SaveChanges();
                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ViewData["duplicateMessage"] =
                            "This username is unavailable, please try with another name";
                        ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
                        "RoleID", "RoleName");
                        return View(u);
                    }
                }
                catch
                {
                    ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
                        "RoleID", "RoleName");
                    return View(u);
                }
            }
            else
            {
                ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
                    "RoleID", "RoleName");
                return View(u);
            }
        }
        
        //
        // GET: /User/Edit/5
 
        public ActionResult Edit(int id)
        {
            //User u = urr.GetUserInfo(id);
            User u = db.Users.Where(us => us.UserID == id).First();
            ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
                "RoleID", "RoleName", u.RoleReference.CreateSourceQuery().First().RoleID);
            ViewData["Message"] = "Edit User";
            return View(u);
        }

        //
        // POST: /User/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit User";
            //User u = urr.GetUserInfo(id);
            User u = db.Users.Where(us => us.UserID == id).First();
            //ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
            //        "RoleID", "RoleName", u.RoleReference.CreateSourceQuery().First().RoleID);
            int rID = int.Parse(Request.Form["RoleID"]);
            //var u = db.Users.First(us => us.UserID == id);
            
            //try
            //{
                // TODO: Add update logic here
                u.Role = db.Roles.Where(ro => ro.RoleID == rID).First();
                UpdateModel(u);
                db.SaveChanges();
                //urr.SaveAction();
                return View("Index");
            //}
            //catch
            //{
            //    ViewData["UserRoleList"] = new SelectList(db.Roles.ToList(),
            //        "RoleID", "RoleName", u.RoleReference.CreateSourceQuery().First().RoleID);
            //    return View(u);
            //}
        }

        //
        // GET: /User/Delete/5

        public ActionResult Delete(int id)
        {
            ViewData["Message"] = "Delete User";
            User u = urr.GetUserInfo(id);
            if (u == null)
                return View("NotFound");
            else
                return View(u);
        }

        //
        // POST: /User/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete User";
            try
            {
                // TODO: Add delete logic here
                User u = urr.GetUserInfo(id);
                urr.DeleteUser(u);
                urr.SaveAction();
                return RedirectToAction("Index");
            }
            catch
            {
                return View("NotFound");
            }
        }
    }
}
