using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using Telerik.Web.Mvc;

namespace VietnamMLS.Controllers
{
    public class RoleController : AdminController
    {
        //
        // GET: /Role/

        VietnamMLSEntities db = new VietnamMLSEntities();

        public ActionResult Index()
        {
            ViewData["Message"] = "Roles Index Viewer";
            return View(db.Roles);
        }

        //
        // GET: /Role/Details/5

        public ActionResult Details(int id)
        {
            ViewData["Message"] = "Detail Roles";

            try
            {
                var r = (db.Roles.First(rol => rol.RoleID == id));
                return View(r);
            }
            catch
            {
                return View("NotFound");
            }
            
        }

        //
        // GET: /Role/Create

        public ActionResult Create()
        {
            ViewData["Message"] = "Create new Roles";

            return View();
        } 

        //
        // POST: /Role/Create

        [HttpPost]
        public ActionResult Create(Role r)
        {
            ViewData["Message"] = "Create new Roles";

            if (ModelState.IsValid)
            {
                try
                {
                    // TODO: Add insert logic here
                    db.AddToRoles(r);
                    db.SaveChanges();
                    return RedirectToAction("Index");
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
        // GET: /Role/Edit/5
 
        public ActionResult Edit(int id)
        {
            ViewData["Message"] = "Edit Roles";
            if (ModelState.IsValid)
            {
                try
                {
                    var r = (db.Roles.First(rol => rol.RoleID == id));
                    return View(r);
                }
                catch
                {
                    return View("NotFound");
                }
            }
            else
                return View("NotFound");

        }

        //
        // POST: /Role/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit Roles";

            var r = db.Roles.First(ro => ro.RoleID == id);
            try
            {
                // TODO: Add update logic here
                UpdateModel(r, collection.ToValueProvider());
                
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View(r);
            }
        }

        //
        // GET: /Role/Delete/5
 
        public ActionResult Delete(int id)
        {
            ViewData["Message"] = "Delete Roles";

            Role roleToDelete = db.Roles.Where(c => c.RoleID == id).FirstOrDefault();
            return View(roleToDelete);
            
        }

        //
        // POST: /Role/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete Roles";

            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        [GridAction]
        public ActionResult GetUserOfRole(int id)
        {
            UserRoleRepository userOfRole = new UserRoleRepository();
            return View(new GridModel(userOfRole.GetAllUserByRoleID(id)));
        }
    }
}
