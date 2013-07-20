using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;

namespace VietnamMLS.Controllers
{
    public class UserRoleController : Controller
    {
        //
        // GET: /UserRole/
        VietnamMLSEntities db = new VietnamMLSEntities();
        UserRoleRepository urr = new UserRoleRepository();

        public ActionResult UserIndex()
        {
            return View(urr.GetAllUsers());
        }
        [GridAction]
        public ActionResult _UserIndex()
        {
            return View(new GridModel(urr.GetAllUsers()));
        }

        public ActionResult RoleIndex()
        {
            return View(urr.GetAllRoles());
        }
        [GridAction]
        public ActionResult _RoleInxex()
        {
            return View(new GridModel(urr.GetAllRoles()));
        }

        [GridAction]
        public ActionResult GetAllUserByRoleID(int id)
        {
            return View(new GridModel(urr.GetAllUserByRoleID(id)));
        }

        //
        // GET: /UserRole/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /UserRole/Create

        public ActionResult CreateUser()
        {
            return View();
        } 

        //
        // POST: /UserRole/Create

        [HttpPost]
        [GridAction]
        public ActionResult CreateUser(User u)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    db.AddToUsers(u);
                    db.SaveChanges();
                    return RedirectToAction("UserIndex");
                }
                catch
                {
                    return View(u);
                }
            }
            else
            {
                return View(u);
            }
        }


        public ActionResult CreateRole()
        {
            return View();
        }

        //
        // POST: /UserRole/Create

        [HttpPost]
        public ActionResult CreateRole(Role r)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    db.AddToRoles(r);
                    db.SaveChanges();
                    return RedirectToAction("RoleIndex");
                }
                catch
                {
                    return View(r);
                }
            }
            else
            {
                return View(r);
            }
        }
        
        //
        // GET: /UserRole/Edit/5
 
        public ActionResult EditUser(int id)
        {
            return View();
        }

        //
        // POST: /UserRole/Edit/5

        [HttpPost]
        [GridAction]
        public ActionResult EditUser(int id, FormCollection collection)
        {
            var u = db.Users.First(us => us.UserID == id);
            try
            {
                // TODO: Add update logic here

                UpdateModel(u, collection.ToValueProvider());
                db.SaveChanges();
                return View("UserIndex");
            }
            catch
            {
                return View(u);
            }
        }

        public ActionResult EditRole(int id)
        {
            return View();
        }

        //
        // POST: /UserRole/Edit/5

        [HttpPost]
        [GridAction]
        public ActionResult EditRole(int id, FormCollection collection)
        {
            var r = db.Roles.First(ro => ro.RoleID == id);
            try
            {
                // TODO: Add update logic here

                UpdateModel(r, collection.ToValueProvider());
                db.SaveChanges();
                return View("RoleIndex");
            }
            catch
            {
                return View(r);
            }
        }

        //
        // GET: /UserRole/Delete/5
 
        public ActionResult DeleteUser(int id)
        {
            User u = urr.GetUserInfo(id);
            if (u == null)
                return View("NotFound");
            else
                return View(u);
        }

        //
        // POST: /UserRole/Delete/5

        [HttpPost]
        public ActionResult DeleteUser(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                User u = urr.GetUserInfo(id);
                urr.DeleteUser(u);
                urr.SaveAction();
                return RedirectToAction("UserIndex");
            }
            catch
            {
                return View("NotFound");
            }
        }

        public ActionResult DeleteRole(int id)
        {
            Role r = urr.GetRoleInfo(id);
            if (r == null)
                return View("NotFound");
            else
                return View(r);
        }

        //
        // POST: /UserRole/Delete/5

        [HttpPost]
        public ActionResult DeleteRole(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                Role r = urr.GetRoleInfo(id);
                urr.DeleteRole(r);
                urr.SaveAction();
                return RedirectToAction("RoleIndex");
            }
            catch
            {
                return View("NotFound");
            }
        }
    }
}
