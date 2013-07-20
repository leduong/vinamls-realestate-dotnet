using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VietnamMLS.Models;
using System.IO;
using System.Drawing;
using Telerik.Web.Mvc;

namespace VietnamMLS.Controllers
{
    [Authorize]
    public class LanguageController : AdminController
    {
        private VietnamMLSEntities entities = new VietnamMLSEntities();

        //
        // GET: /Language/

        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Language Index Viewer";
                if (Request.IsAjaxRequest())
                {
                    return PartialView("LanguageList", entities.Languages.ToList());
                }
                return View(entities.Languages.ToList());
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }

        [GridAction]
        public ActionResult _Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Language Index Viewer";
                return View(new GridModel(entities.Languages.ToList()));
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }

        //
        // GET: /Language/Details/5

        public ActionResult Details(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Language Detail";
                Language languageToDetails = entities.Languages
                    .Where(l => l.LanguageID == id).FirstOrDefault();
                return View(languageToDetails);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // GET: /Language/Create

        public ActionResult Create()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create New Language";
                return View();
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Language/Create

        [HttpPost]
        public ActionResult Create(Language languageToCreate)
        {
            ViewData["Message"] = "Create New Language";
            if (ModelState.IsValid)
            {
                try
                {
                    entities.AddToLanguages(languageToCreate);
                    entities.SaveChanges();
                    languageToCreate.Flag = languageToCreate.LanguageID + ".jpg";
                    entities.SaveChanges();
                    // Save Image
                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                    Utilities.SaveImage(file, @"Languages\" + languageToCreate.Flag, 24, 20);
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(languageToCreate);
                }
            }
            return View(languageToCreate);
        }

        //
        // GET: /Language/Edit/5

        public ActionResult Edit(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Edit Language";
                Language languageToEdit = entities.Languages
                    .Where(l => l.LanguageID == id).FirstOrDefault();
                return View(languageToEdit);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        //
        // POST: /Language/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            ViewData["Message"] = "Edit Language";
            Language languageToEdit = entities.Languages
                .Where(l => l.LanguageID == id).FirstOrDefault();
            if (ModelState.IsValid)
            {
                try
                {
                    UpdateModel(languageToEdit);
                    entities.SaveChanges();
                    // Save Image
                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;
                    Utilities.SaveImage(file, @"Languages\" + languageToEdit.Flag, 24, 20);
                    return RedirectToAction("Index");
                }
                catch
                {
                    return View(languageToEdit);
                }
            }
            else
                return View(languageToEdit);
        }

        public ActionResult Delete(int id)
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Delete Language";
                Language languageToDelete = entities.Languages
                    .Where(l => l.LanguageID == id).FirstOrDefault();
                return View(languageToDelete);
            }
            else
            {
                ViewData["Message"] = "You must have administrator right to view this page";
                return RedirectToAction("AccessDenied", "Account");
            }
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            ViewData["Message"] = "Delete Language";
            Language languageToDelete = entities.Languages
                .Where(l => l.LanguageID == id).FirstOrDefault();
            try
            {
                // Delete flag image file
                Utilities.DeleteImage(@"Languages\" + languageToDelete.Flag);
                entities.DeleteObject(languageToDelete);
                entities.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                Response.Write("<script>alert('go to hell')</script>");
                return View(languageToDelete);
            }
        }

    }
}
