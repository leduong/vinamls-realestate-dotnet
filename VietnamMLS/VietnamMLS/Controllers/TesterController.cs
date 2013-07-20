using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace VietnamMLS.Controllers
{
    public class TesterController : Controller
    {
        //
        // GET: /Tester/

        public ActionResult Index(int year, int month, int day)
        {
            ViewData["Year"] = year;
            ViewData["Month"] = month;
            ViewData["Day"] = day;

            return View();
        }

        //
        // GET: /Tester/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Tester/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Tester/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Tester/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Tester/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
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

        //
        // GET: /Tester/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Tester/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
