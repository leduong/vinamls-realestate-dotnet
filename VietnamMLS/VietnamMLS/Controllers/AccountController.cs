using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using VietnamMLS.Models;
using Telerik.Web.Mvc;
using System.Runtime.Remoting.Contexts;

namespace VietnamMLS.Controllers
{
    [HandleError]
    public class AccountController : AdminController
    {

        public IFormsAuthenticationService FormsService { get; set; }
        public IMembershipService MembershipService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
            if (MembershipService == null) { MembershipService = new AccountMembershipService(); }

            base.Initialize(requestContext);
        }

        // **************************************
        // URL: /Account/LogOn
        // **************************************

        public ActionResult LogOn()
        {
            ViewData["Message"] = "Log On";
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                if (MembershipService.ValidateUser(model.UserName, model.Password))
                {
                    FormsService.SignIn(model.UserName, model.RememberMe);
                    if (!String.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        //return RedirectToAction("Index", "Home");
                        ViewData["Message"] = "Account Details";
                        return RedirectToAction("Index", "News");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "The user name or password provided is incorrect.");
                }
            }

            // If we got this far, something failed, redisplay form
            ViewData["Message"] = "Log On - Username or password is incorrect";
            return View(model);
        }

        // **************************************
        // URL: /Account/LogOff
        // **************************************

        public ActionResult LogOff()
        {
            FormsService.SignOut();

            return RedirectToRoute("localhostroute");
        }

        // **************************************
        // URL: /Account/Register
        // **************************************

        [Authorize]
        public ActionResult Register()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Create a New Account";
                ViewData["roleName"] = new SelectList(Roles.GetAllRoles(), "roleName");
                ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
                return View();
            }
            else
            {
                ViewData["Message"] = "Log On - Only administrator role have the ability to provide account";
                return RedirectToAction("LogOn", "Account");
            }
        }


        [HttpPost, Authorize]
        public ActionResult Register(RegisterModel model)
        {
            //if (HttpContext.User.IsInRole("admin"))
            //{
                //ViewData["Message"] = "Create a New Account";
                if (ModelState.IsValid)
                {
                    // Attempt to register the user
                    MembershipCreateStatus createStatus = MembershipService.CreateUser(model.UserName, model.Password, model.Email);

                    if (createStatus == MembershipCreateStatus.Success)
                    {
                        Roles.AddUserToRole(model.UserName, Request.Form["roleName"]);
                        FormsService.SignIn(model.UserName, false /* createPersistentCookie */);
                        string rname = Request.Form["roleName"];
                        var roleID = (from r in db.Roles
                                      where r.RoleName == rname
                                      select r).First();
                        int id = roleID.RoleID;
                        //foreach (var item in roleID)
                        //{
                        //    id = item.RoleID;
                        //}
                        VietnamMLS.Models.User udept = new User()
                        {
                            //UserID=model.UserName,
                            Username = model.UserName,
                            Password = model.Password,
                            Email = model.Email
                        };
                        udept.Role = db.Roles.Where(r => r.RoleID == id).First();
                        db.AddToUsers(udept);
                        db.SaveChanges();

                        //User user = db.Users.Where(u => u.Username == model.UserName).First();
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("", AccountValidation.ErrorCodeToString(createStatus));
                    }
                }

                // If we got this far, something failed, redisplay form
                ViewData["roleName"] = new SelectList(Roles.GetAllRoles(), "roleName");
                ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
                return View(model);
            //}
            //else
            //{
            //    ViewData["Message"] = "Log On - Only administrator role has the ability to provide account";
            //    return View("LogOn");
            //}
            
        }

        // **************************************
        // URL: /Account/ChangePassword
        // **************************************

        [Authorize]
        public ActionResult ChangePassword()
        {
            string uname = Request.Form["username"];
            if (uname == null)
            {
                uname = HttpContext.User.Identity.Name;
            }
            if (HttpContext.User.Identity.Name == uname || HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Change Password";
                ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
                return View();
            }
            else
            {
                ViewData["Message"] = "You can't change this user's setting";
                return View("AccessDenied");
            }
        }

        [Authorize]
        [HttpPost]
        public ActionResult ChangePassword(ChangePasswordModel model)
        {
            if (ModelState.IsValid)
            {
                if (MembershipService.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword))
                {
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
            return View(model);
        }

        // **************************************
        // URL: /Account/ChangePasswordSuccess
        // **************************************

        public ActionResult ReturnToLogOn()
        {
            ViewData["Message"] = "Log On - You must have administrator right to view this page";
            return RedirectToAction("LogOn");
        }

        [Authorize]
        public ActionResult ChangePasswordSuccess()
        {
            ViewData["Message"] = "Your password has been changed successfully";
            return View();
        }

        VietnamMLSEntities db = new VietnamMLSEntities();
        UserRoleRepository urr = new UserRoleRepository();
        
        [Authorize]
        public ActionResult Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "User Index Viewer";
                return View(urr.GetAllAccounts());
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "News Index";
                return RedirectToAction("Index", "News");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }


        [GridAction, Authorize]
        public ActionResult _Index()
        {
            if (HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "User Index Viewer";
                return View(new GridModel(urr.GetAllAccounts()));
            }
            else if (HttpContext.User.IsInRole("user"))
            {
                ViewData["Message"] = "News Index";
                return RedirectToAction("Index", "News");
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return RedirectToAction("LogOn");
            }
        }

        [Authorize]
        public ActionResult Details(string username)
        {
            if (username == null)
            {
                username = HttpContext.User.Identity.Name;
            }
            if (HttpContext.User.Identity.Name == username || HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Account details";
                try
                {
                    return View(urr.GetAccInfo(username));
                }
                catch
                {
                    ViewData["Message"] = "Account not found";
                    return View("AccountNotFound");
                }
            }
            else
            {
                ViewData["Message"] = "Log On - You must have administrator right to view this page";
                return View("LogOn");
            }
        }
        [Authorize]
        public ActionResult Edit(string username)
        //public ActionResult Edit()
        {
            if (username == null)
            {
                username = HttpContext.User.Identity.Name;
            }
            if (HttpContext.User.Identity.Name == username || HttpContext.User.IsInRole("admin"))
            {
                ViewData["Message"] = "Edit this account";
                ViewData["roleName"] = new SelectList(Roles.GetAllRoles(), "roleName");
                ViewData["username"] = username;
                //ViewData["roleName"] = Roles.GetRolesForUser(username).ToString();
                ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
                return View();
            }
            else
            {
                ViewData["Message"] = "You can't change this user's setting";
                return View("AccessDenied");
            }
        }

        [HttpPost, Authorize]
        public ActionResult Edit(string username, ChangePasswordModel model)
        {
            ViewData["Message"] = "Edit this account";
            if (username == null)
            {
                username = HttpContext.User.Identity.Name;
            }
            string rname = Roles.GetRolesForUser(username).First().ToString();
            ViewData["PasswordLength"] = MembershipService.MinPasswordLength;
            if (ModelState.IsValid)
            {
                if (MembershipService.ChangePassword(User.Identity.Name, model.OldPassword, model.NewPassword))
                {
                    string oldrole = Roles.GetRolesForUser(username).First().ToString();
                    Roles.RemoveUserFromRole(username, oldrole);
                    if (HttpContext.User.IsInRole("admin"))
                    {
                        Roles.AddUserToRole(username, Request.Form["roleName"]);
                    }
                    else
                    {
                        Roles.AddUserToRole(username, "user");
                    }
                    return RedirectToAction("ChangePasswordSuccess");
                }
                else
                {
                    ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
                }
            }
            // If we got this far, something failed, redisplay form
            return View(model);
        }
        [Authorize(Roles = "admin")]
        public ActionResult Delete(string username)
        {
            if (HttpContext.User.Identity.Name != "admin")
            {
                if (HttpContext.User.IsInRole("admin"))
                {
                    ViewData["Message"] = "Delete this acccount?";
                    VietnamMLS.Models.UserRoleRepository.AccountInfoModel accinfo =
                        urr.GetAccInfo(username);
                    if (accinfo == null)
                        return View("AccountNotFound");
                    else
                        return View(accinfo);
                }
                else
                {
                    ViewData["Message"] = "Log On - You must have administrator right to delete this account";
                    return RedirectToAction("LogOn");
                }
            }
            else
            {
                ViewData["Message"] = "Ops, this account can't never be deleted, it's in highest level";
                return View("AccessDenied");
            }
            
        }
        [HttpPost, Authorize(Roles = "admin")]
        public ActionResult Delete(string username, FormCollection collection)
        {
            if (HttpContext.User.Identity.Name != "admin")
            {
                if (HttpContext.User.IsInRole("admin"))
                {
                    ViewData["Message"] = "Delete this account";
                    try
                    {
                        VietnamMLS.Models.UserRoleRepository.AccountInfoModel accinfo =
                            urr.GetAccInfo(username);
                        urr.RemoveAccount(accinfo.UserName, accinfo.RoleName);
                        urr.SaveAction();
                        return RedirectToAction("Index");
                    }
                    catch
                    {
                        ViewData["Message"] = "Some error has occured during the transaction \n"
                            + "Please try to fill the form before posting the request";
                        VietnamMLS.Models.UserRoleRepository.AccountInfoModel accinfo =
                            urr.GetAccInfo(username);
                        return View(accinfo);
                    }
                }
                else
                {
                    ViewData["Message"] = "Log On - You must have administrator right to delete this account";
                    return RedirectToAction("LogOn");
                }
            }
            else
            {
                ViewData["Message"] = "Ops, this account can't never be deleted, it's in highest level";
                return View("AccessDenied");
            }
        }

        public ActionResult AccessDenied()
        {
            ViewData["Message"] = "You must have administrator right to view this page";
            return View("AccessDenied");
        }
    }
}
